require('gitblame').setup({
    enabled = true, -- if you want to enable the plugin
    message_template = " <author> | <date> ", -- template for the blame message, check the Message template section for more options
    date_format = "%r", -- template for the date, check Date format section for more options

})

vim.g.gitblame_display_virtual_text = 0
