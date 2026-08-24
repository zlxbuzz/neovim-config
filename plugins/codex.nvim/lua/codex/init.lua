local config = require("codex.config")

local M = {}

function M.setup(opts)
	config.setup(opts)
	require("codex.ui").setup_highlights()
	require("codex.commands").setup()
end

return M
