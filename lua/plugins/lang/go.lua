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
    keys = {
      -- switch between go and test file
      { "<localleader>gao", "<cmd>GoAlt<cr>", desc = "Open Alt" },
      { "<localleader>gaO", "<cmd>GoAlt!<cr>", desc = "Open Alt (create)" },
      { "<localleader>gas", "<cmd>GoAltS<cr>", desc = "Open Alt Split" },
      { "<localleader>gaS", "<cmd>GoAltS!<cr>", desc = "Open Alt Split (create)" },
      { "<localleader>gav", "<cmd>GoAltV<cr>", desc = "Open Alt Vsplit" },
      { "<localleader>gaV", "<cmd>GoAltV!<cr>", desc = "Open Alt Vsplit (create)" },
      -- debug
      { "<localleader>gds", "<cmd>GoDebug<cr>", desc = "Start" },
      { "<localleader>gdS", "<cmd>GoDbgStop<cr>", desc = "Stop" },
      { "<localleader>gdc", "<cmd>GoDbgContinue<cr>", desc = "Continue" },
      { "<localleader>gdC", "<cmd>GoDebugConfig<cr>", desc = "Open launch.json (config)" },
      { "<localleader>gdb", "<cmd>GoBreakToggle<cr>", desc = "Toggle Breakpoint" },
      { "<localleader>gdB", "<cmd>BreakCondition<cr>", desc = "Breapoint Condition" },
      { "<localleader>gdx", "<cmd>GoBreakSave<cr>", desc = "Save Breakpoints" },
      { "<localleader>gdX", "<cmd>GoBreakLoad<cr>", desc = "Load Breakpoints" },
      { "<localleader>gdi", "<cmd>GoDbgKeys<cr>", desc = "Keymaps Info" },
      { "<localleader>gdI", "<cmd>GoDebug -h<cr>", desc = "Helps Info" },
      { "<localleader>gda", "<cmd>GoDebug -a<cr>", desc = "Attach to Remote" },
      { "<localleader>gdn", "<cmd>GoDebug -n<cr>", desc = "Nearest Function" },
      { "<localleader>gdr", "<cmd>GoDebug -R<cr>", desc = "Restart" },
      { "<localleader>gdt", "<cmd>GoDebug -t<cr>", desc = "Test File" },
      { "<localleader>gdp", "<cmd>GoDebug -p<cr>", desc = "Package Test" },
      { "<localleader>gdr", "<cmd>ReplRun<cr>", desc = "Run REPL" },
      { "<localleader>gdR", "<cmd>ReplToggle<cr>", desc = "Toggle REPL" },
      -- go mod
      { "<localleader>gmi", "<cmd>GoModInit<cr>", desc = "go mod init" },
      { "<localleader>gmt", "<cmd>GoModTidy<cr>", desc = "go mod tidy" },
      { "<localleader>gmv", "<cmd>GoModVendor<cr>", desc = "go mod vendor" },
      --test
      { "<localleader>gtc", "<cmd>GoCoverageToggle<cr>", desc = "Toggle Coverage" },
      { "<localleader>gtC", "<cmd>GoCoverage -m<cr>", desc = "Show Metrics (coverage)" },
      { "<localleader>gtx", "<cmd>GoTestCompile<cr>", desc = "Compile" },
      { "<localleader>gtX", "<cmd>GoTermClose<cr>", desc = "Close Floating Terminal" },
      { "<localleader>gtf", "<cmd>GoTestFunc<cr>", desc = "Current Function" },
      { "<localleader>gtF", "<cmd>GoTestFile<cr>", desc = "Current File" },
      { "<localleader>gts", "<cmd>GoTestFunc -s<cr>", desc = "Function Selection" },
      { "<localleader>gtp", "<cmd>GoTestPkg<cr>", desc = "Current Package/Folder" },
      -- Package
      { "<leader>pgf", "<cmd>GoPkgOutline -f<cr>", desc = "Show in floating win" },
      { "<leader>pgg", "<cmd>GoPkgOutline<cr>", desc = "Show in side panel" },
      { "<leader>pgj", "<cmd>GoPkgOutline -p json<cr>", desc = "JSON" },
      -- tag
      { "<localleader>gTa", "<cmd>GoAddTag<cr>", desc = "Add tag" },
      { "<localleader>gTr", "<cmd>GoRmTag<cr>", desc = "Remove tag" },
      { "<localleader>gTc", "<cmd>GoClearTag<cr>", desc = "Clear tag" },
      { "<localleader>gTm", "<cmd>GoModifyTags<cr>", desc = "Modify tags" },

      { "<localleader>gl", "<cmd>GoLint<cr>", desc = "Lint" },
      { "<localleader>gb", "<cmd>GoBuild<cr>", desc = "Build" },
      { "<localleader>gf", "<cmd>GoFmt<cr>", desc = "Format" },
      { "<localleader>gg", "<cmd>GoGet<cr>", desc = "Get" },
      { "<localleader>gc", "<cmd>GoCmt<cr>", desc = "Add Comment" },
      {
        "<localleader>gC",
        function()
          require("go.comment").gen()
        end,
        desc = "Generate Comment",
      },
      { "<localleader>gs", "<cmd>GoFillStruct<cr>", desc = "Fill Struct" },
      { "<localleader>gS", "<cmd>GoFillSwitch<cr>", desc = "Fill Switch" },
      { "<localleader>gr", "<cmd>GoRun<cr>", desc = "Run" },
      { "<localleader>gy", "<cmd>GoImpl<cr>", desc = "Impl" },
      { "<localleader>gY", "<cmd>GoInstall<cr>", desc = "Install" },
      { "<localleader>gi", "<cmd>GoIfErr<cr>", desc = "Add If Err" },
      { "<localleader>gI", "<cmd>GOImports<cr>", desc = "Imports" },
      { "<localleader>gp", "<cmd>GoFixPlurals<cr>", desc = "Fix Plurals" },
    },
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
}
