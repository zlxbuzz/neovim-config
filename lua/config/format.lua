require("conform").setup({
	notify_on_error = true,
	-- 保存格式化
	format_on_save = function(bufnr)
		if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
			return
		end
		return {
			timeout_ms = 1000,
			lsp_format = "fallback",
		}
	end,

	-- 需要格式化的文件,一部分已经内置
	formatters_by_ft = {
		lua = { "stylua" },
	},
})
