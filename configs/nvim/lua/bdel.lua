local function warn(msg)
  vim.notify(msg, vim.log.levels.WARN)
end

local function bclose(opts)
  local bang = opts.bang        -- true if :Bclose! was used
  local buffer_arg = opts.args    -- optional buffer (name or number)
  local btarget

  if buffer_arg == "" then
    btarget = vim.fn.bufnr("%")
  elseif buffer_arg:match("^%d+$") then
    btarget = vim.fn.bufnr(tonumber(buffer_arg))
  else
    btarget = vim.fn.bufnr(buffer_arg)
  end

  if btarget < 0 then
    warn("No matching buffer for " .. buffer_arg)
    return
  end

  if not bang and vim.fn.getbufvar(btarget, "&modified") == 1 then
    warn("No write since last change for buffer " .. btarget .. " (use :Bclose!)")
    return
  end

  -- Find windows that are currently showing the target buffer.
  local wnums = {}
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == btarget then
      table.insert(wnums, win)
    end
  end

  if not vim.g.bclose_multiple and #wnums > 1 then
    warn('Buffer is in multiple windows (use ":let bclose_multiple=1")')
    return
  end

  local current_win = vim.api.nvim_get_current_win()

  -- For each window showing the target buffer, switch to an alternate buffer.
  for _, win in ipairs(wnums) do
    vim.api.nvim_set_current_win(win)
    local prevbuf = vim.fn.bufnr("#")
    if prevbuf > 0 and vim.fn.buflisted(prevbuf) == 1 and prevbuf ~= vim.fn.bufnr("%") then
      vim.cmd("buffer #")
    else
      vim.cmd("bprevious")
    end

    if btarget == vim.fn.bufnr("%") then
      -- Build list of listed buffers (except target).
      local blisted = {}
      for i = 1, vim.fn.bufnr("$") do
        if vim.fn.buflisted(i) == 1 and i ~= btarget then
          table.insert(blisted, i)
        end
      end

      -- Get those listed buffers that aren’t displayed in any window.
      local bhidden = {}
      for _, buf in ipairs(blisted) do
        if vim.fn.bufwinnr(buf) < 0 then
          table.insert(bhidden, buf)
        end
      end

      -- Choose the first available buffer.
      local bjump = -1
      if #bhidden > 0 then
        bjump = bhidden[1]
      elseif #blisted > 0 then
        bjump = blisted[1]
      end

      if bjump > 0 then
        vim.cmd("buffer " .. bjump)
      else
        if bang then
          vim.cmd("enew!")
        else
          vim.cmd("enew")
        end
      end
    end
  end

  if bang then
    vim.cmd("bdelete! " .. btarget)
  else
    vim.cmd("bdelete " .. btarget)
  end

  vim.api.nvim_set_current_win(current_win)
end

--
vim.g.bclose_multiple=1

-- Create the :Bclose command (with optional bang and buffer argument)
vim.api.nvim_create_user_command("Bclose", bclose, { bang = true, nargs = "?" })

-- Map <Leader>bd to :Bclose if plugin maps are not disabled.
vim.keymap.set("n", "<Leader>bd", ":Bclose<CR>", { silent = true , desc="[Mine] Close buffer without closing window"})

