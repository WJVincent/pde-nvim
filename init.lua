-- map leader key
-- do this before loading plugins
-- any plugins mapping to <leader> will then use your definition rather than the default

-- vim.g is used to set a global variable
-- vim.wo is used to set a local (window) option
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.wo.relativenumber = true

-- imports
require("lazy-setup")
require("telescope-setup")
require("harpoon-setup")
require("options")
require("keymaps")

-- highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
