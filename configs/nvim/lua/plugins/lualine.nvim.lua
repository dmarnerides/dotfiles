local function cfg()

local colors = {
    red    = '#D16969',
    yellow = '#E5C07B',
    green  = "#56a37f",
    cyan   = '#79dac8',
    blue   = '#61AFEF',
    violet = '#d183e8',
    black  = '#181818',
    white  = '#ABB2BF',
    grey   = '#303030',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.green },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.white, bg = colors.black },
  },
  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.violet } },
  replace = { a = { fg = colors.black, bg = colors.red } },
  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.white,  bg=colors.black },
  },
}
local rightsep = ''
local leftsep = ''

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed
    }
  end
end

require('lualine').setup {
    options = {
        theme = bubbles_theme,
        component_separators = '',
        section_separators = { left = rightsep, right = leftsep },
    },
    sections = {
        lualine_a = { { 'mode', separator = { left = leftsep, right =rightsep }, right_padding = 0 } },
        lualine_b = { 'filename', {'b:gitsigns_head', icon = ''}, {'diff', source = diff_source} },
        lualine_c = {
        '%=', 'b:gitsigns_status', 'diagnostics' --[[ add your center compoentnts here in place of this comment ]]
        },
        lualine_x = {},
        lualine_y = { 'filetype'},
        lualine_z = {
        { 'location', separator = {left=leftsep, right = rightsep }, left_padding = 0 },
        },
    },
    inactive_sections = {
        lualine_a = { 'filename' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'location' },
    },
    tabline = {},
    extensions = {},
    }
end

return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = cfg,
}
