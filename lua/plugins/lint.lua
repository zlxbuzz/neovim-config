-- 语法检查插件
return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		local lint = require("lint")

		-- 配置不同语言的 linter
		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			vue = { "eslint_d" },
			python = { "pylint", "mypy" },
			lua = { "luacheck" },
			yaml = { "yamllint" },
			dockerfile = { "hadolint" },
			sh = { "shellcheck" },
			markdown = { "markdownlint" },
			go = { "golangcilint" },
			rust = { "clippy" },
		}

		-- 自定义 linter 配置
		lint.linters.eslint_d = {
			cmd = "eslint_d",
			args = { "--stdin", "--stdin-filename", "%filepath", "--format", "json" },
		 stdin = true,
		 stream = "stdout",
		 ignore_exitcode = true,
		 parser = function(output, bufnr)
			local diagnostics = {}
			local decoded = vim.json.decode(output)
			for _, item in ipairs(decoded) do
				table.insert(diagnostics, {
					lnum = item.line - 1,
					col = item.column - 1,
					end_lnum = item.endLine and (item.endLine - 1) or nil,
					end_col = item.endColumn and (item.endColumn - 1) or nil,
					message = item.message,
					severity = item.severity == 1 and vim.diagnostic.severity.ERROR or vim.diagnostic.severity.WARN,
					source = "eslint_d",
					code = item.ruleId,
				})
			end
			return diagnostics
		end,
		}

		-- 自动触发 lint
		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}