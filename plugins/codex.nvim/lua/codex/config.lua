local M = {}

M.defaults = {
	command = "codex",
	extra_args = {},
	env = {},
	cwd = "git_root",
	no_alt_screen = true,
	terminal = {
		provider = "float",
		direction = "vertical",
		size = 80,
		width = 0.72,
		height = 0.75,
		border = "rounded",
		close_on_exit = true,
		close_existing = true,
		title = " 󰚩 Codex ",
		title_pos = "center",
		zindex = 80,
		close_keys = { "<C-q>", "<Esc><Esc>" },
	},
	exec = {
		args = { "exec", "-" },
		output = "scratch",
	},
	review = {
		args = { "review", "--uncommitted" },
	},
}

M.options = vim.deepcopy(M.defaults)
M.did_setup = false

function M.setup(opts)
	if opts == nil and M.did_setup then
		return M.options
	end

	M.options = vim.tbl_deep_extend("force", vim.deepcopy(M.defaults), opts or {})
	M.did_setup = true
	return M.options
end

return M
