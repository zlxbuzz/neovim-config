if vim.g.loaded_codex_nvim == 1 then
	return
end

vim.g.loaded_codex_nvim = 1

require("codex").setup()
