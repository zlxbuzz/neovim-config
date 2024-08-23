-- lsp相关配置，包括快捷键绑定
-- require("neoconf").setup({})

-- 设置不同语言
local servers   = {
	lua_ls = {
		Lua = {
			-- 过滤全局vim变量报错
			diagnostics = {
				globals = { "vim", "hs" },
			},
		}
	},
	eslint = {},
	cssls = {},
	-- emmet_ls = {
	-- 	filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "svelte", "pug", "typescriptreact", "vue" },
	-- 	init_options = {
	-- 		html = {
	-- 			options = {
	-- 				-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L26
	-- 				["bem.enabled"] = true,
	-- 			},
	-- 		},
	-- 	},
	-- },
	tailwindcss = {},
	tsserver = {
		-- Volar 2.0不提供tsserver, 需要特殊配置全局install @vue/typescript-plugin
		init_options = {
			plugins = {
				{
					name = "@vue/typescript-plugin",
					location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
					languages = { "javascript", "typescript", "vue" },
				},
			},
		},
		filetypes = {
			"javascript",
			"typescript",
			"vue",
		},

	},
	html = {},
	jsonls = {},
	-- volar = {
	-- 	filetypes = { 'typescript', 'javascript', 'vue' }
	-- }
}

local on_attach = function(_, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

	-- Buffer local mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local opts = { buffer = bufnr }
	-- 跳转到当前光标处词条（会用下划线标出）的声明位置。按<C-t>跳转回去。
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
	-- 跳转到当前光标处词条的定义位置。按<C-t>跳转回去。
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
	-- 展示当前光标处词条的详细信息（如变量的类别信息/函数的签名/库的介绍等）。
	vim.keymap.set('n', 'K', "<cmd>Lspsaga hover_doc<cr>", opts)
	-- 展示当前光标处词条的所有实现
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
	vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
	vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
	vim.keymap.set('n', '<space>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts)
	vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
	-- 通过lspsaga美化
	vim.keymap.set('n', '<space>rn', "<cmd>Lspsaga rename ++project<cr>", opts)
	vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
	-- 查看所有语法错误
	vim.keymap.set('n', '<leader>da', require "telescope.builtin".diagnostics, opts)
	-- 查看语法错误
	vim.keymap.set('n', '<space>e', '<cmd>Lspsaga diagnostic_jump_next<cr>', opts)
	-- 格式化
	vim.keymap.set('n', '<leader>f', function()
		vim.lsp.buf.format { async = true }
	end, opts)
end

-- lsp加载
require('mason').setup()

-- 给lsp添加自动补全的能力，结合cmp插件
local capabilities = require('cmp_nvim_lsp').default_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true


require('mason-lspconfig').setup({
	-- 自动安装
	ensure_installed = vim.tbl_keys(servers),
})
for server, config in pairs(servers) do
	require("lspconfig")[server].setup(
		vim.tbl_deep_extend("keep",
			{
				on_attach = on_attach,
				capabilities = capabilities
			},
			config
		)
	)
end


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


-- git修改内容提示
require('gitsigns').setup({
	on_attach = function()
		local gs = package.loaded.gitsigns
		-- <Leader>gf 查看diff内容
		vim.keymap.set('n', '<Leader>gf', gs.diffthis)
	end
})
