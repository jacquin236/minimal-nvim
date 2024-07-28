return {
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    event = { "CmdlineEnter" },
    ft = { "go", "gomod", "gowork", "gotmpl", "gohtmltmpl", "gotexttmpl" },
    build = ':lua require("go.install").update_all_sync()',
    config = function()
      require("go").setup({
        lsp_cfg = false,
      })
    end,
    keys = require("util.go").golang_keys,
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<localleader>g", group = "Go", icon = " " },
        { "<localleader>gd", group = "Debug", icon = " " },
        { "<localleader>gt", group = "Test", icon = "🧪" },
        { "<localleader>ga", group = "Alternate switch", icon = "󰔡 " },
        { "<localleader>gm", group = "Mod", icon = "󰕳 " },
        { "<localleader>gT", group = "Tag", icon = " " },
        { "<leader>pg", group = "go: packages", icon = " " },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "go",
        "gomod",
        "gowork",
        "gosum",
        "gotmpl",
      })
    end,
  },
  {
    "leoluz/nvim-dap-go",
    config = require("util.go").golang_dap,
    keys = {
      -- stylua: ignore
      { "<leader>dT", function() require("dap-go").debug_test() end, desc = "Debug Test (go)" },
    },
  },
}
