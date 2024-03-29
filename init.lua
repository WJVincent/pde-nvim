-- map leader key
-- do this before loading plugins
-- any plugins mapping to <leader> will then use your definition rather than the default

-- vim.g is used to set a global variable
-- vim.wo is used to set a local (window) option
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.wo.relativenumber = true

require('lazy-setup')
