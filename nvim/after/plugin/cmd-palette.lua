require('cmd-palette').setup({
    { label = "Debug C# Project", cmd = "lua require('csharp').debug_project()" },
    { label = "Run C# Project",   cmd = "lua require('csharp').run_project()" },
    { label = "Fixall C# Issues", cmd = "lua require('csharp').fix_all()" },
    { label = "vscode tasks", cmd = "lua require('telescope').extensions.tasks()" },
    { label = "vscode launch", cmd = "lua require('telescope').extensions.launc()" },
})


