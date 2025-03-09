#!/usr/bin/env python
import sys
import subprocess
import argparse
from pathlib import Path
import platform
import traceback
import shutil
import contextlib
import traceback
import urllib.request
import zipfile
import tarfile

## TODO: Ensure all data paths are used in the configs
## TODO: Check old configurations of nvim (online) and update the configs

HOME = Path('~').expanduser()
THIS_DIR = Path(__file__).parent
INSTALL_DIR = HOME / '.mydotfiles'
CONFIG_DIR = INSTALL_DIR / 'configs'
BACKUP_DIR = INSTALL_DIR / 'backups'
README_FILE = INSTALL_DIR / 'README'
INSTALL_FILE = INSTALL_DIR / 'install.py'
UNINSTALL_FILE = INSTALL_DIR / 'uninstall.py'
README_MSG = """Do NOT delete this folder. Instead use
 'python dotfiles.py --uninstall'
to remove dotfiles installation.
"""
BASHRC = HOME / '.bashrc'
BASHRC_CMD = f"""# <<< bashrc_mine start
if [ -f {CONFIG_DIR / ".bashrc_mine"} ]; then
    source {CONFIG_DIR / ".bashrc_mine"}
fi
PS1="\[\033[01;34m\]\w\[\033[00m\]\$ "
# >>> bashrc_mine end
"""

CONFIG_FILES = [
    {"source": "gitconfig", "link": ".gitconfig"},
    {"source": "nvim", "link": ".config/nvim"},
    {"source": "tmux.conf", "link": ".tmux.conf"},
    {"source": "Xresources", "link": ".Xresources"},
    {"source": "bashrc_mine.sh", "link": ".bashrc_mine"},
    {"source": "inputrc", "link": ".inputrc"},
    {"source": "condarc", "link": ".condarc"},
]

DATA_DIRS = {
    "nvim_all": HOME / ".nvim-data",
    "nvim_sessions": HOME / ".nvim-data/sessions",
    "nvim_undodir": HOME / ".nvim-data/undodir",
    "tmux_plugins": HOME / ".tmux",
}

def is_windows():
    return platform.uname().system == "Windows"

def is_linux():
    return platform.uname().system == "Linux"

if is_windows():
    print('[Installer] Windows not supported yet')
    sys.exit(1)

@contextlib.contextmanager
def working_directory(path):
    """Changes working directory and returns to previous on exit."""
    prev_cwd = Path.cwd()
    os.chdir(path)
    try:
        yield
    finally:
        os.chdir(prev_cwd)

def clone_git_repo(url, dst_dir, new_name=''):
    dst_dir = Path(dst_dir)
    dst_dir.mkdir(exist_ok=True, parents=True)
    if new_name:
        dst_dir = dst_dir / new_name
    else:
        dst_dir = dst_dir / url.split("/")[-1].replace(".git", "")
    run(f"git clone {url} {dst_dir}")

class InstallError(Exception):
    pass

def run(cmd):
    try:
        print("[Installer] " + cmd)
        subprocess.run(cmd, shell=True, stderr=subprocess.STDOUT, stdout=sys.stdout, check=True)
    except subprocess.CalledProcessError as e:
        raise InstallError(f"Error running command: {cmd}") from e


def rm_file(file_path):
    file_path = Path(file_path)
    if not file_path.exists():
        return
    if is_windows():
        run(f"del /F /Q {file_path}")
    elif is_linux():
        run(f"rm -f {file_path}")

def rm_dir(dir_path):
    dir_path = Path(dir_path)
    if not dir_path.exists():
        return
    if is_windows():
        run(f"rmdir /S /Q {dir_path}")
    elif is_linux():
        run(f"rm -rf {dir_path}")

def copyanything(src, dst):
    if src.is_dir():
        if dst.exists():
            rm_dir(dst)
        shutil.copytree(src, dst)
    elif src.is_file():
        if dst.exists():
            rm_file(dst)
        if not dst.parent.exists():
            dst.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(src, dst)

def deleteanything(t):
    t = Path(t)
    if t.is_dir():
        rm_dir(t)
    elif t.is_file():
        rm_file(t)

def patch_bashrc():
    # First unpatch bashrc to remove the previous patch
    unpatch_bashrc()

    # find the conda initialization block
    conda_str = "# >>> conda initialize >>>"
    with open(BASHRC, 'r') as f:
        lines = f.readlines()
    start_idx = None
    for i, line in enumerate(lines):
        if conda_str in line:
            start_idx = i
            break
    if start_idx is None:
        start_idx = len(lines)
    cmd = ["\n"] + [x+ '\n' for x in BASHRC_CMD.strip().split('\n')] +['\n']
    lines = lines[:start_idx] + cmd + lines[start_idx:]
    with open(BASHRC, 'w') as f:
        f.writelines(lines)

