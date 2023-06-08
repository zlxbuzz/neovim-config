return {
  -- nvim lua api展示
  -- gd 跳转到函数源码
  {
    "folke/neodev.nvim",
    event = "VeryLazy",
    config = function()
      require("neodev").setup({})
    end,
  },
  { "williamboman/mason.nvim", event = "VeryLazy", build = ":MasonUpdate",
  },
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    config = function()
      require('lsp_config')
    end,
    dependencies = {
      "folke/neodev.nvim"
    }
  },
  { "williamboman/mason-lspconfig.nvim", event = "VeryLazy" },
  -- 格式化
  { "jose-elias-alvarez/null-ls.nvim", event = "VeryLazy" },
}
