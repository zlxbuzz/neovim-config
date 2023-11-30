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
					  " 显示隐藏文件
					 let g:NERDTreeShowHidden = 1


		        " 默认是否用 l 代替 o 打开文件
		        let g:NERDTreeMapActivateNode= 'l'
		        " let g:NERDTreeMapActivateNode= 'l'
		        " 目录树菜单操作
		        let g:NERDTreeMapMenu = 'o'
		        " 自动打开
		        " autocmd vimenter * NERDTree
		        " NerdTree没有箭头
		        let g:NERDTreeDirArrows = 0

		        let g:NERDTreeDirArrowCollapsible = '-'
		        let g:NERDTreeDirArrowExpandable = '+'

					]])
		end,
		dependencies = "Xuyuanp/nerdtree-git-plugin",

	},
	{
		-- file icon
		'ryanoasis/vim-devicons'
	}
}
