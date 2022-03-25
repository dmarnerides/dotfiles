-- Recognize .tex files as latex (instead of plaintex) for syntax highlighting.
vim.g.tex_flavor="latex"
vim.g.vimtex_latexmk_build_dir = './build'
vim.g.vimtex_view_method = 'general'
vim.g.vimtex_view_general_viewer = 'okular'
vim.g.vimtex_view_general_options = '--unique file:@pdf\\#src:@line@tex'
vim.g.vimtex_view_general_options_latexmk = '--unique'
vim.g.vimtex_compiler_method = 'latexmk'
vim.g.vimtex_compiler_progname = 'nvr'
vim.g.tex_conceal = ''
vim.g.vimtex_quickfix_mode=0


-- This function still not converted to Lua
-- from https://github.com/lervag/vimtex/issues/1083#issuecomment-372930307
vim.api.nvim_exec([[
function! VimtexOpenViewer()
  " Open the viewer and/or do forward search
  VimtexView
  " Add a very small amount of sleep time to allow previous process to finish,
  " you should experiment with the exact amount. Perhaps not necessary at all.
  sleep 50m
  " Now use xdotool to focus the viewer
  if b:vimtex.viewer.xwin_id
    call system('xdotool windowactivate '.b:vimtex.viewer.xwin_id.' &')
  endif
endfunction
]], false)
vim.api.nvim_set_keymap("n", "<leader>lv", ":<c-u>call VimtexOpenViewer()<cr>", {silent = true, noremap=true})
