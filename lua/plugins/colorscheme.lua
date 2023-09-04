-- 主题设置，头部展示文件路径
return {
	{
		"RRethy/nvim-base16",
		lazy = true,
	},
	{
		"utilyre/barbecue.nvim",
		dependencies = {
			"SmiteshP/nvim-navic",
		},
		config = function()
			-- require("barbecue").setup({
			-- })
		end
	}
}