def unpatch_bashrc():
    print("[Installer] Unpatching bashrc")
    with open(BASHRC, 'r') as f:
        lines = f.readlines()
    # find indices where the patch starts and ends
    start_idx = None
    start_string = BASHRC_CMD.strip().split('\n')[0]
    end_idx = None
    end_string = BASHRC_CMD.strip().split('\n')[-1]
    for i, line in enumerate(lines):
        if start_string in line:
            start_idx = i
        if end_string in line:
            end_idx = i
    if (start_idx and (not end_idx)) or ((not start_idx) and end_idx):
        raise InstallError('Malformed bashrc patch. Could not remove patch.')
    if start_idx is None:
        return
    lines = lines[:start_idx-1] + lines[end_idx+2:]
    with open(BASHRC, 'w') as f:
        f.writelines(lines)


def install_tmux_plugins():
    TPM_DIR = HOME / '.tmux/plugins/tpm'
    if TPM_DIR.exists():
        print("[Installer] Removing existing tmux plugins")
        shutil.rmtree(TPM_DIR)
    clone_git_repo("https://github.com/tmux-plugins/tpm", HOME / ".tmux/plugins")
    try:
        run("tmux kill-session -t tmp_for_install")
    except InstallError:
        pass

    run("tmux new -d -s tmp_for_install && "
        "tmux source ~/.tmux.conf && "
        "~/.tmux/plugins/tpm/bin/install_plugins && "
        "wait $! && "
        "tmux kill-session -t tmp_for_install"
    )


def create_backups_and_delete(opt):
    print("[Installer] Creating backups and deleting existing files")
    if not BACKUP_DIR.exists():
        BACKUP_DIR.mkdir(parents=True, exist_ok=True)
    for fdict in CONFIG_FILES:
        link = HOME / fdict["link"]
        backup = BACKUP_DIR / fdict["link"]
        if backup.exists():
            # Do not overwrite existing backups
            continue
        if link.exists():
            print(f"[Installer] Backing up {link}")
            copyanything(link, backup)
            deleteanything(link)


def restore_backups():
    print("[Installer] Restoring backups")
    for fdict in CONFIG_FILES:
        link = HOME / fdict["link"]
        backup = BACKUP_DIR / fdict["link"]
        if backup.exists():
            print(f"[Installer] Restoring {link}")
            deleteanything(link)
            copyanything(backup, link)

def uninstall():
    print("[Installer] Uninstalling.")
    unpatch_bashrc()
    if not INSTALL_DIR.exists():
        print("[Installer] No installation found. Exiting")
    else:
        print("[Installer] Found installation. Uninstalling")

    restore_backups()

    deleteanything(INSTALL_DIR)

    print("[Installer] Uninstall done")
    print("[Installer] You may want to remove the following data directories manually:")
    for d in DATA_DIRS.values():
        if d.exists():
            print(f"[Installer]  -- {d}")

def create_data_dirs():
    print("[Installer] Creating data directories")
    for d in DATA_DIRS.values():
        if not d.exists():
            print(f"[Installer] Creating {d}")
            d.mkdir(parents=True, exist_ok=True)

def delete_data_dirs(dirs):
    if not dirs:
        return
    for k in dirs:
        d = DATA_DIRS[k]
        if d.exists():
            print(f"[Installer] Deleting {d}")
            shutil.rmtree(d)

def create_link(t, l):
    if l.exists():
        print(f"[Installer] Removing existing link {l}")
        deleteanything(l)
    print(f"[Installer] Creating link {l} -> {t}")
    if is_windows():
        run(f"mklink {l} {t}")
    elif is_linux():
        run(f"ln -s {t} {l}")

def install(opt):
    print("[Installer] Installation started")
    if not INSTALL_DIR.exists():
        print("[Installer] Creating installation directories")
        INSTALL_DIR.mkdir(parents=True, exist_ok=True)

    create_data_dirs()
    create_backups_and_delete(opt)

    print("[Installer] Patching bashrc")
    patch_bashrc()

    print("[Installer] Copying configurations")
    # Do a clean install
    if CONFIG_DIR.exists():
        shutil.rmtree(CONFIG_DIR)
    CONFIG_DIR.mkdir(parents=True, exist_ok=True)
    for fdict in CONFIG_FILES:
        name, link_name = fdict["source"], fdict["link"]
        print(f"[Installer] Installing {name}")
        link = HOME / link_name
        source = THIS_DIR / 'configs' / name
        target = CONFIG_DIR/ link_name
        copyanything(source, target)
        create_link(target, link)

    print("[Installer] Writing README")
    with open(README_FILE, "w") as f:
        f.write(README_MSG)


    print("[Installer] Copying install.py and uninstall.py")
    copyanything(Path(__file__), INSTALL_FILE)
    copyanything(THIS_DIR / "uninstall.py", UNINSTALL_FILE)
    print("[Installer] Installation done")

