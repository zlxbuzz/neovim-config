-- lsp加载
require('mason').setup()
require('mason-lspconfig').setup()


-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local nvim_lsp = require("lspconfig")
-- lua
nvim_lsp.lua_ls.setup({
	capabilities = capabilities,
	settings = {
		Lua = {
			-- 过滤全局vim变量报错
			diagnostics = {
				globals = { "vim", "hs" },
			},
		}
	}
})
-- ts
nvim_lsp.tsserver.setup({
	capabilities = capabilities
})

-- volar
nvim_lsp.volar.setup({
	capabilities = capabilities,
	filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' }
})

local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- register any number of sources simultaneously
local sources = {
	null_ls.builtins.formatting.lua_format,
	null_ls.builtins.formatting.prettier,
}

null_ls.setup({
	sources = sources,
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
					-- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
					vim.lsp.buf.format({ async = false })
				end,
			})
		end
	end,
})


-- lsp快捷键
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		-- 跳转到当前光标处词条（会用下划线标出）的声明位置。按<C-t>跳转回去。
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		-- 跳转到当前光标处词条的定义位置。按<C-t>跳转回去。
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		-- 展示当前光标处词条的详细信息（如变量的类别信息/函数的签名/库的介绍等）。
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		-- 展示当前光标处词条的所有实现
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set('n', '<space>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		-- 格式化
		vim.keymap.set('n', '<leader>f', function()
			vim.lsp.buf.format { async = true }
		end, opts)
	end,
})


-- git修改内容提示
require('gitsigns').setup({
	on_attach = function()
		local gs = package.loaded.gitsigns
		-- <Leader>gf 查看diff内容
		vim.keymap.set('n', '<Leader>gf', gs.diffthis)
	end
})
