vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim" },
})

require("catppuccin").setup({
	flavour = "auto",
	transparent_background = true,
	term_colors = true,
	integrations = {
		aerial = true,
		diffview = true,
		mini = {
			enabled = true,
			indentscope_color = "sky",
		},
		noice = true,
		-- overseer = true,
		telescope = {
			enabled = true,
			-- style = "nvchad",
		},
		treesitter = true,
		notify = true,
		gitsigns = true,
		flash = true,
		blink_cmp = true,
		mason = true,
		snacks = true,
	},
	highlight_overrides = {
		latte = function(latte)
			return {
				CursorLineNr = { fg = latte.yellow },
				TelescopeSelection = { bg = latte.surface0 },
				TelescopeSelectionCaret = { fg = latte.yellow, bg = latte.surface0 },
				TelescopePromptPrefix = { fg = latte.yellow },
				FlashCurrent = { bg = latte.peach, fg = latte.base },
				FlashMatch = { bg = latte.red, fg = latte.base },
				FlashLabel = { bg = latte.teal, fg = latte.base },
				NormalFloat = { bg = latte.base },
				FloatBorder = { bg = latte.base },
				FloatTitle = { bg = latte.base },
				RenderMarkdownCode = { bg = latte.crust },
				Pmenu = { bg = latte.surface0 },
				Comment = { bg = nil },
				statusline = { bg = nil },
			}
		end,
	},
})
vim.cmd.colorscheme("catppuccin-latte")
