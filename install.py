#!/usr/bin/env python
import os
import argparse


def run_term(cmd):
    print(f"Running: {cmd}")
    os.system(cmd)


def copyanything(src, dst):
    run_term(f"cp -r {src} {dst}")


def deleteanything(t):
    run_term(f"rm -rf {t}")


INSTALL_DIR = os.path.expanduser("~/.dotfiles_install")
BACKUP_DIR = os.path.join(INSTALL_DIR, "backups")
README_FILE = os.path.join(INSTALL_DIR, "README")
INSTALL_FILE = os.path.join(INSTALL_DIR, "install.py")
UNINSTALL_FILE = os.path.join(INSTALL_DIR, "uninstall.py")

files = {
    "bash_aliases": {"source": "configs/bash_aliases.sh", "target": "~/.bash_aliases"},
    "gitconfig": {"source": "configs/gitconfig", "target": "~/.gitconfig"},
    "pytorchrc": {"source": "configs/pytorchrc", "target": "~/.pytorchrc"},
    "flake8": {"source": "configs/flake8", "target": "~/.config/flake8"},
    "condarc": {"source": "configs/condarc", "target": "~/.condarc"},
    "nvim": {"source": "configs/nvim", "target": "~/.config/nvim"},
    "vim": {"source": "configs/vimrc", "target": "~/.vimrc"},
    "tmux_conf": {"source": "configs/tmux.conf", "target": "~/.tmux.conf"},
    "tmux_plugins": {"source": "configs/tmux/plugins", "target": "~/.tmux.conf"},
    "Xresources": {"source": "configs/Xresources", "target": "~/.Xresources"},
    "agignore": {"source": "configs/agignore", "target": "~/.agignore"},
}

for f in files.values():
    f["target"] = os.path.expanduser(f["target"])
    f["source"] = os.path.abspath(f["source"])
    fname = os.path.basename(f["target"])
    if fname == "":
        raise RuntimeError(f'Remove slash from {f["target"]}')
    f["backup"] = os.path.join(BACKUP_DIR, fname)

data_dirs = {
    "nvim_all": "~/.nvim-data",
    "nvim_sessions": "~/.nvim-data/sessions",
    "nvim_undodir": "~/.nvim-data/undodir",
    "tmux_plugins": "~/.tmux",
}

data_dirs = {k: os.path.expanduser(v) for k, v in data_dirs.items()}

apt_inst_str = "sudo apt -y install "
apt_uninst_str = "sudo apt -y remove "
apt_remove_repo = "sudo add-apt-repository -y --remove "
apt_add_repo = "sudo add-apt-repository -y "
pip_install = "pip install --user --upgrade "
pip_uninstall = "pip uninstall -y "

apt_installs = [
    "curl",
    "xclip",
    "silversearcher-ag",
    "autoconf",
    "automake",
    "pkg-config",
    "xdotool",
    "okular",
    "unzip",
]


tmux_install_plugins_str = """
tmux new -d -s tmp
tmux source ~/.tmux.conf
~/.tmux/plugins/tpm/bin/install_plugins
wait $!
tmux kill-session -t tmp
"""

install_roboto_font_str = """
sudo apt install -y fonts-roboto
sudo apt-get install -y unzip
mkdir -p ~/.local/share/fonts
current=$PWD
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/RobotoMono.zip
unzip RobotoMono.zip 
rm RobotoMono.zip
cd $current
"""

TPM_LOCATION = '~/.tmux/plugins/'

tpm_install_str = f"""
current=$PWD
mkdir -p {TPM_LOCATION}
cd {TPM_LOCATION}
rm -rf tpm
git clone https://github.com/tmux-plugins/tpm.git;
cd $current
"""

readme_msg = """Do NOT delete this folder. Instead use
 'python dotfiles.py --uninstall'
to remove dotfiles installation.
"""


def create_data_dirs():
    for d in data_dirs.values():
        if not os.path.exists(d):
            os.makedirs(d)


def delete_data_dirs():
    for d in data_dirs.values():
        if os.path.exists(d):
            print(f"Deleting {d}")
            os.removedirs(d)


def remove_current():
    for fdict in files.values():
        deleteanything(fdict["target"])


def restore_backups():
    for fdict in files.values():
        t, b = fdict["target"], f["backup"]
        if os.path.exists(b):
            deleteanything(t)
            print(f"Restoring {t}")
            copyanything(b, t)


