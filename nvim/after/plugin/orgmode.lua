local org_dir = '{{nvim.org_dir}}'

require('orgmode').setup({
    org_agenda_files = org_dir .. '/**/*',
    org_default_notes_file = org_dir .. '/refile.org',

    org_capture_templates = {
        b = {
            description = "Bug",
            template = "** :bug:",
            target = org_dir .. 'projects.org'
        },
        f = {
            description = "Feature",
            template = "** :feature:",
            target = org_dir .. 'projects.org'
        }
    }
})
