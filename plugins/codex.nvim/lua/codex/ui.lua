local config = require("codex.config")

local M = {}

local function resolve_dimension(value, total, fallback)
	value = value or fallback

	if value > 0 and value < 1 then
		return math.floor(total * value)
	end

	return math.min(math.floor(value), total)
end

function M.setup_highlights()
	vim.api.nvim_set_hl(0, "CodexFloatNormal", { bg = nil })
	vim.api.nvim_set_hl(0, "CodexFloatBorder", { fg = "#7287fd", bg = nil })
	vim.api.nvim_set_hl(0, "CodexFloatTitle", { fg = "#7287fd", bg = nil, bold = true })
	vim.api.nvim_set_hl(0, "CodexFloatFooter", { fg = "#8c8fa1", bg = nil })
end

function M.set_window_options(win)
	vim.wo[win].number = false
	vim.wo[win].relativenumber = false
	vim.wo[win].cursorline = false
	vim.wo[win].signcolumn = "no"
	vim.wo[win].foldcolumn = "0"
	vim.wo[win].statuscolumn = ""
	vim.wo[win].winblend = 0
	vim.wo[win].winhighlight = table.concat({
		"NormalFloat:CodexFloatNormal",
		"FloatBorder:CodexFloatBorder",
		"FloatTitle:CodexFloatTitle",
		"FloatFooter:CodexFloatFooter",
	}, ",")
end

function M.open_float(buf, opts)
	opts = vim.tbl_deep_extend("force", config.options.terminal, opts or {})
	local width = resolve_dimension(opts.width, vim.o.columns, 0.6)
	local height = resolve_dimension(opts.height, vim.o.lines, 0.75)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	local win_config = {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		border = opts.border or "rounded",
		style = "minimal",
		title = opts.title or " 󰚩 Codex ",
		title_pos = opts.title_pos or "center",
		zindex = opts.zindex or 80,
	}

	if opts.footer then
		win_config.footer = opts.footer
		win_config.footer_pos = opts.footer_pos or "right"
	end

	local win = vim.api.nvim_open_win(buf, true, win_config)

	M.set_window_options(win)
	return win
end

return M
