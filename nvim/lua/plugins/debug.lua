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
      vim.fn.sign_define('DapBreakpoint', { text = ' ', texthl = "ffa07a" })
      vim.fn.sign_define('DapBreakpointCondition', { text = ' ', texthl = "00bfff" })
      vim.fn.sign_define('DapBreakpointRejected', { text = ' ', texthl = 'db4b4b' })
      vim.fn.sign_define('DapLogPoint', { text = '.>' })

      dap.adapters.coreclr = {
        type = "executable",
        command = "netcoredbg",
        args = { "--interpreter=vscode" }
      }

      local function get_dotnet_pid_fzf()
        -- Command to list dotnet processes with PID and command line
        -- pgrep -af: -a lists full command line, -f matches against full command line
        local command = "pgrep -af dotnet"

        -- Pipe the command output into fzf
        -- Customize fzf options as needed (--height, --layout, --border, etc.)
        local fzf_command = command ..
            " | fzf --height=40% --layout=reverse --prompt='Select .NET Process (Azure Func) > '"

        -- Execute the command and capture the selected line
        -- vim.fn.system() returns the stdout of the command
        print("Running FZF picker...")
        local selected_line = vim.fn.system(fzf_command)

        -- Redraw the screen after fzf closes (important!)
        vim.cmd("redraw!")

        -- Check if FZF was cancelled (empty output) or returned something
        if selected_line == nil or selected_line == "" then
          print("FZF cancelled or no process selected.")
          return nil -- Important: Return nil to cancel DAP attach
        end

        -- Extract the PID (first sequence of digits) from the selected line
        local pid_str = selected_line:match("^%s*(%d+)") -- Lua pattern to find digits at the start

        if pid_str then
          print("Selected PID: " .. pid_str)
          return tonumber(pid_str) -- Return the PID as a number
        else
          vim.notify(
            "Could not parse PID from selected line: " .. selected_line,
            vim.log.levels.ERROR
          )
          return nil -- Cancel attach if PID couldn't be parsed
        end
      end

      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "launch - netcoredbg",
          request = "launch",
          program = function()
            return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
            -- local csproj_handle = io.popen('ls *.csproj')
            -- if csproj_handle == nil then
            --   return vim.fn.input('Path to dll ', vim.fn.getcwd() .. '/bin/Debug', 'file')
            -- end
            -- local csproj_file = csproj_handle:read("*a"):gsub("\n", "");
            -- csproj_handle:close()
            -- local project_name = csproj_file:gsub("%.csrpoj", "")
            --
            -- local is_function = io.open('Functions/host.json') ~= nil
            --
            -- local dll_path
            -- if is_function then
            --   dll_path = 'bin/output/' .. project_name .. '.dll'
            -- else
            --   local framework_handle = io.popen('ls bin/Debug/')
            --   local framework = 'net8.0';
            --   if framework_handle ~= nil then
            --     local framework_result = framework_handle:read("*a")
            --     framework_handle:close()
            --     framework = vim.split(framework_result, "\n")[1]
            --   end
            --
            --   dll_path = 'bin/Debug/' .. framework .. '/' .. project_name .. '.dll'
            -- end
            -- return dll_path
          end,
          env = {
            ASPNETCORE_ENVIRONMENT = 'Development'
          },
        },
        -- {
        --   type = "coreclr", -- Matches the adapter type (usually 'coreclr' for netcoredbg)
        --   name = "Attach to Azure Function (.NET) - FZF",
        --   request = "attach",
        --   -- Use the fzf function to get the processId
        --   processId = get_dotnet_pid_fzf,
        --   -- Optional: Specify the working directory if needed for symbol loading
        --   -- cwd = vim.fn.getcwd(), -- Or specify the exact project path
        --   justMyCode = false, -- Set to false to debug into framework code
        -- },
        {
          type = "coreclr",
          name = "Attach to Azure Function (.NET)",
          request = "attach",
          processId = function()
            local pid = vim.fn.input("Enter PID of the dotnet process to attach to: ")
            if pid == "" then return nil end
            return tonumber(pid)
          end,
          justMyCode = false,
        }
      }

      dap.listeners.after.event_initialized.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
      -- dap.listeners.before.attach.dapui_config = function()
      --   dapui.open()
      -- end
      -- dap.listeners.before.launch.dapui_config = function()
      --   dapui.open()
      -- end
      -- dap.listeners.before.event_terminated.dapui_config = function()
      --   dapui.close()
      -- end
      -- dap.listeners.before.event_exited.dapui_config = function()
      --   dapui.close()
      -- end
    end
  }
}
