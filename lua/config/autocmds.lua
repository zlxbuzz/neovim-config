-- 自动命令配置
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- 创建基础自动命令组
local base_group = augroup("BaseConfig", { clear = true })

-- 确保撤销目录存在
autocmd("VimEnter", {
	group = base_group,
	callback = function()
		local undodir = vim.fn.stdpath('data') .. '/undodir'
		if vim.fn.isdirectory(undodir) == 0 then
			vim.fn.mkdir(undodir, 'p')
		end
	end,
})

-- 突出显示yank的文本
autocmd("TextYankPost", {
	group = base_group,
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
	end,
})

-- 自动保存文件时格式化
autocmd("BufWritePre", {
	group = base_group,
	callback = function(args)
		-- 自动去除行尾空白字符
		if vim.bo[args.buf].modifiable and not vim.bo[args.buf].readonly then
			local save_cursor = vim.fn.getpos(".")
			vim.cmd([[silent! %s/\s\+$//e]])
			vim.fn.setpos(".", save_cursor)
		end
	end,
})

-- 自动设置文件缩进
autocmd("BufEnter", {
	group = base_group,
	callback = function()
		if vim.bo.filetype == "" or vim.bo.filetype == nil then
			local filename = vim.fn.expand("%:t")
			if filename:match("%.env%.") then
				vim.bo.filetype = "sh"
			end
		end
	end,
})

-- Terminal 配置
autocmd("TermOpen", {
	group = base_group,
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.cmd("startinsert")
	end,
})