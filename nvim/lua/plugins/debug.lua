return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()

      vim.keymap.set('n', '<leader>db', function() dap.toggle_breakpoint() end, { desc = 'Toggle breakpoint' })
      vim.keymap.set('n', '<leader>dc', function() dap.continue() end, { desc = 'Start debugging' })
      vim.keymap.set('n', '<leader>dn', function() dap.step_over() end, { desc = 'Step over' })
      vim.keymap.set('n', '<leader>dO', function() dap.step_out() end, { desc = 'Step out ' })
      vim.keymap.set('n', '<leader>di', function() dap.step_into() end, { desc = 'Step into' })
      vim.keymap.set('n', '<leader>ds', function() dap.stop() end, { desc = 'Stop debugging' })
      vim.keymap.set('n', '<leader>dq', function()
        dap.disconnect({ terminateDebugger = true })
        dapui.close()
      end, { desc = 'Quit debugging' })
      vim.keymap.set('n', '<leader>dt', function() dapui.toggle() end, { desc = 'Toggle dap-ui' })

      vim.fn.sign_define('DapStopped', { text = '󰁕 ', texthl = "e0af68", linehl = "373640" })
      vim.fn.sign_define('DapBreakpoint', { text = ' ' })
      vim.fn.sign_define('DapBreakpointCondition', { text = ' ' })
      vim.fn.sign_define('DapBreakpointRejected', { text = ' ', texthl = 'db4b4b' })
      vim.fn.sign_define('DapLogPoint', { text = '.>' })

      dap.adapters.coreclr = {
        type = "executable",
        command = "netcoredbg",
        args = { "--interpreter=vscode" }
      }

      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "launch - netcoredbg",
          request = "launch",
          program = function()
            local csproj_handle = io.popen('ls *.csproj')
            if csproj_handle == nil then
              return vim.fn.input('Path to dll ', vim.fn.getcwd() .. '/bin/Debug', 'file')
            end
            local csproj_file = csproj_handle:read("*a"):gsub("\n", "");
            csproj_handle:close()
            local project_name = csproj_file:gsub("%.csrpoj", "")

            local is_function = io.open('host.json') ~= nil

            local dll_path
            if is_function then
              dll_path = 'bin/output/' .. project_name .. '.dll'
            else
              local framework_handle = io.popen('ls bin/Debug/')
              local framework = 'net8.0';
              if framework_handle ~= nil then
                local framework_result = framework_handle:read("*a")
                framework_handle:close()
                framework = vim.split(framework_result, "\n")[1]
              end

              dll_path = 'bin/Debug/' .. framework .. '/' .. project_name .. '.dll'
            end
            return dll_path
          end,
          env = {
            ASPNETCORE_ENVIRONMENT = 'Development'
          },
        },
      }

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
    end
  }
}
