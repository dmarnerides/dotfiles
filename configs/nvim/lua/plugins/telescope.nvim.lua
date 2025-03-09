local function setup()
    local actions = require("telescope.actions")
    local sorters = require("telescope.sorters")
    local builtin = require('telescope.builtin')

    require("telescope").load_extension("fzf")
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { noremap=true, silent=true, desc = '[Telescope] List files in current working directory (respects .gitignore)' })
    vim.keymap.set('n', '<leader>fg', builtin.git_files, { noremap=true, silent=true, desc = '[Telescope] Fuzzy search through the output of git ls-files command (respects .gitignore)' })
    vim.keymap.set('n', '<leader>fs', builtin.live_grep, { noremap=true, silent=true, desc = '[Telescope] Live grep (respects .gitignore)' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { noremap=true, silent=true, desc = '[Telescope] Buffers' })
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { noremap=true, silent=true, desc = '[Telescope] List keymaps' })
    vim.keymap.set('n', '<F1>', builtin.help_tags, { noremap=true, silent=true, desc = '[Telescope] Help tags' })

    require("telescope").setup {
        defaults = {
            prompt_prefix = "❯ ",
            selection_caret = "❯ ",
            selection_strategy = "reset",
            sorting_strategy = "ascending",
            scroll_strategy = "cycle",
            color_devicons = true,
            winblend = 0,
            layout_strategy = "flex",
            layout_config = {
                width = 0.95,
                height = 0.85,
                prompt_position = "top",
                horizontal = {
                    -- width_padding = 0.1,
                    -- height_padding = 0.1,
                    width = 0.9,
                    preview_cutoff = 60,
                    preview_width = function(_, cols, _)
                        if cols > 200 then
                            return math.floor(cols * 0.7)
                        else
                            return math.floor(cols * 0.6)
                        end
                    end
                },
                vertical = {
                    -- width_padding = 0.05,
                    -- height_padding = 1,
                    width = 0.75,
                    height = 0.85,
                    preview_height = 0.4,
                    mirror = true
                },
                flex = {
                    -- change to horizontal after 120 cols
                    flip_columns = 120
                }
            },
            mappings = {
                i = {
                    ["<C-x>"] = actions.delete_buffer,
                    ["<C-s>"] = actions.select_horizontal,
                    ["<C-v>"] = actions.select_vertical,
                    ["<C-t>"] = actions.select_tab,
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,
                    ["<S-up>"] = actions.preview_scrolling_up,
                    ["<S-down>"] = actions.preview_scrolling_down,
                    ["<C-up>"] = actions.preview_scrolling_up,
                    ["<C-down>"] = actions.preview_scrolling_down,
                    ["<Esc>"] = actions.close,
                    -- TODO: look into using 'actions.set.shift_selection'
                    ["<C-u>"] = actions.move_to_top,
                    ["<C-d>"] = actions.move_to_middle,
                    ["<C-b>"] = actions.move_to_top,
                    ["<C-f>"] = actions.move_to_bottom,
                    ["<M-q>"] = actions.send_to_qflist + actions.open_qflist,
                    ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    ["<C-y>"] = set_prompt_to_entry_value,
                    ["<C-c>"] = actions.close
                    -- ["<M-m>"] = actions.master_stack,
                    -- Experimental
                    -- ["<tab>"] = actions.toggle_selection,
                },
                n = {
                    ["<CR>"] = actions.select_default + actions.center,
                    ["<C-x>"] = actions.delete_buffer,
                    ["<C-s>"] = actions.select_horizontal,
                    ["<C-v>"] = actions.select_vertical,
                    ["<C-t>"] = actions.select_tab,
                    ["j"] = actions.move_selection_next,
                    ["k"] = actions.move_selection_previous,
                    ["<S-up>"] = actions.preview_scrolling_up,
                    ["<S-down>"] = actions.preview_scrolling_down,
                    ["<C-up>"] = actions.preview_scrolling_up,
                    ["<C-down>"] = actions.preview_scrolling_down,
                    ["<C-u>"] = actions.move_to_top,
                    ["<C-d>"] = actions.move_to_middle,
                    ["<C-b>"] = actions.move_to_top,
                    ["<C-f>"] = actions.move_to_bottom,
                    ["<C-q>"] = actions.send_to_qflist,
                    ["<M-q>"] = actions.send_to_qflist + actions.open_qflist,
                    ["<C-c>"] = actions.close,
                    ["<Esc>"] = actions.close,
                    ["<Tab>"] = actions.toggle_selection
                }
            },
            borderchars = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
            file_sorter = sorters.get_fzy_sorter,
            -- we ignore individually in M.find_files()
            -- file_ignore_patterns = {"node_modules", ".pyc"},

            file_previewer = require("telescope.previewers").vim_buffer_cat.new,
            grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
            qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
            vimgrep_arguments = {
                "rg",
                "--hidden",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case"
            }
        },
        extensions = {
            fzf = {
                fuzzy = true,                    -- false will only do exact matching
                override_generic_sorter = true,  -- override the generic sorter
                override_file_sorter = true,     -- override the file sorter
                case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
            },
        }
    }
end
return {
    "nvim-telescope/telescope.nvim",

    branch = "0.1.x",

    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-lua/popup.nvim",
        'nvim-telescope/telescope-fzf-native.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release"
        },
        "j-hui/fidget.nvim"
    },

    config = setup
}

