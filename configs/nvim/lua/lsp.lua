-- List the table for each language
local servers = {python = "pylsp", bash='bashls', cpp='clangd'}

-- specify settings for each language
local lang_settings = {
    python = {
        pylsp = {
            configurationSources = {"flake8"},
            plugins = {flake8 = {enabled = true}, pyflakes = {enabled = false}, pycodestyle = {enabled = false}}
        }
    }
}

-- on_attach for each client and buffer
local on_attach = function(client, bufnr)
    local opts = {noremap = true, silent = true}
    local set_key = function(a, b, c) vim.api.nvim_buf_set_keymap(bufnr, a, b, c, opts) end
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    if client.config.flags then
        client.config.flags.allow_incremental_sync = true
        client.config.flags.debounce_text_changes = 100
    end

    set_key("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
    set_key("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
    set_key("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
    set_key("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
    set_key("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>")
    set_key("v", "ga", ":<C-U>lua vim.lsp.buf.range_code_action()<CR>")
    set_key("n", "gm", "<cmd>lua vim.lsp.buf.implementation()<CR>")
    set_key("n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
    set_key("n", "gR", "<cmd>lua vim.lsp.buf.rename()<CR>")
    set_key("n", "<leader>lR", "<cmd>lua vim.lsp.buf.rename()<CR>")
    set_key("n", "<leader>K", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
    set_key("n", "<leader>k", '<cmd>lua require("lsp").peek_definition()<CR>')
    set_key("n", "[g", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
    set_key("n", "]g", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
    set_key("n", "[G", "<cmd>lua vim.lsp.diagnostic.goto_prev { wrap = false }<CR>")
    set_key("n", "]G", "<cmd>lua vim.lsp.diagnostic.goto_next { wrap = false }<CR>")
    set_key("n", "<leader>lc", "<cmd>lua vim.lsp.diagnostic.clear(0)<CR>")
    set_key("n", "<leader>lQ", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>")
    set_key("n", "<leader>ll", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")
    set_key("n", "<leader>lt", "<cmd>lua require'lsp'.virtual_text_toggle()<CR>")

    if client.resolved_capabilities.document_formatting then
        set_key("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>")
    end
    if client.resolved_capabilities.document_range_formatting then
        set_key("v", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>")
    end

    if client.resolved_capabilities.code_lens then
        set_key("n", "<leader>lL", "<cmd>lua vim.lsp.codelens.run()<CR>")
        vim.api.nvim_command [[autocmd CursorHold,CursorHoldI,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]]
    end
    -- vim.api.nvim_command [[autocmd CursorHold,CursorHoldI,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]]

    local sign_define = function(a, b) vim.fn.sign_define(a, {text = b, texthl = a, linehl = "", numhl = ""}) end
    sign_define("LspDiagnosticsSignError", "⊗")
    sign_define("LspDiagnosticsSignWarning", "")
    sign_define("LspDiagnosticsSignInformation", "!")
    sign_define("LspDiagnosticsSignHint", "")

    -- Per buffer LSP indicators control
    if vim.b.lsp_virtual_text_enabled == nil then vim.b.lsp_virtual_text_enabled = true end
    if vim.b.lsp_virtual_text_mode == nil then vim.b.lsp_virtual_text_mode = "Signs" end

    require("lsp").virtual_text_set()
    -- require("lsp").virtual_text_redraw()
end

-- enable snippet support
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Call  setup function with each language specific settings
local lspconfig = require("lspconfig")
for language, server in pairs(servers) do
    lspconfig[server].setup({capabilities = capabilities, on_attach = on_attach, settings = lang_settings[language]})
end

-- Taken from https://www.reddit.com/r/neovim/comments/gyb077/nvimlsp_peek_defination_javascript_ttserver/
local M = {}
function M.preview_location(location, context, before_context)
    -- location may be LocationLink or Location (more useful for the former)
    context = context or 10
    before_context = before_context or 5
    local uri = location.targetUri or location.uri
    if uri == nil then return end
    local bufnr = vim.uri_to_bufnr(uri)
    if not vim.api.nvim_buf_is_loaded(bufnr) then vim.fn.bufload(bufnr) end
    local range = location.targetRange or location.range
    local contents = vim.api.nvim_buf_get_lines(bufnr, range.start.line - before_context,
                                                range["end"].line + 1 + context, false)
    local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
    local _, winnr = vim.lsp.util.open_floating_preview(contents, filetype)
    vim.api.nvim_win_set_option(winnr, "cursorline", true)
    vim.api.nvim_win_set_cursor(winnr, {6, 1})
    return _, winnr
end

function M.preview_location_callback(_, method, result)
    local context = 10
    if result == nil or vim.tbl_isempty(result) then
        print("No location found: " .. method)
        return nil
    end
    if vim.tbl_islist(result) then
        _G.floating_buf, _G.floating_win = M.preview_location(result[1], context)
    else
        _G.floating_buf, _G.floating_win = M.preview_location(result, context)
    end
end

function M.peek_definition()
    -- workaround for subsequent calls with the popup visuble
    if _G.floating_win ~= nil then pcall(vim.api.nvim_win_hide, _G.floating_win) end
    if vim.tbl_contains(vim.api.nvim_list_wins(), _G.floating_win) then
        vim.api.nvim_set_current_win(_G.floating_win)
    else
        local params = vim.lsp.util.make_position_params()
        return vim.lsp.buf_request(0, "textDocument/definition", params, M.preview_location_callback)
    end
end

-- Taken from and modified:
-- https://github.com/neovim/neovim/issues/14825
function M.virtual_text_none()
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        signs = false,
        underline = false,
        update_in_insert = false,
        virtual_text = false
    })
end

function M.virtual_text_redraw()
    -- NOTE: This function might become obsolete after the merge of
    -- 'https://github.com/neovim/neovim/pull/13748', who knows !
    for _, lsp_client_id in pairs(vim.tbl_keys(vim.lsp.buf_get_clients())) do
        vim.lsp.handlers["textDocument/publishDiagnostics"](nil, "textDocument/publishDiagnostics", {
            diagnostics = vim.lsp.diagnostic.get(0, lsp_client_id),
            uri = vim.uri_from_bufnr(0)
        }, lsp_client_id)
    end
end

function M.virtual_text_set()
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        severity_sort = true,
        signs = function()
            if vim.b.lsp_virtual_text_mode == "Signs" or vim.b.lsp_virtual_text_mode == "SignsVirtualText" then
                return true
            else
                return false
            end
        end,
        underline = false,
        update_in_insert = false,
        virtual_text = function()
            if vim.b.lsp_virtual_text_mode == "VirtualText" or vim.b.lsp_virtual_text_mode == "SignsVirtualText" then
                return "{ severity_limit = 'Hint', spacing = 10 }"
            else
                return false
            end
        end
    })
end

function M.virtual_text_clear() vim.lsp.diagnostic.clear(0) end

function M.virtual_text_disable()
    vim.b.lsp_virtual_text_enabled = false
    M.virtual_text_none()
    M.virtual_text_clear()
    return
end

function M.virtual_text_enable()
    vim.b.lsp_virtual_text_mode = "SignsVirtualText"
    vim.b.lsp_virtual_text_enabled = true
    M.virtual_text_set()
    M.virtual_text_redraw()
    return
end

function M.virtual_text_only_text()
    vim.b.lsp_virtual_text_mode = "VirtualText"
    vim.b.lsp_virtual_text_enabled = true
    M.virtual_text_set()
    M.virtual_text_redraw()
    return
end

function M.virtual_text_only_signs()
    vim.b.lsp_virtual_text_mode = "Signs"
    vim.b.lsp_virtual_text_enabled = true
    M.virtual_text_set()
    M.virtual_text_redraw()
    return
end

function M.virtual_text_toggle()
    if vim.b.lsp_virtual_text_enabled == true then
        M.virtual_text_disable()
    else
        M.virtual_text_enable()
    end
end

return M
