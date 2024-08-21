return {
	-- lsp配置,直接加载配置文件
	{
		"neovim/nvim-lspconfig",
		-- 不要用veryLazy,否则单独打开文件不会启动lsp服务
		event = { "BufReadPost", "BufNewFile" },
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
		build = ":MasonUpdate",
	},
	-- 自动关联lsconfig和mason
	{
		"williamboman/mason-lspconfig.nvim",
	},
	-- 格式化
	{
		"jose-elias-alvarez/null-ls.nvim"
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
