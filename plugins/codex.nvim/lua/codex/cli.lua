local config = require("codex.config")
local context = require("codex.context")
local terminal = require("codex.terminal")

local M = {}

local function env()
	if type(config.options.env) == "function" then
		return config.options.env()
	end

	return config.options.env
end

local function base_cmd(args, cwd, opts)
	opts = opts or {}
	local cmd = { config.options.command }

	vim.list_extend(cmd, config.options.extra_args or {})

	if opts.no_alt_screen and config.options.no_alt_screen then
		table.insert(cmd, "--no-alt-screen")
	end

	if cwd and cwd ~= "" then
		vim.list_extend(cmd, { "-C", cwd })
	end

	vim.list_extend(cmd, args or {})
	return cmd
end

function M.ensure_available()
	if vim.fn.executable(config.options.command) == 1 then
		return true
	end

	vim.notify("codex.nvim: command not found: " .. config.options.command, vim.log.levels.ERROR)
	return false
end

function M.open(prompt)
	if not M.ensure_available() then
		return
	end

	local cwd = context.cwd(config.options.cwd)
	local args = {}

	if prompt and prompt ~= "" then
		table.insert(args, prompt)
	end

	terminal.open(base_cmd(args, cwd, { no_alt_screen = true }), { cwd = cwd, env = env() })
end

function M.exec(prompt, on_result)
	if not M.ensure_available() then
		return
	end

	local cwd = context.cwd(config.options.cwd)
	local cmd = base_cmd(config.options.exec.args, cwd)

	vim.notify("codex.nvim: running codex exec", vim.log.levels.INFO)

	vim.system(cmd, {
		text = true,
		stdin = prompt,
		cwd = cwd,
		env = env(),
	}, function(result)
		vim.schedule(function()
			if result.code ~= 0 then
				vim.notify(result.stderr ~= "" and result.stderr or "codex exec failed", vim.log.levels.ERROR)
				return
			end

			if on_result then
				on_result(result.stdout)
			end
		end)
	end)
end

function M.review(prompt)
	if not M.ensure_available() then
		return
	end

	local cwd = context.cwd(config.options.cwd)
	local args = vim.deepcopy(config.options.review.args)

	if prompt and prompt ~= "" then
		table.insert(args, prompt)
	end

	terminal.open(base_cmd(args, cwd, { no_alt_screen = true }), { cwd = cwd, env = env() })
end

function M.apply()
	if not M.ensure_available() then
		return
	end

	local cwd = context.cwd(config.options.cwd)
	terminal.open(base_cmd({ "apply" }, cwd, { no_alt_screen = true }), { cwd = cwd, env = env() })
end

return M
