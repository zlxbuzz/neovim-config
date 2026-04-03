-- 代码格式化
vim.pack.add({
	{
		src = "https://github.com/stevearc/conform.nvim",
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

-- 加载外部
require("config.format")
