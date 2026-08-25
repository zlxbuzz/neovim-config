vim.pack.add({
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/folke/noice.nvim" },
})

require("noice").setup({
	routes = {
		{
			view = "mini",
			filter = {
				event = "msg_show",
				kind = { "lua_print" },
			},
			opts = {
				replace = false,
				merge = false,
			},
		},
	},
	views = {
		mini = {
			timeout = 10000,
		},
	},
})
