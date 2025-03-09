local function cfg()
    require("bufferline").setup{}
end
return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = cfg,
}
