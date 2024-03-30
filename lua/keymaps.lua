--[[
Command Mnemonics

[f] - files 
[s] - search
[c] - code 

]]--

-- register command group labels
local wk = require('which-key')

wk.register({
	["<leader>f"] = { name = "+file" },
	["<leader>s"] = { name = "+search" },
    ["<leader>c"] = { name = "+code" }
})

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set("n", "<leader>fe", ":Telescope file_browser<CR>", { desc = 'file [e]xplorer' })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'file [f]ind' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').git_files, { desc = 'file in [g]it' })

vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = 'search [h]elp' })
vim.keymap.set('n', '<leader>sG', require('telescope.builtin').live_grep, { desc = '[G]rep search in dir' })
vim.keymap.set('n', '<leader>sg', ':LiveGrepGitRoot<cr>', { desc = '[g]rep search git files or cwd' })
vim.keymap.set('n', '<leader>cd', require('telescope.builtin').diagnostics, { desc = 'view [c]ode [d]iagnostics' })
vim.keymap.set('n', '<leader>sf', function()
	require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
		winblend = 10,
		previewer = false,
	})
end, { desc = 'fuzzy search current [f]ile/buffer' })

-- lsp keymaps
vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'go to [definition]'})
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = '[c]ode [a]ction' })
