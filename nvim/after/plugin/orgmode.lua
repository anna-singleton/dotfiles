local org_dir = '{{nvim.org_dir}}'

function FindLast(haystack, needle)
    local i=haystack:match(".*"..needle.."()")
    if i==nil then return nil else return i-1 end
end

function GetOrgFiles ()
    local cwdContent = vim.split(vim.fn.glob(org_dir .. "/*.org"), '\n', {trimempty=true})
    local output = ""
    for _, value in ipairs(cwdContent) do
        local last_slash = FindLast(value, '/')
        local leaf = string.sub(value, last_slash+1)
        local file_name = string.sub(leaf, 1, #leaf - 4)
        if #output == 0 then
            output = output .. file_name
        else
            output = output .. "|" .. file_name
        end
    end
    return output
end

require('orgmode').setup({
    org_agenda_files = org_dir .. '/**/*',
    org_default_notes_file = org_dir .. '/refile.org',

    org_capture_templates = {
        b = {
            description = "Bug",
            template = "** TODO %? :bug:",
            target = org_dir .. "%^{Project Name|general|" .. GetOrgFiles() .. "}.org"
        },
        f = {
            description = "Feature",
            template = "** TODO %? :feature:",
            target = org_dir .. "%^{Project Name|general|" .. GetOrgFiles() .. "}.org"
        },
        t = {
            description = "Task",
            template = "** TODO %? :task:",
            target = org_dir .. "%^{Project Name|general|" .. GetOrgFiles() .. "}.org"
        }
    }
})
