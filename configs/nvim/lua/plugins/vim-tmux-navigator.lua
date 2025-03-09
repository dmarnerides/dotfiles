
return {
    "christoomey/vim-tmux-navigator",
    opts = {
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
            "TmuxNavigatorProcessList",
        }
    },
    config = function()
        local remap = vim.api.nvim_set_keymap
        remap("n", "<M-p>", ":TmuxNavigatePrevious<CR>", {silent = true, desc='[Tmux] Navigate to previous pane'})
        remap("n", "<M-l>", ":TmuxNavigateRight<CR>", {silent = true, desc='[Tmux] Navigate right'})
        remap("n", "<M-k>", ":TmuxNavigateUp<CR>", {silent = true, desc='[Tmux] Navigate up'})
        remap("n", "<M-j>", ":TmuxNavigateDown<CR>", {silent = true, desc='[Tmux] Navigwwate down'})
        remap("n", "<M-h>", ":TmuxNavigateLeft<CR>", {silent = true, desc='[Tmux] Navigate left'})
        remap("n", "<M-Right>", ":TmuxNavigateRight<CR>", {silent = true, desc='[Tmux] Navigate right'})
        remap("n", "<M-Up>", ":TmuxNavigateUp<CR>", {silent = true, desc='[Tmux] Navigate up'})
        remap("n", "<M-Down>", ":TmuxNavigateDown<CR>", {silent = true, desc='[Tmux] Navigate down'})
        remap("n", "<M-Left>", ":TmuxNavigateLeft<CR>", {silent = true, desc='[Tmux] Navigate left'})
    end
}
