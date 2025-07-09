local lsp = require("lsp-zero")

local attach_func = (function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>aa", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>ar", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>af", vim.lsp.buf.format)
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
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
lsp.configure('omnisharp', {
      settings = {
        FormattingOptions = {
          -- Enables support for reading code style, naming convention and analyzer
          -- settings from .editorconfig.
          EnableEditorConfigSupport = true,
          -- Specifies whether 'using' directives should be grouped and sorted during
          -- document formatting.
          OrganizeImports = true,
        },
        MsBuild = {
          -- If true, MSBuild project system will only load projects for files that
          -- were opened in the editor. This setting is useful for big C# codebases
          -- and allows for faster initialization of code navigation features only
          -- for projects that are relevant to code that is being edited. With this
          -- setting enabled OmniSharp may load fewer projects and may thus display
          -- incomplete reference lists for symbols.
          LoadProjectsOnDemand = false,
        },
        RoslynExtensionsOptions = {
          -- Enables support for roslyn analyzers, code fixes and rulesets.
          EnableAnalyzersSupport = true,
          -- Enables support for showing unimported types and unimported extension
          -- methods in completion lists. When committed, the appropriate using
          -- directive will be added at the top of the current file. This option can
          -- have a negative impact on initial completion responsiveness,
          -- particularly for the first few completion sessions after opening a
          -- solution.
          EnableImportCompletion = true,
          -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
          -- true
          AnalyzeOpenDocumentsOnly = true,
        },
        Sdk = {
          -- Specifies whether to include preview versions of the .NET SDK when
          -- determining which version to use for project loading.
          IncludePrereleases = true,
        },
      },
    -- enable_roslyn_analysers = true,
    -- enable_import_completion = true,
    -- organize_imports_on_format = true,
    -- enable_decompilation_support = false,
    filetypes = { 'cs', 'vb', 'csproj', 'sln', 'slnx', 'props', 'csx', 'targets' }
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