def create_backups_and_delete(opt):
    print(f"Making backup directory {BACKUP_DIR}")
    if os.path.exists(BACKUP_DIR):
        raise RuntimeError(f"Backup directory already exists? {BACKUP_DIR}")
    os.makedirs(BACKUP_DIR)
    with open(README_FILE, "w") as f:
        f.write(readme_msg)

    for key, fdict in files.items():
        t, b = fdict["target"], fdict["backup"]
        if os.path.exists(t):
            print(f"Backing up {t}")
            copyanything(t, b)
            deleteanything(t)


def uninstall(opt):
    print("Uninstalling.")
    if opt.restore_backups:
        restore_backups()
    else:
        remove_current()
    if opt.rm_data is not None:
        for d in opt.rm_data:
            datum = data_dirs[d]
            print(f"Removing data {datum}")
            deleteanything(datum)
    print("Removing installation.")
    deleteanything(INSTALL_DIR)
    print("Done")


def reinstall_neovim():
    print(">> Reinstalling neovim")
    run_term(apt_uninst_str + "neovim")
    run_term(apt_remove_repo + "ppa:neovim-ppa/stable")
    run_term(apt_remove_repo + "ppa:neovim-ppa/unstable")
    run_term(apt_add_repo + "ppa:neovim-ppa/stable")
    run_term(apt_inst_str + "neovim")


def install(opt):
    print("Installing")
    print(">> Creating installation directories")
    os.makedirs(INSTALL_DIR)
    create_data_dirs()
    print(">> Creating backups and deleting original files")
    create_backups_and_delete(opt)

    #  print(">> Running conda bash init ")
    #  run_term("conda init bash")

    print(">> Copying configurations")
    for key, fdict in files.items():
        print(f"  -- {key}")
        t, s = fdict["target"], fdict["source"]
        copyanything(s, t)

    if opt.apt_installs:
        print("---")
        print(">> Running apt uninstalls and installs")
        run_term(apt_inst_str + " ".join(apt_installs))

    if opt.nvim_installs:
        print("---")
        print(">> Installing neovim configuration")
        run_term("nvim +PackerInstall +qall")
        run_term("nvim +PackerSync +qall")

    if opt.reinstall_neovim:
        print(">> Reinstalling neovim ")
        reinstall_neovim()

    if opt.tmux_installs:
        print(">> Updating tpm git repository and installing tmux")
        run_term(tpm_install_str)
        print(">> Installing tmux ")
        run_term(tmux_install_plugins_str)

    print("---")
    print(">> Copying install.py and uninstall.py")
    thisfile = os.path.abspath(__file__)
    copyanything(thisfile, INSTALL_FILE)
    uninstallfile = os.path.join(os.path.dirname(thisfile), "uninstall.py")
    copyanything(uninstallfile, UNINSTALL_FILE)
    print("Done")


def str2bool(v):
    if v.lower() in ("yes", "true", "t", "y", "1"):
        return True
    elif v.lower() in ("no", "false", "f", "n", "0"):
        return False
    else:
        raise argparse.ArgumentTypeError("Boolean value expected.")


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--rm_data",
        type=str,
        nargs="+",
        default=[],
        choices=list(data_dirs.keys()),
        help="Data to be removed.",
    )
    parser.add_argument("--uninstall", action="store_true", help="If True, only uninstalls.")
    parser.add_argument(
        "--restore_backups",
        action="store_true",
        help="If we should restore backups when unistalling",
    )
    parser.add_argument(
        "--reinstall_neovim",
        action="store_true",
        help="Whether to (apt) uninstall neovim before installing",
    )
    parser.add_argument(
        "--nvim_installs",
        action="store_true",
        help="Whether to install nvim plugins",
    )
    parser.add_argument(
        "--tmux_installs",
        action="store_true",
        help="Whether to install tmux plugins",
    )
    parser.add_argument(
        "--apt_installs",
        action="store_true",
        help="Whether to install apt packages",
    )
    parser.add_argument("--all", action="store_true", help="Uninstall all and reinstall all")
    opt = parser.parse_args()
    opt.rm_data = set(opt.rm_data)
    if opt.all:
        opt.nvim_installs = True
        opt.tmux_installs = True
        opt.apt_installs = True
    if os.path.exists(INSTALL_DIR):
        print("Found installation. Uninstalling")
        uninstall(opt)
    if opt.uninstall:
        exit()
    else:
        install(opt)
