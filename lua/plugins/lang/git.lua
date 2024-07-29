LazyVim.on_very_lazy(function()
  vim.filetype.add({
    filename = {
      ["NEOGIT_COMMIT_EDITMSG"] = "NeogitCommitMessage",
    }
  })
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "NeogitCommitMessage" },
    callback = function()
      vim.opt.list = false
      vim.opt_local.spell = true
      vim.schedule(function()
        vim.api.nvim_set_hl(0, "VirtColumn", { link = "Variable" })
      end)
    end
  })
end)

return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "petertriho/cmp-git",
    },
    config = function(_, opts)
      vim.treesitter.language.register("gitcommit", "NeogitCommitMessage")

      local cmp = require("cmp")
      cmp.setup(opts)
      cmp.setup.filetype({ "gitcommit", "NeogitCommitMessage" }, {
        sources = {
          { name = "git",        group_index = 1 },
          { name = "snippets",   group_index = 1 },
          { name = "dictionary", group_index = 1 },
          { name = "spell",      group_index = 1 },
          { name = "buffer",     group_index = 2 },
        },
      })
    end,
  },
  {
    "petertriho/cmp-git",
    dependencies = { "nvim-lua/plenary.nvim" },
    init = function()
      table.insert(require("cmp").get_config().sources, { name = "git" })
    end,
    opts = {
      filetypes = { "gitcommit", "octo", "NeogitCommitMessage" },
    },
  },
}
