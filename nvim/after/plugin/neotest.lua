require("neotest").setup({
    adapters = {
        require("neotest-plenary"),
        require('neotest-vstest'){
            dap = {
                -- args = { justMyCode = true },
                adapter_name = "netcoredbg",
            },
        },
        require("neotest-python"),
    },
})
