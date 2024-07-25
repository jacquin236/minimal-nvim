-- Fix conceallevel for markdown files
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = vim.api.nvim_create_augroup("markdown_conceal", { clear = true }),
  pattern = { "markdown" },
  callback = function()
    vim.opt_local.conceallevel = 2
  end,
})

return {
  {
    "OXY2DEV/markview.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    ft = { "markdown", "norg", "rmd", "org" },
    cmd = { "Markview" },
    specs = {
      "lukas-reineke/headlines.nvim",
      enabled = false,
    },
    opts = {
      checkboxes = { enable = false },
      links = {
        inline_links = {
          hl = "@markup.link.label.markown_inline",
          icon = " ",
          icon_hl = "@markup.link",
        },
        images = {
          hl = "@markup.link.label.markown_inline",
          icon = " ",
          icon_hl = "@markup.link",
        },
      },
      code_blocks = {
        style = "language",
        hl = "CodeBlock",
        pad_amount = 0,
      },
      list_items = {
        shift_width = 2,
        marker_minus = { text = "●", hl = "@markup.list.markdown" },
        marker_plus = { text = "●", hl = "@markup.list.markdown" },
        marker_star = { text = "●", hl = "@markup.list.markdown" },
        marker_dot = {},
      },
      inline_codes = { enable = false },
      headings = {
        heading_1 = { style = "simple", hl = "Headline1" },
        heading_2 = { style = "simple", hl = "Headline2" },
        heading_3 = { style = "simple", hl = "Headline3" },
        heading_4 = { style = "simple", hl = "Headline4" },
        heading_5 = { style = "simple", hl = "Headline5" },
        heading_6 = { style = "simple", hl = "Headline6" },
      },
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    keys = {
      "<leader>cM",
      "<cmd>MarkdownPreviewToggle<cr>",
      ft = "markdown",
      desc = "Markdown Preview",
    },
    config = function()
      vim.cmd([[do FileType]])
    end,
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_auto_close = true
      vim.g.mkdp_open_to_the_world = false
      vim.g.mkdp_open_ip = "127.0.0.1"
      vim.g.mkdp_echo_preview_url = true
      vim.g.mkdp_page_title = "${name}"
      vim.g.mkdp_browser = "/usr/bin/firefox"
    end,
  },
}
