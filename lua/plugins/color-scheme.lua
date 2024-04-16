return {
	"Mofiqul/dracula.nvim",
	priority = 1000,
	config = function()
		local dracula = require("dracula")
		local colors = require("dracula").colors()
		dracula.setup({
			overrides = {
				NormalFloat = {
					fg = colors.fg,
					bg = colors.selection,
				},
			},
		})
		vim.cmd.colorscheme("dracula")
	end,
}
-- return {
-- 	"ellisonleao/gruvbox.nvim",
-- 	priority = 1000,
-- 	config = function()
-- 		vim.o.background = 'dark'
-- 		vim.cmd.colorscheme("gruvbox")
-- 	end,
-- }