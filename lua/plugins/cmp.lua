-- 补全插件
return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-cmdline',
		'hrsh7th/nvim-cmp',
		{
			'saadparwaiz1/cmp_luasnip',
			dependencies = {

				'L3MON4D3/LuaSnip',
				dependencies = {
					"rafamadriz/friendly-snippets"
				}
			}
		}
	},
	config = function()
		-- Set up nvim-cmp.
		local has_words_before = function()
			unpack = unpack or table.unpack
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end


		require("luasnip.loaders.from_vscode").lazy_load()
		local cmp = require 'cmp'
		local luasnip = require 'luasnip'


		cmp.setup({
			snippet = {
				expand = function(args)
					-- 主要使用luadsnip
					require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			mapping = cmp.mapping.preset.insert({
				['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),
				-- shift+tab 反过来选择
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			-- 设置补全的来源
			sources = cmp.config.sources({
				-- lsp
				{ name = 'nvim_lsp' },
				-- 路径
				{ name = 'path' },
				-- 代码模块
				{ name = 'luasnip' }, -- For luasnip users.
				-- buffer,当前buffer内容
				{ name = 'buffer' },
			})
		})

		-- 定义git,/,:等操作时，选择cmp补全
		-- Set configuration for specific filetype.
		cmp.setup.filetype('gitcommit', {
			sources = cmp.config.sources({
				{ name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
			}, {
				{ name = 'buffer' },
			})
		})

		-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline({ '/', '?' }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = 'buffer' }
			}
		})

		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(':', {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = 'path' }
			}, {
				{ name = 'cmdline' }
			})
		})
	end
}
