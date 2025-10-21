require("conform").setup({
	notify_on_error = true,
	-- 保存格式化
	format_on_save = function(bufnr)
		if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
			return
		end
		return {
			timeout_ms = 2000,
			lsp_format = "fallback",
		}
	end,

	-- 需要格式化的文件,一部分已经内置
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
		typescript = { "prettierd", "prettier", stop_after_first = true },
		javascriptreact = { "prettierd", "prettier", stop_after_first = true },
		typescriptreact = { "prettierd", "prettier", stop_after_first = true },
		vue = { "prettierd", "prettier", stop_after_first = true },
		css = { "prettierd", "prettier", stop_after_first = true },
		scss = { "prettierd", "prettier", stop_after_first = true },
		sass = { "prettierd", "prettier", stop_after_first = true },
		html = { "prettierd", "prettier", stop_after_first = true },
		json = { "prettierd", "prettier", stop_after_first = true },
		yaml = { "prettierd", "prettier", stop_after_first = true },
		markdown = { "prettierd", "prettier", stop_after_first = true },
		python = { "black", "isort", stop_after_first = true },
		go = { "goimports", "gofmt" },
		rust = { "rustfmt" },
		sql = { "sqlfluff" },
		sh = { "shfmt" },
	},

	-- 格式化器配置
	formatters = {
		prettierd = {
			prepend_args = { "--tab-width", "2" },
		},
		prettier = {
			prepend_args = { "--tab-width", "2" },
		},
		stylua = {
			prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
		},
	},
})
