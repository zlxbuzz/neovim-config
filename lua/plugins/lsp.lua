return {
	-- lsp配置,直接加载配置文件
	{
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
		config = function()
			require("neodev").setup({})
			require("lspsaga").setup()
			require('lsp_config')
		end,
		dependencies = {
			-- nvim lua api展示
			"folke/neodev.nvim",
			-- lsp更好的展示ui,比如K这些
			"nvimdev/lspsaga.nvim"
		}
	},
	-- 管理安装lsp,dap,formmat
	{
		"williamboman/mason.nvim",
		event = "VeryLazy",
		build = ":MasonUpdate",
	},
	-- 自动关联lsconfig和mason
	{
		"williamboman/mason-lspconfig.nvim",
		event = "VeryLazy"
	},
	-- 格式化
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "VeryLazy"
	},
	-- lsp加载过程的ui界面
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		event = "LspAttach",
		config = function()
			require("fidget").setup {}
		end
	}
}
