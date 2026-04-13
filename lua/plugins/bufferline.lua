-- 将buffer文件通过标签栏展示
vim.pack.add({
	{ src = "https://github.com/romgrk/barbar.nvim" },
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
})
require("barbar").setup({})
