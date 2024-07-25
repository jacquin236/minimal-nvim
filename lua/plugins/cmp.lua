local cmp_extended = require("util.completion")
return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "ray-x/cmp-treesitter",
      "hrsh7th/cmp-cmdline",
      "dmitmel/cmp-cmdline-history",
      { "f3fora/cmp-spell", ft = { "gitcommit", "NeogitCommitMessage", "markdown", "norg", "org" } },
      { "petertriho/cmp-git", opts = { filetypes = { "gitcommit", "NeogitCommitMessage" } } },
      "rafamadriz/friendly-snippets",
      { "garymjr/nvim-snippets", opts = { friendly_snippets = true } },
    },
    keys = {
      { "<leader>iC", "<cmd>CmpStatus<cr>", desc = "Cmp" },
    },
    config = function(_, opts)
      vim.treesitter.language.register("gitcommit", "NeogitCommitMessage")

      opts.sources = {
        { name = "lazydev", group_index = 0 },
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "nvim_lua" },
        { name = "treesitter" },
        { name = "path" },
        {
          name = "buffer",
          options = {
            get_bufnrs = function()
              return vim.api.nvim_list_bufs()
            end,
          },
          group_index = 2,
        },
      }

      table.insert(opts.sources, { name = "snippets" })

      local cmp = require("cmp")
      cmp.setup(opts)
      cmp.setup(cmp_extended)

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

      cmp.setup.filetype("NeogitCommitMessage", {
        sources = {
          { name = "git", group_index = 1 },
          { name = "dictionary", group_index = 1 },
          { name = "spell", group_index = 1 },
          { name = "buffer", group_index = 2 },
        },
      })
    end,
  },
}
