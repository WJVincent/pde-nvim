--[[
Command Mnemonics

[f] - files 
[s] - search

]]--

-- register command group labels
local wk = require('which-key')

wk.register({
	["<leader>f"] = { name = "+file" },
	["<leader>s"] = { name = "+search" }
})

-- dont allow space in normal or visual mod]e
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- telescope keymaps
vim.keymap.set("n", "<leader>fe", ":Telescope file_browser<CR>", { desc = 'file [e]xplorer' })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'file [f]ind' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').git_files, { desc = 'file in [g]it' })

vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = 'search [h]elp' })
vim.keymap.set('n', '<leader>sG', require('telescope.builtin').live_grep, { desc = '[G]rep search in dir' })
vim.keymap.set('n', '<leader>sg', ':LiveGrepGitRoot<cr>', { desc = '[g]rep search git files or cwd' })
vim.keymap.set('n', '<leader>sf', function()
	require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
		winblend = 10,
		previewer = false,
	})
end, { desc = 'fuzzy search current [f]ile/buffer' })
