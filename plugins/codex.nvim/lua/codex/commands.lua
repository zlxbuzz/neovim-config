local cli = require("codex.cli")
local context = require("codex.context")
local ui = require("codex.ui")

local M = {}
local did_setup = false

local function open_scratch(name, text)
	local terminal_config = require("codex.config").options.terminal
	local buf = vim.api.nvim_create_buf(false, true)
	ui.open_float(buf, vim.tbl_extend("force", terminal_config, { title = " " .. name .. " " }))

	vim.api.nvim_buf_set_name(buf, name)
	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].swapfile = false
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(text or "", "\n", { plain = true }))
	vim.bo[buf].modifiable = false
end

local function ask_input(callback)
	vim.ui.input({ prompt = "Codex prompt: " }, function(input)
		if input and input ~= "" then
			callback(input)
		end
	end)
end

function M.ask(args)
	local prompt = table.concat(args or {}, " ")

	if prompt ~= "" then
		cli.open(context.current_file_prompt(prompt))
		return
	end

	ask_input(function(input)
		cli.open(context.current_file_prompt(input))
	end)
end

function M.ask_selection(opts)
	local selected = context.range(opts.line1, opts.line2)

	ask_input(function(input)
		cli.open(context.prompt(input, table.concat({
			"Selected code:",
			"```" .. vim.bo.filetype,
			selected,
			"```",
		}, "\n")))
	end)
end

function M.explain(opts)
	local selected = opts and opts.line1 and context.range(opts.line1, opts.line2) or context.buffer()

	cli.exec(context.prompt("Explain this code clearly and concisely.", table.concat({
		"Code:",
		"```" .. vim.bo.filetype,
		selected,
		"```",
	}, "\n")), function(output)
		open_scratch("codex-explain", output)
	end)
end

function M.fix()
	local prompt = context.prompt("Fix the issues in this file. Explain the changes before applying anything.", table.concat({
		"Diagnostics:",
		context.diagnostics(),
		"",
		"Git diff for current file:",
		context.git_diff(),
		"",
		"Current buffer:",
		"```" .. vim.bo.filetype,
		context.buffer(),
		"```",
	}, "\n"))

	cli.open(prompt)
end

function M.review(args)
	local prompt = table.concat(args or {}, " ")
	cli.review(prompt)
end

function M.exec(args)
	local prompt = table.concat(args or {}, " ")

	if prompt ~= "" then
		cli.exec(prompt, function(output)
			open_scratch("codex-output", output)
		end)
		return
	end

	ask_input(function(input)
		cli.exec(input, function(output)
			open_scratch("codex-output", output)
		end)
	end)
end

function M.apply()
	cli.apply()
end

function M.close()
	require("codex.terminal").close()
end

function M.setup()
	if did_setup then
		return
	end
	did_setup = true

	vim.api.nvim_create_user_command("Codex", function(opts)
		M.ask(opts.fargs)
	end, { nargs = "*" })

	vim.api.nvim_create_user_command("CodexAsk", function(opts)
		M.ask(opts.fargs)
	end, { nargs = "*" })

	vim.api.nvim_create_user_command("CodexAskSelection", function(opts)
		M.ask_selection(opts)
	end, { range = true })

	vim.api.nvim_create_user_command("CodexExplain", function(opts)
		M.explain(opts)
	end, { range = true })

	vim.api.nvim_create_user_command("CodexFix", function()
		M.fix()
	end, {})

	vim.api.nvim_create_user_command("CodexReview", function(opts)
		M.review(opts.fargs)
	end, { nargs = "*" })

	vim.api.nvim_create_user_command("CodexExec", function(opts)
		M.exec(opts.fargs)
	end, { nargs = "*" })

	vim.api.nvim_create_user_command("CodexApply", function()
		M.apply()
	end, {})

	vim.api.nvim_create_user_command("CodexClose", function()
		M.close()
	end, {})
end

return M
