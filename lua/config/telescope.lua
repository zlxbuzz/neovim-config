local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
-- local custom_utils = require("custom.utils")
require("telescope").setup({
	defaults = {
		sorting_strategy = "ascending",
		borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
		layout_config = {
			horizontal = { prompt_position = "top", preview_width = 0.55 },
			vertical = { mirror = false },
			width = 0.87,
			height = 0.80,
			preview_cutoff = 120,
		},
		mappings = {
			i = {
				["<esc>"] = actions.close,
				["jk"] = actions.close,
			},
		},
		prompt_prefix = " ",
		selection_caret = " ",
	},
	extensions = {
		persisted = {
			layout_config = { width = 0.55, height = 0.55 },
		},
	},
})

-- keymaps

-- FIXME:
-- require('telescope').load_extension('git_submodules')

vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find Help" })
vim.keymap.set("n", "<leader>fH", builtin.highlights, { desc = "Find Highlights" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find Keymaps" })
vim.keymap.set("n", "<leader>fm", builtin.marks, { desc = "Find Marks" })
vim.keymap.set("n", "<leader>fw", "<cmd>Telescope live_grep_args<cr>", { desc = "Find Word" })
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Find Diagnostics" })
vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Find Resume" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope git_submodules<cr>", { desc = "Find Git submodules" })
vim.keymap.set("n", "<leader>ls", require("aerial").toggle, { desc = "Find Document Symbols" })
vim.keymap.set("n", "<leader>fS", builtin.lsp_dynamic_workspace_symbols, { desc = "Find Workspace Symbols" })
vim.keymap.set("n", "<leader>f/", function()
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_ivy({
		previewer = true,
		skip_empty_lines = true,
	}))
end, { desc = "Find / Fuzzily search in current buffer" })
