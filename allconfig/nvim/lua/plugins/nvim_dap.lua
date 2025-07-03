return {
{
  'mfussenegger/nvim-dap',
  event = 'VeryLazy',
  config = function()
    local dap = require'dap'
    dap.adapters.cppdbg = {
      id = 'cppdbg',
      type = 'executable',
      command = '/home/arcno/.local/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
    }
    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "cppdbg",
        request = "launch",
        setupCommands = {
          {
             text = '-enable-pretty-printing',
             description =  'enable pretty printing',
             ignoreFailures = false
          },
        },
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopAtEntry = true,
      },
      {
        name = 'Attach to gdbserver :1234',
        type = 'cppdbg',
        request = 'launch',
        MIMode = 'gdb',
        miDebuggerServerAddress = 'localhost:1234',
        miDebuggerPath = '/usr/bin/gdb',
        cwd = '${workspaceFolder}',
        setupCommands = {
          {
             text = '-enable-pretty-printing',
             description =  'enable pretty printing',
             ignoreFailures = false
          },
        },
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
      },
    }
  end
},
}
