local M = {}

M.config = function()
  lvim.builtin.dap = {
    active = false,
    on_config_done = nil,
    breakpoint = {
      text = "",
      texthl = "LspDiagnosticsSignError",
      linehl = "",
      numhl = "",
    },
    breakpoint_rejected = {
      text = "",
      texthl = "LspDiagnosticsSignHint",
      linehl = "",
      numhl = "",
    },
    stopped = {
      text = "",
      texthl = "LspDiagnosticsSignInformation",
      linehl = "DiagnosticUnderlineInfo",
      numhl = "LspDiagnosticsSignInformation",
    },
  }
end

M.setup = function()
  local dap = require "dap"
  local widgets = require "dap.ui.widgets"

  dap.adapters.chrome = {
      type = "executable",
      command = "node",
      args = {os.getenv("HOME") .. "/.vscode-chrome-debug/out/src/chromeDebug.js"} -- TODO adjust
  }

  dap.configurations.javascript = { -- change this to javascript if needed
      {
          type = "chrome",
          request = "launch",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
          port = 9222,
          host = "http://localhost:8080",
          webRoot = "${workspaceFolder}",
      }
  }
  dap.configurations.javascriptreact = { -- change this to javascript if needed
      {
          type = "chrome",
          request = "launch",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
          port = 9222,
          host = "http://localhost:8080",
          webRoot = "${workspaceFolder}",
      }
  }
  dap.configurations.typescript = { -- change this to javascript if needed
      {
          type = "chrome",
          request = "launch",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
          port = 9222,
          host = "http://localhost:8080",
          webRoot = "${workspaceFolder}",
      }
  }
  dap.configurations.typescriptreact = { -- change this to javascript if needed
      {
          type = "chrome",
          request = "launch",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
          port = 9222,
          host = "http://localhost:8080",
          webRoot = "${workspaceFolder}",
      }
  }

  if lvim.use_icons then
    vim.fn.sign_define("DapBreakpoint", lvim.builtin.dap.breakpoint)
    vim.fn.sign_define("DapBreakpointRejected", lvim.builtin.dap.breakpoint_rejected)
    vim.fn.sign_define("DapStopped", lvim.builtin.dap.stopped)
  end

  dap.defaults.fallback.terminal_win_cmd = "50vsplit new"

  lvim.builtin.which_key.mappings["d"] = {
    name = "Debug",
    t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
    b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
    d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
    g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
    o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
    u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
    p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
    s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
    q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
    x = { "<cmd>lua require'dap'.clear_breakpoints()<cr>", "Clear breakpoints" },
    w = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover debug" },
    e = { "<cmd>lua require'dap.ui.widgets'.centered_float(require'dap.ui.widgets.scopes)<cr>", "Scopes" },
  }

  if lvim.builtin.dap.on_config_done then
    lvim.builtin.dap.on_config_done(dap)
  end
end

-- TODO put this up there ^^^ call in ftplugin

-- M.dap = function()
--   if lvim.plugin.dap.active then
--     local dap_install = require "dap-install"
--     dap_install.config("python_dbg", {})
--   end
-- end
--
-- M.dap = function()
--   -- gem install readapt ruby-debug-ide
--   if lvim.plugin.dap.active then
--     local dap_install = require "dap-install"
--     dap_install.config("ruby_vsc_dbg", {})
--   end
-- end

return M
