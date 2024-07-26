local completion = require("util.completion")

return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "onsails/lspkind.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "ray-x/cmp-treesitter",
      "hrsh7th/cmp-cmdline",
      "dmitmel/cmp-cmdline-history",
      "f3fora/cmp-spell",
      "rafamadriz/friendly-snippets",
      { "garymjr/nvim-snippets", opts = { friendly_snippets = true } },
    },
    keys = {
      { "<leader>iC", "<cmd>CmpStatus<cr>", desc = "Cmp" },
    },
    opts = function(_, opts)
      opts.sources = completion.sources
      opts.window = completion.window
      opts.formatting = completion.formatting
      opts.performance = completion.performance
    end,
    config = function(_, opts)
      local cmp = require("cmp")
      cmp.setup(opts)

      cmp.setup.cmdline({ "/", "?" }, {
        completion = { completeopt = "menu,menuone,noinsert" },
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })

      cmp.setup.cmdline(":", {
        completion = { completeopt = "menu,menuone,noselect,noinsert" },
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "cmdline" },
          { name = "cmdline_history" },
        }),
      })
    end,
  },
}
