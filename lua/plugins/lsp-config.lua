return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"bashls",
					"clangd",
					"cssls",
					"html",
					"htmx",
					"jsonls",
					"tsserver",
					"marksman",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
			lspconfig.bashls.setup({})
			lspconfig.clangd.setup({})
			lspconfig.cssls.setup({})
			lspconfig.html.setup({})
			lspconfig.htmx.setup({})
			lspconfig.jsonls.setup({})
			lspconfig.tsserver.setup({})
			lspconfig.marksman.setup({})
		end,
	},
}
