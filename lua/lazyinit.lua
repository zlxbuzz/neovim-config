-- :echo stdpath('data') ,mac默认为~/.local/share/nvim/
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

-- runtime path = rtp
vim.opt.rtp:prepend(lazypath)

-- 从lua/plugins中自动加载插件
require("lazy").setup("plugins")
