-- 代码格式化
return {
	"stevearc/conform.nvim",
	event = { "BufWritePre", "InsertEnter" },
	cmd = { "ConformInfo", "FormatEnable", "FormatDisable" },
	config = function()
		require("config.format")
	end,
}
