-- 入口展示
return {
	"goolord/alpha-nvim",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		-- Set header
		dashboard.section.header.val = {
			"                                                     ",
			"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
			"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
			"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
			"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
			"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
			"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
			"                                                     ",
			"                                                     ",
			"                                                     ",
			"             ⠠⡁⡂⡂⡂⡂⢂⢂⢐⠡⠐⢐⠀⡂⠄⠂⡐⢀⠂⠄⠁⠌⠀⠄⢁⠀     ",
			"             ⢐⢐⢐⢐⢐⠠⠡⠐⡀⢂⠁⡂⢐⠀⢂⣵⡆⢀⠂⡈⠄⠂⢁⠠⠀⠄     ",
			"             ⢐⢐⢐⢀⢂⠐⡁⢂⠂⠂⢂⠐⠠⣨⣾⣿⣿⠀⠠⠀⠄⠂⡀⠄⠐⠀     ",
			"             ⢐⠠⢂⠐⡀⡂⠂⡂⡈⡈⠄⢨⣼⣿⡿⣿⣿⣇⠐⠀⠂⠠⠀⠄⠂⠁     ",
			"             ⠐⡐⡀⡂⠂⠄⠡⠀⠄⢐⣰⣿⡿⠋⠄⠸⣿⣿⡀⡈⠄⠂⠀⠂⠀⠄     ",
			"             ⢐⠀⡂⠄⠡⠈⠄⠡⢨⣾⡟⠋⡀⠐⠠⠈⣻⣿⣧⠀⠠⠀⢁⠀⢁⠀     ",
			"             ⢀⢂⠐⡈⠠⠁⢌⣼⠟⠡⣀⣢⣠⣬⣤⣴⣼⣿⣿⡂⠀⠂⢀⠠⠀⠀     ",
			"             ⠠⠀⡂⠐⠈⣤⠟⢁⢴⠿⡿⠿⠿⠿⠿⠻⠻⠛⠛⠓⠈⠀⡀⠀⡀⠂     ",
			"             ⠀⠅⠠⠨⠚⢁⠠⠀⠄⠠⠀⠂⠐⠀⠠⠀⠄⠐⠈⠀⠈⠀⢀⠀⢀⠀     ",
			"             ⠀⠅⠠⠁⡈⠀⠄⠂⠐⢀⠈⠠⠈⠀⠂⠠⠐⠀⠐⠈⠀⠁⠀⢀⠀⠀     ",
			"             ⠀⠌⠀⢂⠠⠈⠀⠄⠁⠠⠐⠀⠂⠁⠀⠂⠀⠐⠀⠐⠀⢀⠁⠀⠀⠀     ",
			"             ⠀⠀⠁⠠⠀⠂⠁⠠⠈⠀⠄⠂⢀⠈⠀⠂⠁⢀⠈⠀⠠⠀⠀⠀⠀⠀     ",

		}


		-- Set menu
		dashboard.section.buttons.val = {
			dashboard.button("f", "  File tree", ":ene <CR> | :NERDTree <CR>"),
			dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("r", "  Recent", "<leader>qs | <leader>t"),
			dashboard.button("s", "  Settings", ":e $MYVIMRC <CR>"),
			dashboard.button("Leader s l", "  Open last session"),
			dashboard.button("q", "  Quit NVIM", ":qa<CR>")
		}

		alpha.setup(dashboard.opts)

		-- Disable folding on aleph buffer:
		-- vim.cmd("autocmd FileType aleph setlocal nofoldenable")
		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyVimStarted",
			callback = function()
				local stats = require("lazy").stats()
				local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
				local version = "  󰥱 v" .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
				local plugins = "⚡Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
				local footer = version .. "\t" .. plugins .. "\n"
				dashboard.section.footer.val = footer
				pcall(vim.cmd.AlphaRedraw)
			end,
		})
	end
}
