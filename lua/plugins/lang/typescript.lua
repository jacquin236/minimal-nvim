return {
  { "dmmulroy/ts-error-translator.nvim", opts = {} },
  {
    "pmizio/typescript-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      on_attach = function(_, bufnr)
        local map = vim.keymap.set

        -- stylua: ignore start
        map("n", "gD", "<cmd>TSToolsGoToSourceDefinition<cr>", { desc = "Goto Source Definition", buffer = bufnr })
        map("n", "gR", "<cmd>TSToolsFileReferences<cr>", { desc = "File References", buffer = bufnr })
        map("n", "<leader>co", "<cmd>TSToolsOrganizeImports<cr>", { desc = "Organize Imports", buffer = bufnr })
        map("n", "<leader>cI", "<cmd>TSToolsSortImports<cr>", { desc = "Sort Imports", buffer = bufnr })
        map("n", "<leader>cM", "<cmd>TSToolsAddMissingImports<cr>", { desc = "Add Missing Imports", buffer = bufnr })
        map("n", "<leader>cu", "<cmd>TSToolsRemoveUnusedImports<cr>", { desc = "Remove Unused Imports", buffer = bufnr })
        map("n", "<leader>cU", "<cmd>TSToolsRemoveUnused<cr>", { desc = "Remove Unused Statments", buffer = bufnr })
        map("n", "<leader>cx", "<cmd>TSToolsFixAll<cr>", { desc = "Fix All Diagnostics", buffer = bufnr })
        map("n", "<leader>cR", "<cmd>TSToolsRenameFile<cr>", { desc = "Rename File", buffer = bufnr })
        -- stylua: ignore end
      end,
      handlers = {
        ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
          require("ts-error-translator").translate_diagnostics(err, result, ctx, config)
          vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
        end,
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vtsls = {
          handlers = {
            ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
              require("ts-error-translator").translate_diagnostics(err, result, ctx, config)
              vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
            end,
          },
          init_options = {
            preferences = {
              disableSuggestions = true,
            },
          },
        },
      },
    },
  },
  {
    "dmmulroy/tsc.nvim",
    ft = { "typescript", "typescriptreact" },
    cmd = { "TSC", "TSCOpen", "TSCClose", "TSStop" },
    opts = {
      auto_start_watch_mode = false,
      use_trouble_qflist = true,
      flags = { watch = false },
    },
    keys = {
      { "<leader>ct", ft = { "typescript", "typescriptreact" }, "<cmd>TSC<cr>", desc = "Type Check" },
      { "<leader>xy", ft = { "typescript", "typescriptreact" }, "<cmd>TSCOpen<cr>", desc = "Type Check Quickfix" },
    },
  },
}
