local org_dir = '{{nvim.org_dir}}'

require('orgmode').setup({
    org_agenda_files = org_dir .. '/**/*',
    org_default_notes_file = org_dir .. '/refile.org',

    org_capture_templates = {
        b = {
            description = "Bug",
            template = "** TODO %? :bug:",
            target = org_dir .. "%^{Project Name|general}.org"
        },
        f = {
            description = "Feature",
            template = "** TODO %? :feature:",
            target = org_dir .. "%^{Project Name|general}.org"
        },
        t = {
            description = "Task",
            template = "** TODO %? :task:",
            target = org_dir .. "%^{Project Name|general}.org"
        }
    }
})
