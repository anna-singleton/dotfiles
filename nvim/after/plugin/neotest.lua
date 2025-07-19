require("neotest").setup({
    adapters = {
        require("neotest-plenary"),
        require("neotest-dotnet")({
            dap = {
                args = { justMyCode = true },
                adapter_name = "netcoredbg",
            },
            discovery_root = "solution"
        }),
        require("neotest-python"),
    },
})
