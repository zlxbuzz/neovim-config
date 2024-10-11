return {
	-- 竖线对齐
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {
			indent = { char = "|" },
			whitespace = { highlight = { "Whitespace", "NonText" } },
		},
	}
}
