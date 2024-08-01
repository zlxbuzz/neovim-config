-- 注释
return {
	{
		'numToStr/Comment.nvim',
		event = "VeryLazy",
		config = function()
			require('Comment').setup({
				-- 支持tsx
				pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
			})
		end
	},
	{
		'JoosepAlviste/nvim-ts-context-commentstring',
		config = function()
			require('ts_context_commentstring').setup {
				enable_autocmd = false,
			}
		end
	},
}
