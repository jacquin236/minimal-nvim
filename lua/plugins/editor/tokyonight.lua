return {
  "folke/tokyonight.nvim",
  lazy = false,
  opts = {
    style = "night",
    light_style = "day",
    transparent = vim.g.transparent_enabled,
    terminal_colors = true,
    styles = {
      comments = { italic = true },
      keywords = { italic = true },
    },
  },
}
