vim.g.ale_linters = {
    javascript = {'eslint'},
    python = {'flake8'},
    tex = {'chktex'},
    css = {'stylelint'},
}

vim.g.ale_fixers = {
    lua = {'lua-format'},
    python = {'black'},
    javascript = {'prettier'},
    css = {'prettier'},
}

vim.g.ale_javascript_prettier_options = '--single-quote --trailing-comma es5'
vim.g.ale_lua_lua_format_executable = vim.fn.expand("$HOME/.luarocks/bin/lua-format")
vim.g.ale_lua_lua_format_options = "--column-limit=88"
-- vim.g.ale_python_black_options = "-l 120"
-- vim.g.ale_python_black_options = "-S -l 79"
vim.g.ale_python_black_options = "-S"
vim.g.ale_linter_aliases = {jsx = 'css'}
vim.g.jsx_ext_required = 0 -- Allow JSX in normal JS files
vim.g.ale_lint_delay = 50
vim.g.ale_python_flake8_options = "--ignore=E302,E203,W503,E501"
vim.g.ale_lint_on_enter = 0
vim.g.ale_lint_on_filetype_changed = 0
vim.g.ale_lint_on_save = 1
-- vim.g.ale_lint_on_text_changed = 'always'
vim.g.ale_lint_on_text_changed = 0
vim.g.ale_lint_on_insert_leave = 0
-- vim.g.ale_echo_msg_error_str = 'E'
-- vim.g.ale_echo_msg_warning_str = 'W'
vim.g.ale_echo_msg_format = '[%linter% - %code%] %s (%severity%)'
vim.g.ale_sign_error = '⊗'
vim.g.ale_sign_warning = '⚠'
vim.g.ale_sign_info = '!'
vim.g.ale_sign_hint = ''
vim.g.ale_fix_on_save = 0
vim.g.ale_fix_on_insert_leave = 0
vim.g.ale_hover_to_preview = 0
vim.g.ale_set_highlights = 0
vim.g.ale_disable_lsp = 1
-- set omnifunc=ale#completion#OmniFunc
-- nmap <silent> ]g :ALENextWrap<cr>
-- nmap <silent> [g :ALEPreviousWrap<cr>
-- nnoremap gd  :ALEGoToDefinition<cr>
-- nnoremap gr  :ALEFindReferences<cr>
-- nnoremap <leader>g  :ALEGoToDefinition<cr>
-- nnoremap <leader>r  :ALEFindReferences<cr>

local ale_diagnostic_severity_map = {
    [vim.lsp.protocol.DiagnosticSeverity.Error] = "⊗",
    [vim.lsp.protocol.DiagnosticSeverity.Warning] = "",
    [vim.lsp.protocol.DiagnosticSeverity.Information] = "!",
    [vim.lsp.protocol.DiagnosticSeverity.Hint] = ""
}

vim.lsp.diagnostic.original_clear = vim.lsp.diagnostic.clear
vim.lsp.diagnostic.clear = function(bufnr, client_id, diagnostic_ns, sign_ns)
    vim.lsp.diagnostic.original_clear(bufnr, client_id, diagnostic_ns, sign_ns)
    -- Clear ALE
    vim.api.nvim_call_function('ale#other_source#ShowResults', {bufnr, "nvim-lsp", {}})
end

vim.lsp.diagnostic.set_signs = function(diagnostics, bufnr, _, _, _)
    if not diagnostics then return end

    local items = {}
    for _, item in ipairs(diagnostics) do
        table.insert(items, {
            nr = item.code,
            code = item.code,
            text = item.message,
            lnum = item.range.start.line + 1,
            end_lnum = item.range['end'].line,
            col = item.range.start.character + 1,
            end_col = item.range['end'].character,
            type = ale_diagnostic_severity_map[item.severity]
        })
    end
    vim.api.nvim_call_function('ale#other_source#ShowResults',
                               {bufnr, "nvim-lsp", items})
end
