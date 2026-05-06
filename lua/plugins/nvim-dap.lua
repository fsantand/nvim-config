local dap    = require("dap")
local dapui  = require("dapui")

require("mason-nvim-dap").setup({
  automatic_setup = true,
  handlers = {},
  ensure_installed = { "js-debug-adapter" },
})

-- Signs
local dap_icons = {
  Stopped             = { "󰁕 ", "DiagnosticWarn",  "DapStoppedLine" },
  Breakpoint          = " ",
  BreakpointCondition = " ",
  BreakpointRejected  = { " ", "DiagnosticError" },
  LogPoint            = ".>",
}
for name, sign in pairs(dap_icons) do
  sign = type(sign) == "table" and sign or { sign }
  vim.fn.sign_define("Dap" .. name, {
    text    = sign[1],
    texthl  = sign[2] or "DiagnosticInfo",
    linehl  = sign[3],
    numhl   = sign[3],
  })
end

-- Keymaps
vim.keymap.set("n", "<F5>", dap.continue,       { desc = "Debug: Start/Continue" })
vim.keymap.set("n", "<F1>", dap.step_into,      { desc = "Debug: Step Into" })
vim.keymap.set("n", "<F2>", dap.step_over,      { desc = "Debug: Step Over" })
vim.keymap.set("n", "<F3>", dap.step_out,       { desc = "Debug: Step Out" })
vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
vim.keymap.set("n", "<leader>B", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Debug: Set Conditional Breakpoint" })
vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: Toggle UI" })

-- UI
dapui.setup({
  icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
  controls = {
    icons = {
      pause = "⏸", play = "▶", step_into = "⏎", step_over = "⏭",
      step_out = "⏮", step_back = "b", run_last = "▶▶",
      terminate = "⏹", disconnect = "⏏",
    },
  },
})

dap.listeners.after.event_initialized["dapui_config"]  = dapui.open
dap.listeners.before.event_terminated["dapui_config"]  = dapui.close
dap.listeners.before.event_exited["dapui_config"]      = dapui.close

-- JS/TS adapter (local js-debug)
dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args = { vim.fn.expand("~/js-debug/src/dapDebugServer.js"), "${port}" },
  },
}

-- Python adapter (local via `uv run`, or attach to a remote debugpy server)
dap.adapters.python = function(cb, config)
  if config.request == "attach" then
    local connect = config.connect or config
    cb({
      type = "server",
      host = connect.host or "127.0.0.1",
      port = assert(tonumber(connect.port), "`connect.port` is required"),
      options = { source_filetype = "python" },
    })
  else
    cb({
      type = "executable",
      command = "uvx",
      args = { "--from", "debugpy", "python", "-m", "debugpy.adapter" },
      options = { source_filetype = "python" },
    })
  end
end

local function uv_python_path()
  local cwd = vim.fn.getcwd()
  local venv = cwd .. "/.venv/bin/python"
  if vim.fn.executable(venv) == 1 then
    return venv
  end
  return "python"
end

dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch file (uv)",
    program = "${file}",
    cwd = "${workspaceFolder}",
    console = "integratedTerminal",
    justMyCode = false,
    pythonPath = uv_python_path,
  },
  {
    type = "python",
    request = "launch",
    name = "Launch file with arguments (uv)",
    program = "${file}",
    args = function()
      local raw = vim.fn.input("Args: ")
      return vim.split(raw, "%s+", { trimempty = true })
    end,
    cwd = "${workspaceFolder}",
    console = "integratedTerminal",
    justMyCode = false,
    pythonPath = uv_python_path,
  },
  {
    type = "python",
    request = "launch",
    name = "Pytest: current file (uv)",
    module = "pytest",
    args = { "${file}", "-s" },
    cwd = "${workspaceFolder}",
    console = "integratedTerminal",
    justMyCode = false,
    pythonPath = uv_python_path,
  },
  {
    type = "python",
    request = "attach",
    name = "Attach: Docker Compose (127.0.0.1:5678 -> /app)",
    connect = { host = "127.0.0.1", port = 5678 },
    pathMappings = {
      { localRoot = "${workspaceFolder}", remoteRoot = "/app" },
    },
    justMyCode = false,
  },
  {
    type = "python",
    request = "attach",
    name = "Attach: Docker Compose (custom host/port/path)",
    connect = function()
      local host = vim.fn.input("Host [127.0.0.1]: ")
      local port = vim.fn.input("Port [5678]: ")
      return {
        host = host ~= "" and host or "127.0.0.1",
        port = tonumber(port ~= "" and port or "5678"),
      }
    end,
    pathMappings = function()
      local remote = vim.fn.input("Container path [/app]: ")
      return {
        {
          localRoot = "${workspaceFolder}",
          remoteRoot = remote ~= "" and remote or "/app",
        },
      }
    end,
    justMyCode = false,
  },
}

for _, lang in ipairs({ "typescript", "javascript" }) do
  dap.configurations[lang] = {
    {
      type = "pwa-node", request = "launch", name = "Launch file (Node)",
      program = "${file}", cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node", request = "attach", name = "Attach",
      skipFiles = {
        "${workspaceFolder}/node_modules/**/*.js",
        "${workspaceFolder}/node_modules/**/*.ts",
      },
      processId = require("dap.utils").pick_process,
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node", request = "launch", name = "Debug Mocha Tests",
      runtimeArgs = { "./node_modules/mocha/bin/mocha.js", "-u", "bdd", "--timeout", "999999" },
      rootPath = "${workspaceFolder}", cwd = "${workspaceFolder}",
      console = "integratedTerminal", internalConsoleOptions = "neverOpen",
      envFile = "${workspaceFolder}/env/test/.${workspaceFolderBasename}.env",
    },
    {
      type = "pwa-node", request = "launch", name = "Debug Mocha Tests (_mocha)",
      runtimeArgs = { "./node_modules/mocha/bin/_mocha.js", "-u", "bdd", "--timeout", "999999" },
      rootPath = "${workspaceFolder}", cwd = "${workspaceFolder}",
      console = "integratedTerminal", internalConsoleOptions = "neverOpen",
      envFile = "${workspaceFolder}/env/test/.${workspaceFolderBasename}.env",
    },
    {
      type = "pwa-node", request = "launch", name = "Launch file (Deno)",
      runtimeExecutable = "deno",
      runtimeArgs = { "run", "--inspect-brk", "--allow-all", "--log-level=debug" },
      program = "${file}", cwd = "${workspaceFolder}", attachSimplePort = 9229,
    },
  }
end
