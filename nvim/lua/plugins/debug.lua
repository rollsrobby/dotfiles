return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio", "Cliffback/netcoredbg-macOS-arm64.nvim" },
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

      local netcoredbg_path = vim.fn.stdpath('data') .. '/lazy/netcoredbg-macOS-arm64.nvim/netcoredbg/netcoredbg'

      dap.adapters.coreclr = {
        type = "executable",
        command = netcoredbg_path,
        args = { "--interpreter=vscode" }
      }

      local function find_csproj_upward()
        local current_dir = vim.fn.expand('%:p:h') -- Get the current directory of the file
        while current_dir ~= '/' do
          -- Look for the .csproj file in the current directory
          local csproj = vim.fn.glob(current_dir .. '/*.csproj', false, true)
          if #csproj > 0 then
            return csproj[1] -- Return the first .csproj file found
          end
          -- Move up to the parent directory
          current_dir = vim.fn.fnamemodify(current_dir, ':h')
        end
        return nil -- Return nil if no .csproj file is found
      end

      local function get_project_name(csproj_file)
        -- Get the name of the .csproj file without the path and extension
        return vim.fn.fnamemodify(csproj_file, ':t:r')
      end

      local function get_pid(project_name)
        local handle = io.popen('pgrep -af ' .. project_name .. '.dll')
        if handle == nil then
          return nil
        end
        local result = handle:read("*a")
        handle:close()

        -- If result is empty or no match, return nil
        if result == "" then
          return nil
        end

        -- Extract the PID from the result (it's the first number in the output)
        local pid = result:match("^(%d+)")
        return pid and tonumber(pid) or nil
      end

      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "Attach to Azure Function (.NET)",
          request = "attach",
          -- processId = get_dotnet_pid_fzf,
          processId = function()
            -- local pid = vim.fn.input("Enter PID of the dotnet process to attach to: ")
            -- if pid == "" then return nil end
            -- return tonumber(pid)
            local csproj_file = find_csproj_upward()
            print('proj file ' .. csproj_file);
            if csproj_file then
              local project_name = get_project_name(csproj_file)
              print('ProjectName ' .. project_name);
              local pid = get_pid(project_name)
              if pid == "" then
                local manPid = vim.fn.input("Enter PID of the dotnet process to attach to: ")
                if manPid == "" then return nil end
                return tonumber(manPid)
              else
                if (pid == nil) then
                  local manPid = vim.fn.input("Enter PID of the dotnet process to attach to: ")
                  if manPid == "" then return nil end
                  return tonumber(manPid)
                end
                print('Pid ' .. pid);
                return tonumber(pid)
              end
            else
              local pid = vim.fn.input("Enter PID of the dotnet process to attach to: ")
              if pid == "" then return nil end
              return tonumber(pid)
            end
          end,
          justMyCode = true,
        }
      }

      -- require('netcoredbg-macOS-arm64').setup(dap);

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
