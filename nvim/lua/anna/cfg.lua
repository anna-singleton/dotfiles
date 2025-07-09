vim.opt.guicursor = ""
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.relativenumber = true
vim.opt.nu = true
vim.opt.cursorline = false
vim.opt.cc = "80"
vim.opt.wrap = false
vim.opt.signcolumn = "yes"
vim.opt.showmatch = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.cmd("set undodir=$HOME/.config/nvim/undodir") -- wont expand home otherwise
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.errorbells = false
vim.opt.scrolloff = 5
vim.opt.updatetime = 50

local git_blame = require('gitblame')

require('lualine').setup({
    options = {
        theme = 'gruvbox'
    },
    sections = {
        lualine_c = {
            'filename', { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available }
        }
    }
})

vim.opt.termguicolors = true

-- setup must be called before loading
require("gruvbox").setup({
    terminal_colors = true, -- add neovim terminal colors
    undercurl = true,
    underline = true,
    bold = true,
    italic = {
        strings = false,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
    },
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = true,    -- invert background for search, diffs, statuslines and errors
    contrast = "hard", -- can be "hard", "soft" or empty string
    palette_overrides = {},
    overrides = {},
    dim_inactive = false,
    transparent_mode = false,
})
vim.cmd [[colorscheme gruvbox]]


vim.g.better_whitespace_enabled = true
vim.g.strip_whitespace_on_save = false
vim.g.strip_whitespace_confirm = false

vim.g.suda_smart_edit = true

require("auto-session").setup {
    log_level = "error",
    auto_session_suppress_dirs = {},
}


vim.cmd [[set foldmethod=expr]]
vim.cmd [[set foldexpr=nvim_treesitter#foldexpr()]]
vim.cmd [[set nofoldenable]]

local dap = require('dap')

local dap_python = require("dap-python")
dap_python.setup("/home/anna/.venvs/debugvenv/bin/python")
dap_python.test_runner = 'pytest'

local dapui = require("dapui")
dapui.setup()

dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
end

require("neotest").setup({
    adapters = {
        require("neotest-plenary"),
        require("neotest-dotnet")({
            dap = {
                args = { justMyCode = true },
                adapter_name = "coreclr",
            },
            discovery_root = "solution"
        }),
    },
})

require("neotest").setup({
    adapters = {
        require("neotest-python")
    }
})

require('sibling-swap').setup({
    allowed_separators = {
        ',',
        ';',
        'and',
        'or',
        '&&',
        '&',
        '||',
        '|',
        '==',
        '===',
        '!=',
        '!==',
        '-',
        '+',
        ['<'] = '>',
        ['<='] = '>=',
        ['>'] = '<',
        ['>='] = '<=',
    },
    use_default_keymaps = true,
    -- Highlight recently swapped node. Can be boolean or table
    -- If table: { ms = 500, hl_opts = { link = 'IncSearch' } }
    -- `hl_opts` is a `val` from `nvim_set_hl()`
    highlight_node_at_cursor = false,
    -- keybinding for movements to right or left (and up or down, if `allow_interline_swaps` is true)
    -- (`<C-,>` and `<C-.>` may not map to control chars at system level, so are sent by certain terminals as just `,` and `.`. In this case, just add the mappings you want.)
    keymaps = {
        ['<space>.'] = 'swap_with_right',
        ['<space>,'] = 'swap_with_left',
    },
    ignore_injected_langs = false,
    -- allow swaps across lines
    allow_interline_swaps = true,
    -- swaps interline siblings without separators (no recommended, helpful for swaps html-like attributes)
    interline_swaps_without_separator = false,
    -- Fallbacs for tiny settings for langs and nodes. See #fallback
    fallback = {},
})
