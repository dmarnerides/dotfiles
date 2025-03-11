local function set_python_host_prog_and_path()
  -- Initialize variables to hold the Python interpreter and its bin directory.
  local python_path = nil
  local venv_bin_dir = nil

  -- Check for a Poetry virtual environment first.
  local poetry_path = vim.fn.trim(vim.fn.system("poetry env info --path 2>/dev/null"))
  if poetry_path ~= "" then
    local candidate = poetry_path .. "/bin/python"
    if vim.fn.filereadable(candidate) == 1 then
      python_path = candidate
      venv_bin_dir = poetry_path .. "/bin"
    end
  end

  -- If no Poetry environment is found, check the VIRTUAL_ENV environment variable.
  if not python_path then
    local venv = os.getenv("VIRTUAL_ENV")
    if venv then
      local candidate = venv .. "/bin/python"
      if vim.fn.filereadable(candidate) == 1 then
        python_path = candidate
        venv_bin_dir = venv .. "/bin"
      end
    end
  end

  -- Fall back to the system Python if no virtual environment was found.
  if not python_path then
    python_path = vim.fn.trim(vim.fn.system("which python3"))
  end

  -- Set the Neovim Python host program.
  vim.g.python3_host_prog = python_path

  -- Prepend the virtual environment's bin directory to PATH (if available)
  if venv_bin_dir then
    local current_path = vim.env.PATH or ""
    if not string.find(current_path, venv_bin_dir, 1, true) then
      vim.env.PATH = venv_bin_dir .. ":" .. current_path
    end
  end
end

-- Execute the function during startup.
set_python_host_prog_and_path()

