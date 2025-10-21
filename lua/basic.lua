-- vim.o: 全局属性
-- vim.bo: 缓冲区属性
-- vim.wo: 窗口属性

-- 行号展示
vim.o.number = true
-- 自动识别UNIX格式
vim.o.fileformats = unix
-- utf8
vim.g.encoding = "UTF-8"
vim.o.fileencoding = "utf-8"
-- 显示行号左侧图标指示列
vim.o.signcolumn = "yes"
-- 缩进2个空格等于一个Tab
vim.o.tabstop = 2
vim.bo.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftround = true
-- >> << 时移动长度
vim.o.shiftwidth = 2
vim.bo.shiftwidth = 2
-- 新行对齐当前行
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.smartindent = true
-- 搜索大小写不敏感，除非包含大写
vim.o.ignorecase = true
vim.o.smartcase = true
-- 搜索不要高亮
vim.o.hlsearch = false
-- 边输入边搜索
vim.o.incsearch = true
-- 高亮当前所在行
vim.o.cursorline = true
-- 命令行高为1，节省空间
vim.o.cmdheight = 1
-- 底部无需显示模式，通过插件去处理
vim.o.showmode = false
-- 设置 timeoutlen 为等待键盘快捷键连击时间500毫秒，可根据需要设置
vim.o.timeoutlen = 500
-- 不允许隐藏被修改过的buffer,tsserver lsp有个坑，4.1.0及以上无法重新检测,暂时关闭
-- vim.o.hidden = false
vim.o.hidden = true
-- 开启真颜色
vim.o.termguicolors = true
-- vim.o.undofile = true
-- 分屏在右侧
vim.o.splitright = true

-- 启用鼠标
vim.o.mouse = "a"
-- 备份和撤销文件设置
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.undodir = vim.fn.stdpath('data') .. '/undodir'
vim.o.undofile = true
-- 更好的搜索
vim.o.grepprg = "rg --vimgrep"
vim.o.grepformat = "%f:%l:%c:%m"
-- 折叠
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
-- 更新时间
vim.o.updatetime = 100
