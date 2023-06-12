-- 默认leader即为\
vim.g.mapleader = "\\"
local opt = { noremap = true, silent = true }
-- 方便直接切换屏幕
vim.keymap.set("n", "<C-l>", "<C-w>l", opt)
vim.keymap.set("n", "<C-h>", "<C-w>h", opt)
vim.keymap.set("n", "<C-j>", "<C-w>j", opt)
vim.keymap.set("n", "<C-k>", "<C-w>k", opt)
-- 新增屏幕
vim.keymap.set("n", "<Leader>v", "<C-w>v", opt)
vim.keymap.set("n", "<Leader>s", "<C-w>s", opt)
-- 返回上/下一个文件
vim.keymap.set("n", "<Leader>[", "<C-o>", opt)
vim.keymap.set("n", "<Leader>]", "<C-i>", opt)
-- https://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
-- 针对屏幕过小有折行的上下移动，支持同行移动
vim.keymap.set("n", "j", [[v:count ? 'j' : 'gj']], { noremap = true, expr = true })
vim.keymap.set("n", "k", [[v:count ? 'k' : 'gk']], { noremap = true, expr = true })
-- 屏幕大小缩放
vim.keymap.set("n", "<C-Left>", ":vertical resize +5<CR>", opt)
vim.keymap.set("n", "<C-Right>", ":vertical resize -5<CR>", opt)
vim.keymap.set("n", "<C-Up>", ":resize +5<CR>", opt)
-- 上下移动选中文本
vim.keymap.set("n", "<C-Down>", ":resize -5<CR>", opt)
-- visual模式缩进
vim.keymap.set("v", "<", "<gv", opt)
vim.keymap.set("v", ">", ">gv", opt)
vim.keymap.set("v", "J", ":move '>+1<CR>gv-gv", opt)
vim.keymap.set("v", "K", ":move '<-2<CR>gv-gv", opt)
--- 注释
vim.keymap.set("n", "<Leader>c", "gcc", { remap = true })
vim.keymap.set('v', '<Leader>c', 'gc', { remap = true })
