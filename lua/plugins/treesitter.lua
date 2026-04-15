-- 解析语法，语法高亮,语法匹配,parser等
vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" }, -- 语法高亮和折叠
})

require("nvim-treesitter").setup()