APT_REPOS_REMOVE = [
'ppa:neovim-ppa/stable',
]

APT_REPOS_ADD = [
'ppa:neovim-ppa/unstable',
]

APT_INSTALLS = [
'ripgrep',
'fd-find',
'python-is-python3',
'npm',
'neovim',
'build-essential',
'cmake',
]

def do_apt_installs():
    print("[Installer] Removing apt repositories")
    for repo in APT_REPOS_REMOVE:
        run(f"sudo add-apt-repository --remove {repo}")
    print("[Installer] Adding apt repositories")
    for repo in APT_REPOS_ADD:
        run(f"sudo add-apt-repository {repo}")
    print("[Installer] Updating apt")
    run("sudo apt update")
    print("[Installer] Installing apt packages")
    pkgs = ' '.join(APT_INSTALLS)
    run(f"sudo apt install -y {pkgs}")


def parse_args():
    parser = argparse.ArgumentParser()

    parser.add_argument(
        "--uninstall",
        action="store_true",
        help="If True, only uninstalls."
    )

    parser.add_argument(
        "--rm_data",
        type=str,
        nargs="+",
        default=[],
        choices=list(DATA_DIRS.keys()) + ['all'],
        help="Data to be removed.",
    )

    parser.add_argument(
        "--install_tmux_plugins",
        action="store_true",
        help="Whether to install tmux plugins",
    )
    parser.add_argument(
        "--do_apt_installs",
        action="store_true",
        help="Whether to install apt packages",
    )
    parser.add_argument(
        "--fonts",
        action="store_true",
        help="Whether to install fonts",
    )
    opt = parser.parse_args()
    opt.rm_data = set(opt.rm_data)
    if 'all' in opt.rm_data:
        opt.rm_data = set(DATA_DIRS.keys())
    unique_options = [opt.uninstall, opt.rm_data, opt.install_tmux_plugins, opt.do_apt_installs]
    if sum(bool(x) for x in unique_options) > 1:
        raise ValueError("Only one of --uninstall, --rm_data, --install_tmux_plugins --do_apt_installs can be set.")
    return opt

def download_and_extract_zip(url, target_dir, delete_after=False):
    target_dir = Path(target_dir)
    target_dir.mkdir(exist_ok=True, parents=True)
    filename = target_dir / Path(url).name
    if not filename.exists():
        print(f"Downloading {url} ...")
        urllib.request.urlretrieve(url, filename)
    else:
        print(f"Using existing file {filename}")
    print(f"Extracting {filename} ...")
    if str(filename).endswith("tar.gz"):
        with tarfile.open(filename, "r:gz") as so:
            so.extractall(path=target_dir)
    else:
        with zipfile.ZipFile(filename, "r") as zip_ref:
            zip_ref.extractall(target_dir)
    if delete_after:
        filename.unlink()

def install_fonts():
    print("[Installer] Installing fonts")
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/RobotoMono.zip"
    target_dir = HOME / ".fonts/RobotoMono"
    if target_dir.exists():
        shutil.rmtree(target_dir)
    target_dir.mkdir(exist_ok=True, parents=True)
    download_and_extract_zip(url, target_dir, delete_after=True)
    run("fc-cache -f -v")
    print("[Installer] Fonts installed")
    print("[Installer] You may want to set the font in your terminal emulator to 'RobotoMono Nerd Font'")


def main():
    opt = parse_args()
    if opt.uninstall:
        uninstall()
    elif opt.install_tmux_plugins:
        print("[Installer] Installing tmux plugins")
        install_tmux_plugins()
    elif opt.rm_data:
        delete_data_dirs(opt.rm_data)
    elif opt.do_apt_installs:
        do_apt_installs()
    elif opt.fonts:
        install_fonts()
    else:
        install(opt)

if __name__ == '__main__':
    try:
        main()
    except InstallError as e:
        traceback.print_exc()
        print('[Installer] Installation failed')
        sys.exit(1)
    print('[Installer] Installation successful')

