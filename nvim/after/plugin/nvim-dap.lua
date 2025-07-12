local dap = require('dap')

local dap_python = require("dap-python")
dap_python.setup("/home/anna/.venvs/debugvenv/bin/python")
dap_python.test_runner = 'pytest'

require('dap-cs').setup()

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
