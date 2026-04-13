return {
	settings = {
		Lua = {
			-- 过滤全局vim变量报错
			diagnostics = {
				globals = { "vim", "hs" },
			},
		},
	},
}
