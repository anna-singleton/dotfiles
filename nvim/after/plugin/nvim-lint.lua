require('lint').linters_by_ft = {
  python = {'flake8'},
}

local flake8 = require('lint').linters.flake8
flake8.args = {

    '--select',
    'E,W',
    "--format=%(path)s:%(row)d:%(col)d:%(code)s:%(text)s",
    "--no-show-source", "-" }

vim.api.nvim_create_autocmd({ "InsertLeave", "BufWrite", "TextChanged" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
