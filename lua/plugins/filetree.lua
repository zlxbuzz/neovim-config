return {
	{
		"preservim/nerdtree",
		cmd = { "NERDTreeClose", "NERDTreeToggle", "NERDTree", "NERDTreeFind", "NerdSmartLocated" },

		keys = {
			{ "<leader>t", ":NERDTreeToggle<CR>", desc = "toggle" },
		},
		init = function()
			vim.cmd([[
		       let g:NERDTreeMinimalMenu=1
		       let g:NERDTreeMinimalUI = 1
		       let g:NERDTreeWinSize = 27

		        " 默认是否用 l 代替 o 打开文件
		        let g:NERDTreeMapActivateNode= 'l'
		        " let g:NERDTreeMapActivateNode= 'l'
		        " 目录树菜单操作
		        let g:NERDTreeMapMenu = 'o'
		        " 自动打开
		"       autocmd vimenter * NERDTree
		        " NerdTree没有箭头
		        let g:NERDTreeDirArrows = 0

		        let g:NERDTreeDirArrowCollapsible = '-'
		        let g:NERDTreeDirArrowExpandable = '+'
						autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
		    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

					]])
		end,
		dependencies = "Xuyuanp/nerdtree-git-plugin",

	},
	{
		-- file icon
		'ryanoasis/vim-devicons'
	}
}
