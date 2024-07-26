return {
  {
    "nvim-neorg/neorg",
    dependencies = {},
    opts = {
      load = {
        ["core.concealer"] = {
          config = {
            icon_preset = "diamond",
            markup_preset = "dimmed",
            dim_code_block = { enabled = false },
          },
        },
        ["core.completion"] = {
          config = {
            engine = "nvim-cmp",
          },
        },
        ["core.defaults"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/notes",
            },
            autodetect = true,
            autochdir = true,
          },
        },
        ["core.export"] = {},
        ["core.export.markdown"] = {
          config = {
            extensions = "all",
          },
        },
        ["core.integrations.telescope"] = {},
        ["core.presenter"] = {},
        ["core.highlights"] = {},
        ["core.keybinds"] = {},
        ["core.qol.toc"] = {},
      },
    },
    config = function(_, opts)
      require("neorg").setup(opts)

      vim.wo.foldlevel = 99
      vim.wo.conceallever = 2
    end,
  },
}
