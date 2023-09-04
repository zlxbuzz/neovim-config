-- 提升速度
vim.loader.enable()
-- 基本设置
require('basic')
-- 按键绑定
require('keybindings')

-- 插件管理
-- :echo stdpath('data') ,默认为~/.local/share/nvim/
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

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

-- 主题设置
vim.cmd.colorscheme("base16-solarized-light")
