return {
	{
		-- 获取最后的session内容
		"folke/persistence.nvim",
		-- event = "BufReadPre", -- this will only start session saving when an actual file was opened
		config = function()
			require('persistence').setup()
			-- restore the session for the current directory
			vim.api.nvim_set_keymap("n", "<leader>qs", [[<cmd>lua require("persistence").load()<cr>]], {})

			-- restore the last session
			vim.api.nvim_set_keymap("n", "<leader>ql", [[<cmd>lua require("persistence").load({ last = true })<cr>]], {})

			-- stop Persistence => session won't be saved on exit
			vim.api.nvim_set_keymap("n", "<leader>qd", [[<cmd>lua require("persistence").stop()<cr>]], {})
		end
	},
	{
		-- 自动匹配左右符号
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		config = function()
			require('nvim-autopairs').setup({
				enable_check_bracket_line = false
			})
		end
	},
	{
		-- 光标返回最后的位置
		"ethanholz/nvim-lastplace",
		config = true

	}
}
