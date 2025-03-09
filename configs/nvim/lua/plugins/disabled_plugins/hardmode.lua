return {
    'wikitopian/hardmode',
    config = function()
        vim.api.nvim_command("autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()")
    end
}
