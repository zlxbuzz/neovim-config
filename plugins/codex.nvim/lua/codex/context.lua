local M = {}

local function current_buf()
	return vim.api.nvim_get_current_buf()
end

local function current_file()
	local name = vim.api.nvim_buf_get_name(current_buf())
	if name == "" then
		return "[No file]"
	end
	return vim.fn.fnamemodify(name, ":p")
end

function M.current_file()
	return current_file()
end

function M.cwd(mode)
	if type(mode) == "function" then
		return mode()
	end

	if mode == "current_file" then
		local file = vim.api.nvim_buf_get_name(current_buf())
		if file ~= "" then
			return vim.fn.fnamemodify(file, ":p:h")
		end
	end

	if mode == "git_root" then
		local root = vim.fs.root(current_buf(), { ".git" })
		if root then
			return root
		end
	end

	return vim.uv.cwd()
end

function M.buffer()
	local lines = vim.api.nvim_buf_get_lines(current_buf(), 0, -1, false)
	return table.concat(lines, "\n")
end

function M.range(line1, line2)
	local lines = vim.api.nvim_buf_get_lines(current_buf(), line1 - 1, line2, false)
	return table.concat(lines, "\n")
end

function M.visual_selection()
	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")
	local start_line = start_pos[2]
	local end_line = end_pos[2]

	if start_line == 0 or end_line == 0 then
		return ""
	end

	if start_line > end_line then
		start_line, end_line = end_line, start_line
	end

	return M.range(start_line, end_line)
end

function M.diagnostics()
	local items = vim.diagnostic.get(current_buf())
	if vim.tbl_isempty(items) then
		return "No diagnostics."
	end

	local lines = {}
	for _, item in ipairs(items) do
		local severity = vim.diagnostic.severity[item.severity] or "UNKNOWN"
		table.insert(lines, string.format("%s:%d:%d %s %s", current_file(), item.lnum + 1, item.col + 1, severity, item.message))
	end

	return table.concat(lines, "\n")
end

function M.git_diff()
	local file = vim.api.nvim_buf_get_name(current_buf())
	if file == "" then
		return ""
	end

	local result = vim.system({ "git", "diff", "--", file }, { text = true }):wait()
	return result.stdout or ""
end

function M.file_header()
	return table.concat({
		"File: " .. current_file(),
		"Filetype: " .. vim.bo.filetype,
		"Line: " .. vim.api.nvim_win_get_cursor(0)[1],
	}, "\n")
end

function M.prompt(title, body)
	return table.concat({
		title,
		"",
		M.file_header(),
		"",
		body,
	}, "\n")
end

function M.current_file_prompt(user_prompt)
	return table.concat({
		user_prompt,
		"",
		"Use the current file as the primary target.",
		M.file_header(),
	}, "\n")
end

return M
