local lsp = require("lsp-zero")

local attach_func = (function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    if client.name == "omnisharp" then
        -- goto with decompilation support
        vim.keymap.set("n", "gd", function() require('csharp').go_to_definition() end, opts)
    else
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    end

    vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>aa", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>ar", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>af", vim.lsp.buf.format)
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

    if client.name == "omnisharp" then
  client.server_capabilities.semanticTokensProvider.legend = {
    tokenModifiers = { "static" },
    tokenTypes = { "comment", "excluded", "identifier", "keyword", "keyword", "number", "operator", "operator", "preprocessor", "string", "whitespace", "text", "static", "preprocessor", "punctuation", "string", "string", "class", "delegate", "enum", "interface", "module", "struct", "typeParameter", "field", "enumMember", "constant", "local", "parameter", "method", "method", "property", "event", "namespace", "label", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "regexp", "regexp", "regexp", "regexp", "regexp", "regexp", "regexp", "regexp", "regexp" }
  }
    end
    if client.server_capabilities.signatureHelpProvider then
    require('lsp-overloads').setup(client, {
        -- UI options are mostly the same as those passed to vim.lsp.util.open_floating_preview
        ui = {
          border = "single",          -- The border to use for the signature popup window. Accepts same border values as |nvim_open_win()|.
          height = nil,               -- Height of the signature popup window (nil allows dynamic sizing based on content of the help)
          width = nil,                -- Width of the signature popup window (nil allows dynamic sizing based on content of the help)
          wrap = true,                -- Wrap long lines
          wrap_at = nil,              -- Character to wrap at for computing height when wrap enabled
          max_width = nil,            -- Maximum signature popup width
          max_height = nil,           -- Maximum signature popup height
          -- Events that will close the signature popup window: use {"CursorMoved", "CursorMovedI", "InsertCharPre"} to hide the window when typing
          close_events = { "CursorMoved", "BufHidden", "InsertLeave" },
          focusable = true,           -- Make the popup float focusable
          focus = false,              -- If focusable is also true, and this is set to true, navigating through overloads will focus into the popup window (probably not what you want)
          offset_x = 0,               -- Horizontal offset of the floating window relative to the cursor position
          offset_y = 0,                -- Vertical offset of the floating window relative to the cursor position
          floating_window_above_cur_line = false, -- Attempt to float the popup above the cursor position 
                                                 -- (note, if the height of the float would be greater than the space left above the cursor, it will default 
                                                 -- to placing the float below the cursor. The max_height option allows for finer tuning of this)
          silent = true,               -- Prevents noisy notifications (make false to help debug why signature isn't working)
          -- Highlight options is null by default, but this just shows an example of how it can be used to modify the LspSignatureActiveParameter highlight property
          highlight = {
            italic = true,
            bold = true,
            fg = "#ffffff",
          }
        },
        keymaps = {
          next_signature = "<C-j>",
          previous_signature = "<C-k>",
          next_parameter = "<C-l>",
          previous_parameter = "<C-h>",
          close_signature = "<A-s>"
        },
        display_automatically = true -- Uses trigger characters to automatically display the signature overloads when typing a method signature
      })
  end
end)

lsp.preset("recommended")

lsp.ensure_installed({
    'rust_analyzer',
    'lua_ls',
    'clangd',
    'ltex'
})

-- lsp.configure('pyright', {
--     cmd = { 'pyright-langserver', '-v /home/anna/.venvs/', '--stdio' },
--     venvPath = "/home/anna/.venvs/",
-- })

lsp.configure('python', {
    venvPath = "/home/anna/.venvs/",
})

lsp.configure('ltex', {
    settings = {
        ltex = {
            language = "en-GB",
            dictionary = ":.ltex-ignore.json"
        },
    },
    on_attach = attach_func
})

-- install the haskell language servers via the haskell-language-server-static
-- package on the AUR. its less painful than other ways
require'lspconfig'.hls.setup{
    cmd = {"haskell-language-server-9.0.2" , "--lsp"},
    on_attach = attach_func
}

require'lspconfig'.pyright.setup{
    cmd = {"pyright-langserver" , "--stdio"},
    on_attach = attach_func
}

local luasnip = require('luasnip')

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    -- tab / shift-tab move up and down the cmp-list
    ["<Tab>"] = cmp.mapping(function(fallback)
        if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
        else
            fallback()
        end
    end, { "i", "s" }),
    ['<C-d>'] = function(fallback)
        if cmp.visible() then
            cmp.select_next_item()
        else
            fallback()
        end
    end,
    ['<C-u>'] = function(fallback)
        if cmp.visible() then
            cmp.select_prev_item()
        else
            fallback()
        end
    end,
    ['<C-b>'] = function(fallback)
        if cmp.visible() then
            cmp.scroll_docs(-4)
        else
            fallback()
        end
    end,
    ['<C-f>'] = function(fallback)
        if cmp.visible() then
            cmp.scroll_docs(4)
        else
            fallback()
        end
    end,
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
})

lsp.setup_nvim_cmp({
    mapping = cmp_mappings,
    select_behavior = cmp_select
})

-- lsp.set_preferences({
--     suggest_lsp_servers = false,
--     sign_icons = {
--         error = 'E',
--         warn = 'W',
--         hint = 'H',
--         info = 'I'
--     }
-- })
lsp.set_sign_icons({
  error = '✘',
  warn = '▲',
  hint = '⚑',
  info = '»'
})
lsp.on_attach(attach_func)

for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
    local default_diagnostic_handler = vim.lsp.handlers[method]
    vim.lsp.handlers[method] = function(err, result, context, config)
        if err ~= nil and err.code == -32802 then
            return
        end
        return default_diagnostic_handler(err, result, context, config)
    end
end

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})

require("trouble").setup({
  cmd = "Trouble",
    keys = {
    {
      "<leader>sd",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
  },
  modes = {
    mydiags = {
      mode = "diagnostics", -- inherit from diagnostics mode
      filter = {
        any = {
          buf = 0, -- current buffer
          {
            severity = vim.diagnostic.severity.ERROR, -- errors only
            -- limit to files in the current project
            function(item)
              return item.filename:find((vim.loop or vim.uv).cwd(), 1, true)
            end,
          },
        },
      },
      preview = {
        type = "split",
        relative = "win",
        position = "right",
        size = 0.3,
      },
    }
  },
})

require('mason').setup()
require('csharp').setup()

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function (args)
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = args.buf,
      callback = function()

        -- Format the code before you run fix usings
        vim.lsp.buf.format({ timeout = 1000, async = false })

        -- If the file is C# then run fix usings
        if vim.bo[0].filetype == "cs" then
          require("csharp").fix_usings()
        end
      end,
    })
  end
})
