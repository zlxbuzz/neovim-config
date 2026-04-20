-- 插件集合snack
vim.pack.add({
	{ src = "https://github.com/folke/snacks.nvim" },
})

require("snacks").setup({
	dashboard = {
		enabled = true,
		preset = {
			keys = {
				{ icon = "󰈞 ", key = "f", desc = "Find files", action = ":lua Snacks.picker.smart()" },
				{ icon = " ", key = "o", desc = "Find history", action = "lua Snacks.picker.recent()" },
				{ icon = " ", key = "e", desc = "New file", action = ":enew" },
				{ icon = " ", key = "o", desc = "Recent files", action = ":lua Snacks.picker.recent()" },
				{ icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
				{
					icon = "󰔛 ",
					key = "P",
					desc = "Lazy Profile",
					action = ":Lazy profile",
					enabled = package.loaded.lazy ~= nil,
				},
				{ icon = " ", key = "M", desc = "Mason", action = ":Mason", enabled = package.loaded.lazy ~= nil },
				{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
			},
			header = [[
			                                                     
			  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ 
			  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ 
			  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ 
			  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ 
			  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ 
			  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ 
			                                                     
			                                                     
			                                                     
			             ⠠⡁⡂⡂⡂⡂⢂⢂⢐⠡⠐⢐⠀⡂⠄⠂⡐⢀⠂⠄⠁⠌⠀⠄⢁⠀            
			             ⢐⢐⢐⢐⢐⠠⠡⠐⡀⢂⠁⡂⢐⠀⢂⣵⡆⢀⠂⡈⠄⠂⢁⠠⠀⠄            
			             ⢐⢐⢐⢀⢂⠐⡁⢂⠂⠂⢂⠐⠠⣨⣾⣿⣿⠀⠠⠀⠄⠂⡀⠄⠐⠀            
			             ⢐⠠⢂⠐⡀⡂⠂⡂⡈⡈⠄⢨⣼⣿⡿⣿⣿⣇⠐⠀⠂⠠⠀⠄⠂⠁            
			             ⠐⡐⡀⡂⠂⠄⠡⠀⠄⢐⣰⣿⡿⠋⠄⠸⣿⣿⡀⡈⠄⠂⠀⠂⠀⠄            
			             ⢐⠀⡂⠄⠡⠈⠄⠡⢨⣾⡟⠋⡀⠐⠠⠈⣻⣿⣧⠀⠠⠀⢁⠀⢁⠀            
			             ⢀⢂⠐⡈⠠⠁⢌⣼⠟⠡⣀⣢⣠⣬⣤⣴⣼⣿⣿⡂⠀⠂⢀⠠⠀⠀            
			             ⠠⠀⡂⠐⠈⣤⠟⢁⢴⠿⡿⠿⠿⠿⠿⠻⠻⠛⠛⠓⠈⠀⡀⠀⡀⠂            
			             ⠀⠅⠠⠨⠚⢁⠠⠀⠄⠠⠀⠂⠐⠀⠠⠀⠄⠐⠈⠀⠈⠀⢀⠀⢀⠀            
			             ⠀⠅⠠⠁⡈⠀⠄⠂⠐⢀⠈⠠⠈⠀⠂⠠⠐⠀⠐⠈⠀⠁⠀⢀⠀⠀            
			             ⠀⠌⠀⢂⠠⠈⠀⠄⠁⠠⠐⠀⠂⠁⠀⠂⠀⠐⠀⠐⠀⢀⠁⠀⠀⠀            
			             ⠀⠀⠁⠠⠀⠂⠁⠠⠈⠀⠄⠂⢀⠈⠀⠂⠁⢀⠈⠀⠠⠀⠀⠀⠀⠀            
]],
		},
		sections = {
			{ section = "header" },
			{ icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
		},
	},
})

local Snacks = require("snacks")
-- 快捷键
local map = function(key, func, desc)
	vim.keymap.set("n", key, func, { desc = desc })
end
map("<leader>ff", Snacks.picker.smart, "Smart find file")
map("<leader>be", Snacks.picker.recent, "Find recent file")
