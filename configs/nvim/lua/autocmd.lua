local vim = vim
local api = vim.api

-- Taken from https://github.com/norcalli/nvim_utils
local function nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        api.nvim_command("augroup " .. group_name)
        api.nvim_command("autocmd!")
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten {"autocmd", def}, " ")
            api.nvim_command(command)
        end
        api.nvim_command("augroup END")
    end
end

local autocmds = {
    resize_windows_proportionally = {
        {"VimResized", "*", [[tabdo wincmd =]]}
    },
    packer_init = {
        {"VimEnter", "*", "lua require('plugins').sync_if_not_compiled()"}
    },
    -- autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
    -- :call matchadd('Special', 'self')
    -- python_self = {
    --     {'FileType', 'python', 'syn keyword pythonSelf "self" '
    --                            .. "| highlight def link pythonSelf Operator "
    --                            .. "| syn keyword pythonTSSelf self"
    --                            .. "| highlight def link pythonTSSelf Operator " }
    -- },

    fmtopts = {
        {"BufEnter", "*", "setlocal formatoptions-=cro"}
    },
    configfiles = {
        {"BufRead,BufNewFile", "*.bd,*.ppc", "set filetype=configfile"}
    },
    -- coc
    coc_highlight = {
        {"CursorHold", "*", "silent call CocActionAsync('highlight')"}
    }
}

nvim_create_augroups(autocmds)
