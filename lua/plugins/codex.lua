local codex_path = vim.fn.stdpath("config") .. "/plugins/codex.nvim"

vim.opt.runtimepath:append(codex_path)

local codex_opts = vim.tbl_deep_extend("force", {
	terminal = {
		provider = "float",
		width = 0.72,
		height = 0.75,
		border = "rounded",
		title = " 󰚩 Codex ",
		zindex = 80,
	},
}, vim.g.codex_opts or {})

if vim.env.CODEX_CLI_COMMAND and not codex_opts.command then
	codex_opts.command = vim.env.CODEX_CLI_COMMAND
end

local default_keymaps = {
	ask = { mode = "n", lhs = "<leader>ia", rhs = "<cmd>CodexAsk<CR>", desc = "Codex ask" },
	ask_selection = { mode = "v", lhs = "<leader>ia", rhs = ":CodexAskSelection<CR>", desc = "Codex ask selection" },
	explain = { mode = "n", lhs = "<leader>ie", rhs = "<cmd>CodexExplain<CR>", desc = "Codex explain buffer" },
	explain_selection = { mode = "v", lhs = "<leader>ie", rhs = ":CodexExplain<CR>", desc = "Codex explain selection" },
	fix = { mode = "n", lhs = "<leader>if", rhs = "<cmd>CodexFix<CR>", desc = "Codex fix" },
	review = { mode = "n", lhs = "<leader>ir", rhs = "<cmd>CodexReview<CR>", desc = "Codex review" },
	exec = { mode = "n", lhs = "<leader>ix", rhs = "<cmd>CodexExec<CR>", desc = "Codex exec" },
	apply = { mode = "n", lhs = "<leader>ip", rhs = "<cmd>CodexApply<CR>", desc = "Codex apply" },
	close = { mode = "n", lhs = "<leader>ic", rhs = "<cmd>CodexClose<CR>", desc = "Codex close" },
}

local keymaps = codex_opts.keymaps
codex_opts.keymaps = nil

require("codex").setup(codex_opts)

if keymaps ~= false then
	keymaps = vim.tbl_deep_extend("force", default_keymaps, keymaps or {})

	for _, keymap in pairs(keymaps) do
		if keymap ~= false then
			local opts = vim.tbl_extend("force", { noremap = true, silent = true }, keymap.opts or {}, { desc = keymap.desc })
			vim.keymap.set(keymap.mode, keymap.lhs, keymap.rhs, opts)
		end
	end
end
