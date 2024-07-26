local icons = require("util.icons")
return {
  window = {
    completion = {
      border = border,
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
      scrollbar = false,
      col_offset = -3,
      side_padding = 1,
    },
    documentation = {
      border = border,
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
      scrollbar = false,
    },
  },
  formatting = {
    expandable_indicator = true,
    fields = { "abbr", "kind", "menu" },
    format = function(entry, vim_item)
      local lspkind_ok, lspkind = pcall(require, "lspkind")
      if not lspkind_ok then
        local lsp_icons = vim.tbl_deep_extend("force", icons.kind, icons.type, icons.cmp)
        vim_item.kind = string.format("%s %s", lsp_icons[vim_item.kind] or icons.cmp.undefined, vim_item.kind or "")
        vim_item.menu = setmetatable({
          buffer = "(Buffer)",
          codeium = "(Codeium)",
          copilot = "(Copilot)",
          orgmode = "(Org)",
          neorg = "(Neorg)",
          luasnip = "(Snippet)",
          snippets = "(Snippet)",
          git = "(Git)",
          path = "(Path)",
          emoji = "(Emoji)",
          nvim_lsp = "(Lsp)",
          nvim_lua = "(Lua)",
          spell = "(Spell)",
          treesitter = "(Treesitter)",
        }, {
          __index = function()
            return "(Builtin)"
          end,
        })[entry.source.name]

        local label = vim_item.abbr
        local truncated_label = vim.fn.strcharpart(label, 0, 80)
        if truncated_label ~= label then
          vim_item.abbr = truncated_label .. icons.ui.Ellipsis
        end

        return vim_item
      else
        local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
        local strings = vim.split(kind.kind, "%s", { trimempty = true })
        kind.kind = " " .. (strings[1] or "") .. " "
        kind.menu = " (" .. (strings[2] or "") .. ")"
        return kind
      end
    end,
  },

  performance = {
    async_budget = 1,
    max_view_entries = 120,
    debounce = 20,
    throttle = 20,
    fetching_timeout = 20,
    confirm_resolve_timeout = 20,
  },
}
