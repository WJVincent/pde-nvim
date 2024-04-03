return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	build = ":TSUpdate",
	config = function()
		local ts = require("nvim-treesitter")
		ts.setup({
			highlight = { enable = true, additional_vim_regex_highlighting = true },
			ensure_installed = {
				"json",
				"javascript",
				"html",
				"css",
				"bash",
				"lua",
				"markdown",
				"markdown_inline",
				"c",
			},
			auto_install = true,
			rainbow = {
				enable = true,
				extended_mode = true
			}
		})
	end,
}
