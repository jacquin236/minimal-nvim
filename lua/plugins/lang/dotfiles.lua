LazyVim.on_very_lazy(function()
  vim.filetype.add({
    pattern = {
      [".*%.conf"] = "conf",
      [".*%.theme"] = "conf",
      ["^.env%..*"] = "bash",
    },
  })

  local read_file = function(file, line_handler)
    for line in io.lines(file) do
      line_handler(line)
    end
  end

  vim.api.nvim_create_user_command("DotEnv", function()
    local files = vim.fs.find(".env", {
      upward = true,
      stop = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:h"),
      path = vim.fn.expand("%:p:h"),
      type = "file",
      limit = 1,
    })

    if vim.tbl_isempty(files) then
      return
    end
    local filename, lines = files[1], {}

    read_file(filename, function(line)
      if #line > 0 then
        table.insert(lines, line)
      end
      if not vim.startswith(line, "#") then
        local name, value = unpack(vim.split(line, "="))
        vim.fn.setenv(name, value)
      end
    end)

    local markdown = table.concat(vim.iter({ "", "```sh", lines, "```", "" }):flatten():totable(), "\n")
    vim.notify(string.format("Read **%s**\n", filename) .. markdown, vim.log.levels.INFO, {
      title = "Nvim Env",
      on_open = function(win)
        local buf = vim.api.nvim_win_get_buf(win)
        if not vim.api.nvim_buf_is_valid(buf) then
          return
        end
        vim.bo[buf].filetype = "markdown"
      end,
    })
  end, {})
end)

return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      local function add_formatters(tbl)
        for ft, formatters in pairs(tbl) do
          if opts.formatters_by_ft[ft] == nil then
            opts.formatters_by_ft[ft] = formatters
          else
            vim.list_extend(opts.formatters_by_ft[ft], formatters)
          end
        end
      end

      add_formatters({
        ["sh"] = { "shfmt" },
        ["bash"] = { "shfmt" },
        ["zsh"] = { "shfmt" },
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "shfmt" })
    end,
  },
}
