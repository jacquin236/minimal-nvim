-- LSP Server to use for Python.
-- Set to "basedpyright" to use basedpyright instead of pyright.
vim.g.lazyvim_python_lsp = "pyright"
vim.g.lazyvim_python_ruff = "ruff"

return {
  { "Vimjas/vim-python-pep8-indent", ft = { "python" } },
  {
    "MeanderingProgrammer/py-requirements.nvim",
    event = { "BufRead requirements.txt" },
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      {
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
          table.insert(opts.sources, { name = "py-requirements" })
        end,
      },
    },
    opts = {},
    -- stylua: ignore
    keys = {
      { "<leader>ppu", function() require("py-requirements").upgrade() end, desc = "Update Package" },
      { "<leader>ppU", function() require("py-requirements").upgrade_all() end, desc = "Update All Packages" },
      { "<leader>ppd", function() require("py-requirements").show_description() end, desc = "Show Description" },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>p", group = "packages/dependencies", icon = " ", mode = { "n", "v" } },
        { "<leader>pp", group = "python: requirements.txt", icon = " " },
        { "<localleader>v", group = "VirtualEnv (python)", icon = " " },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                diagnosticSeverityOverrides = {
                  reportUnusedCallResult = "information",
                  reportUnusedExpression = "information",
                  reportUnknownMemberType = "none",
                  reportUnknownLambdaType = "none",
                  reportUnknownParameterType = "none",
                  reportMissingParameterType = "none",
                  reportUnknownVariableType = "none",
                  reportUnknownArgumentType = "none",
                  reportAny = "none",
                },
              },
            },
          },
        },
        pyright = {
          settings = {
            verboseOutput = true,
            autoImportCompletion = true,
            python = {
              analysis = {
                diagnosticSeverityOverrides = {
                  reportWildcardImportFromLibrary = "none",
                  reportUnusedImport = "information",
                  reportUnusedClass = "information",
                  reportUnusedFunction = "information",
                },
                typeCheckingMode = "strict",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly",
                indexing = true,
              },
            },
          },
        },
        [vim.g.lazyvim_python_ruff] = {
          handlers = {
            ["textDocument/publishDiagnostics"] = function() end,
          },
        },
      },
    },
  },
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
      "mfussenegger/nvim-dap-python",
      "nvim-telescope/telescope.nvim",
    },
    lazy = false,
    branch = "regexp",
    config = function()
      local function shorter_name(filename)
        return filename:gsub(os.getenv("HOME"), "~"):gsub("/bin/python", "")
      end

      local function on_venv_activate()
        local command_run = false

        local function run_shell_command()
          local source = require("venv-selector").source()
          local python = require("venv-selector").python()

          if source == "poetry" and command_run == false then
            local command = "poetry env use " .. python
            vim.api.nvim_feedkeys(command .. "\n", "n", false)
            command_run = true
          end
        end

        vim.api.nvim_create_augroup("TerminalCommands", { clear = true })

        vim.api.nvim_create_autocmd("TermEnter", {
          group = "TerminalCommands",
          pattern = "*",
          callback = run_shell_command,
        })
      end

      require("venv-selector").setup({
        settings = {
          options = {
            on_telescope_result_callback = shorter_name,
            on_venv_activate_callback = on_venv_activate,
            notify_user_on_venv_activation = true,
          },
        },
      })
    end,
    keys = function()
      local vprefix = "<localleader>v"
      local venv = require("venv-selector")
      -- stylua: ignore
      return {
        { vprefix .. "p", function() venv.python() end, desc = "Path to Python or nil" },
        { vprefix .. "v", function() venv.venv() end, desc = "Path to Venv or nil" },
        { vprefix .. "s", function() venv.source() end, desc = "Source name of venv" },
        { vprefix .. "w", function() venv.workspace_paths() end, desc = "Workspace paths" },
        { vprefix .. "c", function() venv.cwd() end, desc = "Current working dir" },
        { vprefix .. "f", function() venv.file_dir() end, desc = "Current file dir" },
        { vprefix .. "d", function() venv.deactivate() end, desc = "Deactivate venv" },
        { vprefix .. "S", function() venv.stop_lsp_servers() end, desc = "Stop lsp server" },
      }
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      local debugpy_path = require("mason-registry").get_package("debugpy"):get_install_path()
      local dap_python = require("dap-python")
      dap_python.setup(debugpy_path .. "/venv/bin/python")
      dap_python.test_runner = "pytest"
    end,
  },
}
