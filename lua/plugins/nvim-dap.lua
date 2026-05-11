return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "rcarriga/nvim-dap-ui",
  },
  lazy = false,
  ui = {
    border = "rounded",
    size = { width = 0.8, height = 0.8 },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dap.adapters.go = {
      type = "server",
      port = 38697,
      executable = {
        command = "dlv",
        args = { "dap", "--listen=:38697", "--headless=true" },
      },
    }

    dap.configurations.go = {
      {
        type = "go",
        name = "Debug with Delve",
        request = "launch",
        program = "${workspaceFolder}",
      },
    }

    dapui.setup()

    dap.listeners.after["event_initialized"]["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before["event_terminated"]["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before["event_exited"]["dapui_config"] = function()
      dapui.close()
    end
  end
}