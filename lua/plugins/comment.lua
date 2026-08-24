-- 注释
vim.pack.add({
	{ src = "https://github.com/numToStr/Comment.nvim" },
	{ src = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring" },
})

require("Comment").setup({
	pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
})
-- require("ts_context_commentstring").setup({
-- 	enable_autocmd = false,
-- })
