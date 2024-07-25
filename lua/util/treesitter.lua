local treesitter_core = function()
  local language_tree = false
  local enable = false

  local has_ts = pcall(require, "nvim-treesitter.configs")
  if not has_ts then
    LazyVim.notify("Treesitter is not installed!", { title = "Treesitter" })
    return
  end

  local lines = vim.fn.line("$")
  if lines > 100000 then
    vim.cmd([[syntax manual]])
    return
  end
  if lines > 10000 then
    enable = true
    language_tree = false
  else
    enable = true
    language_tree = false
  end
  local disable_ft = nil
  if vim.fn.has("nvim-0.10") == 1 then
    disable_ft = { "vimdoc" }
  end

  return {
    highlight = {
      enable = enable,
      additional_vim_regex_highlighting = false,
      disable = disable_ft,
      use_languagetree = language_tree,
    },
  }
end

local treesitter_parsers = function()
  local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
  parser_config.gotmpl = {
    install_info = {
      url = "https://github.com/ngalaiko/tree-sitter-go-template",
      files = { "src/parser.c" },
    },
    filetype = "gotmpl",
    used_by = { "gohtmltmpl", "gotexttmpl", "gotmpl", "yaml" },
  }
end

local treesitter_textobjs = function()
  local lines = vim.fn.line("$")
  local enable = true
  if lines > 8000 then
    return
  end

  if lines > 4000 then
    enable = false
  end

  return {
    incremental_selection = {
      enable = enable,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = false,
        node_decremental = "v",
      },
    },
    textobjects = { lsp_interop = { enable = false } },
    move = {
      enable = enable,
      set_jumps = enable,
      -- Keeps LazyVim default keymaps
      goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
      goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
      goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
      goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
    },
    select = {
      enable = enable,
      keymaps = {
        ["ix"] = "@cell.inner",
        ["ax"] = "@cell.outer", -- Cell Repl for python
      },
    },
  }
end

local treesitter_various_text_objs_keys = function()
  local vaj = require("various-textobjs")
  -- stylua: ignore
  return {
     -- markdown
    { "il", ft = { "markdown", "toml" }, mode = { "o", "x" }, function() vaj.mdlink("inner") end, desc = "Markdown Link" },
    { "al", ft = { "markdown", "toml" }, mode = { "o", "x" }, function() vaj.mdlink("outer") end, desc = "Markdown Link" },
    { "ie", ft = "markdown", mode = { "o", "x" }, function() vaj.mdEmphasis("inner") end, desc = "Emphasis Content" },
    { "ae", ft = "markdown", mode = { "o", "x" }, function() vaj.mdEmphasis("outer") end, desc = "Emphasis Content" },
    { "iC", ft = "markdown", mode = { "o", "x" }, function() vaj.mdFencedCodeBlock("inner") end, desc = "Markdown Code Block" },
    { "aC", ft = "markdown", mode = { "o", "x" }, function() vaj.mdFencedCodeBlock("outer") end, desc = "Markdown Code Block" },
    -- css, scss
    { "iC", ft = { "css", "scss", "less" }, mode = { "o", "x" }, function() vaj.cssSelector("inner") end, desc = "CSS Selector" },
    { "aC", ft = { "css", "scss", "less" }, mode = { "o", "x" }, function() vaj.cssSelector("outer") end, desc = "CSS Selector" },
    { "i#", ft = { "css", "scss", "less" }, mode = { "o", "x" }, function() vaj.cssColor("inner") end, desc = "CSS Color" },
    { "a#", ft = { "css", "scss", "less" }, mode = { "o", "x" }, function() vaj.cssColor("outer") end, desc = "CSS Color" },
    { "ih", ft = { "css", "scss", "less", "html", "xml", "vue" }, mode = { "o", "x" }, function() vaj.htmlAttribute("inner") end, desc = "HTML Attribute" },
    { "ah", ft = { "css", "scss", "less", "html", "xml", "vue" }, mode = { "o", "x" }, function() vaj.htmlAttribute("outer") end, desc = "HTML Attribute" },
    -- lua, shell, markdown
    { "iD", ft = { "lua", "shell", "neorg", "markdown" }, mode = { "o", "x" }, function() vaj.doubleSquareBrackets("inner") end, desc = "Double Square Brackets" },
    { "aD", ft = { "lua", "shell", "neorg", "markdown" }, mode = { "o", "x" }, function() vaj.doubleSquareBrackets("outer") end, desc = "Double Square Brackets" },
    -- shell
    { "iP", ft = { "bash", "zsh", "fish", "sh" }, mode = { "o", "x" }, function() vaj.shellPipe("inner") end, desc = "Shell Pipe" },
    { "aP", ft = { "bash", "zsh", "fish", "sh" }, mode = { "o", "x" }, function() vaj.shellPipe("outer") end, desc = "Shell Pipe" },
    -- python
    { "iy", ft = "python", mode = { "o", "x" }, function() vaj.pyTripleQuotes("inner") end, desc = "Python Triple Quotes" },
    { "ay", ft = "python", mode = { "o", "x" }, function() vaj.pyTripleQuotes("outer") end, desc = "Python Triple Quotes" },
    -- All
    { "ig", mode = { "o", "x" }, function() vaj.greedyOuterIndentation("inner") end, desc = "Indentation with Blank" },
    { "ag", mode = { "o", "x" }, function() vaj.greedyOuterIndentation("outer") end, desc = "Indentation with Blank" },
    { "iq", mode = { "o", "x" }, function() vaj.anyQuote("inner") end, desc = "Any Quote" },
    { "aq", mode = { "o", "x" }, function() vaj.anyQuote("outer") end, desc = "Any Quote" },
    { "ib", mode = { "o", "x" }, function() vaj.anyBracket("inner") end, desc = "Any Bracket" },
    { "ab", mode = { "o", "x" }, function() vaj.anyBracket("outer") end, desc = "Any Bracket" },
    { "i_", mode = { "o", "x" }, function() vaj.lineCharacterwise("inner") end, desc = "Indentation & Trailing Spaces" },
    { "a_", mode = { "o", "x" }, function() vaj.lineCharacterwise("outer") end, desc = "Indentation & Trailing Spaces" },
    { "iv", mode = { "o", "x" }, function() vaj.value("inner") end, desc = "Value" },
    { "av", mode = { "o", "x" }, function() vaj.value("outer") end, desc = "Value" },
    { "ik", mode = { "o", "x" }, function() vaj.key("inner") end, desc = "Key" },
    { "ak", mode = { "o", "x" }, function() vaj.key("inner") end, desc = "Key" },
    { "iN", mode = { "o", "x" }, function() vaj.number("inner") end, desc = "Number" },
    { "aN", mode = { "o", "x" }, function() vaj.number("outer") end, desc = "Number" },
    { "im", mode = { "o", "x" }, function() vaj.chainMember("inner") end, desc = "Chain Member" },
    { "am", mode = { "o", "x" }, function() vaj.chainMember("outer") end, desc = "Chain Member" },
    { "iS", mode = { "o", "x" }, function() vaj.subword("inner") end, desc = "Subword (include trailing or space" },
    { "aS", mode = { "o", "x" }, function() vaj.subword("outer") end, desc = "Subword (include trailing or space" },
  }
end

return {
  treesitter_core = treesitter_core,
  treesitter_parsers = treesitter_parsers,
  treesitter_textobjs = treesitter_textobjs,
  treesitter_various_text_objs_keys = treesitter_various_text_objs_keys,
}
