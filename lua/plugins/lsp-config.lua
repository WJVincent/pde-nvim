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
					"hls",
					"elixirls",
					"gopls",
					"pyright",
					"emmet_ls",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
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
			lspconfig.bashls.setup({ capabilities = capabilities })
			lspconfig.clangd.setup({ capabilities = capabilities })
			lspconfig.cssls.setup({ capabilities = capabilities })
			lspconfig.html.setup({ capabilities = capabilities })
			lspconfig.htmx.setup({ capabilities = capabilities })
			lspconfig.jsonls.setup({ capabilities = capabilities })
			lspconfig.tsserver.setup({ capabilities = capabilities })
			lspconfig.marksman.setup({ capabilities = capabilities })
			lspconfig.hls.setup({ capabilities = capabilities })
			lspconfig.gopls.setup({ capabilities = capabilities, single_file_support = true })
			lspconfig.pyright.setup({ capabilities = capabilities })
			lspconfig.emmet_ls.setup({ capabilities = capabilities })
			lspconfig.elixirls.setup({
				capabilities = capabilities,
				cmd = { "/home/wvincent/.elixir-ls/release/language_server.sh" },
				dialyzerEnabled = true,
				fetchDeps = false,
				enableTestLenses = false,
				suggestSpecs = false,
			})
		end,
	},
}
