-- 提升速度
vim.loader.enable()
-- 基本设置
require("basic")
-- 按键绑定
require("keybindings")
-- 插件初始化
require("lazyinit")
-- 主题设置
vim.cmd.colorscheme("base16-solarized-light")
