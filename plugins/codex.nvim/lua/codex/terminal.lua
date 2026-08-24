local config = require("codex.config")
local ui = require("codex.ui")

local M = {}
local state = {
	buf = nil,
	win = nil,
}

local function close_existing_windows()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local ok, buf = pcall(vim.api.nvim_win_get_buf, win)
		if ok and vim.api.nvim_buf_is_valid(buf) and vim.b[buf].codex_nvim_terminal then
			pcall(vim.api.nvim_win_close, win, true)
		end
	end

	if state.win and vim.api.nvim_win_is_valid(state.win) then
		pcall(vim.api.nvim_win_close, state.win, true)
	end

	state.win = nil
	state.buf = nil
end

function M.close()
	close_existing_windows()
end

local function open_window()
	local opts = config.options.terminal

	if opts.provider == "float" then
		if opts.close_existing ~= false then
			close_existing_windows()
		end

		local buf = vim.api.nvim_create_buf(false, true)
		vim.b[buf].codex_nvim_terminal = true

		local win = ui.open_float(buf, opts)
		state.buf = buf
		state.win = win
		return buf, win
	end

	if opts.close_existing ~= false then
		close_existing_windows()
	end

	if opts.direction == "horizontal" then
		vim.cmd("botright " .. tostring(opts.size or 15) .. "split")
	else
		vim.cmd("botright " .. tostring(opts.size or 80) .. "vsplit")
	end

	local win = vim.api.nvim_get_current_win()
	local buf = vim.api.nvim_get_current_buf()
	vim.b[buf].codex_nvim_terminal = true
	ui.set_window_options(win)
	return buf, win
end

local function set_close_keymaps(buf)
	for _, key in ipairs(config.options.terminal.close_keys or {}) do
		vim.keymap.set({ "n", "t" }, key, function()
			M.close()
		end, { buffer = buf, nowait = true, silent = true, desc = "Close Codex" })
	end
end

function M.open(cmd, opts)
	opts = opts or {}
	local buf, win = open_window()
	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].buflisted = false

	local job = vim.fn.termopen(cmd, {
		cwd = opts.cwd,
		env = opts.env,
		on_exit = function(...)
			if opts.on_exit then
				opts.on_exit(...)
			end

			if opts.close_on_exit == false or config.options.terminal.close_on_exit == false then
				return
			end

			vim.schedule(function()
				if vim.api.nvim_win_is_valid(win) then
					vim.api.nvim_win_close(win, true)
				end
				if state.win == win then
					state.win = nil
					state.buf = nil
				end
			end)
		end,
	})

	set_close_keymaps(buf)
	vim.cmd("startinsert")
	return job
end

return M
