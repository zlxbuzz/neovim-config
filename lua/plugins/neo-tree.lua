vim.pack.add({
	{
		src = "https://github.com/nvim-neo-tree/neo-tree.nvim",
		version = vim.version.range("3"),
	},
	-- dependencies
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	-- optional, but recommended
	"https://github.com/nvim-tree/nvim-web-devicons",
})

-- 打开目录
vim.keymap.set("n", "<leader>e", "<Cmd>Neotree<CR>")

require("neo-tree").setup({
	filesystem = {
		window = {
			mappings = {
				["l"] = "open", -- l 键打开（可选）
			},
		},
		filtered_items = {
			-- 显示隐藏文件
			visible = true,
		},
	},
})
