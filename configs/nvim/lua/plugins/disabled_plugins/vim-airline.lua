-- TODO: Replace with lualine
-- TODO: Manage fonts (use nerd fonts)
local function cfg()
    local color_map = vim.fn["airline#themes#generate_color_map"]
    local tcol = {
        normal = 114,
        insert = 39,
        replace = 204,
        visual = 170,
        warning = 180,
        error = 204,
        white = 145,
        black = 235,
        grey = 236
    }
    local hcol = {
        -- normal = '#98C379',
        normal = '#77AA77',
        insert = '#61AFEF',
        replace = '#E06C75',
        visual = '#C678DD',
        warning = '#E5C07B',
        -- error = '#E06C75',
        error = '#D16969',
        light_grey = '#ABB2BF',
        grey = '#3E4452',
        dark_grey = '#1e1e1e',
        black = '#181818'

    }
    local group = vim.fn['airline#themes#get_highlight']('vimCommand')
    local normal_modified = {airline_c = {group[1], '', group[3], '', ''}}
    local palette = {
        accents = {red = {hcol.error, '', tcol.error, 0}},
        normal = color_map({hcol.black, hcol.normal, tcol.black, tcol.normal},
                        {hcol.light_grey, hcol.black, tcol.white, tcol.grey},
                        {hcol.normal, hcol.black, tcol.normal, tcol.black}),
        normal_modified = normal_modified,
        insert = color_map({hcol.black, hcol.insert, tcol.black, tcol.insert},
                        {hcol.light_grey, hcol.black, tcol.white, tcol.grey},
                        {hcol.insert, hcol.black, tcol.insert, tcol.black}),
        insert_modified = normal_modified,
        replace = color_map({hcol.black, hcol.replace, tcol.black, tcol.replace},
                            {hcol.light_grey, hcol.black, tcol.white, tcol.grey},
                            {hcol.replace, hcol.black, tcol.replace, tcol.black}),
        replace_modified = normal_modified,
        visual = color_map({hcol.black, hcol.visual, tcol.black, tcol.visual},
                        {hcol.light_grey, hcol.black, tcol.white, tcol.grey},
                        {hcol.visual, hcol.black, tcol.visual, tcol.black}),
        visual_modified = normal_modified,
        inactive = color_map({hcol.light_grey, hcol.grey, tcol.grey, tcol.black},
                            {hcol.light_grey, hcol.black, tcol.grey, tcol.black},
                            {hcol.light_grey, hcol.black, tcol.grey, tcol.black}),
        inactive_modified = normal_modified
    }
    local err_theme = {hcol.black, hcol.error, tcol.black, tcol.error}
    local warn_theme = {hcol.black, hcol.warning, tcol.black, tcol.warning}

    for _, val in pairs({'normal', 'insert', 'visual', 'replace'}) do
        palette[val].airline_warning = warn_theme
        palette[val .. '_modified'].airline_warning = warn_theme
        palette[val].airline_error = err_theme
        palette[val .. '_modified'].airline_error = err_theme
    end

    vim.g['airline#themes#my_airline_deus#palette'] = palette

    vim.g.airline_theme = "my_airline_deus"
    -- vim.g.airline_theme = "deus"

    vim.g.airline_powerline_fonts = 1
    vim.g["airline#extensions#tabline#enabled"] = 1
    vim.g["airline#extensions#tabline#buffer_nr_show"] = 1
    vim.g["airline#extensions#tabline#show_tabs"] = 1
    vim.g["webdevicons_enable_airline_tabline"] = 1
    vim.g["webdevicons_enable_airline_statusline"] = 0
    vim.g["airline#extensions#tabline#formatter"] = "unique_tail_improved"

    vim.g.airline_section_x = ""
    vim.g.airline_section_y = ""
    -- vim.g.airline_section_z =
    --     "%{WebDevIconsGetFileTypeSymbol()} %{airline#util#wrap(airline#parts#filetype(),0)}"
end

return {
    "vim-airline/vim-airline",
    dependencies = {
        "ryanoasis/vim-devicons",
        "vim-airline/vim-airline-themes"
    },
    config = cfg
}
