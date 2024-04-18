vim.o.hlsearch = false                 -- dont highlight on search, its annoying
vim.o.clipboard = "unnamedplus"        -- use system clipboard
vim.o.breakindent = true               -- on line wrap keep indent level
vim.o.undofile = true                  -- allows persistent undo history
vim.o.ignorecase = true                -- ignore case when searching
vim.o.smartcase = true                 -- if search contains uppercase, become case sensitive
vim.wo.signcolumn = "yes"              -- always show the sign column
vim.o.completeopt = "menuone,noselect" -- completion menu settings
vim.o.termguicolors = true             -- enable true color (24 bit)
vim.o.guicursor = "n:hr25,i:ver25"     -- set cursor style in different modes
vim.o.cursorline = true                -- highlight current line
vim.o.timeout = true                   -- allow commands to timeout
vim.o.timeoutlen = 500                 -- timeout length of 500ms
vim.o.expandtab = true                 -- insert spaces when tab key is pressed
vim.o.tabstop = 4                      -- display width of a tab char
vim.o.softtabstop = 4                  -- number of spaces to insert for tab char
vim.o.shiftwidth = 4                   -- width of indentation and '<' '>' commands
vim.wo.number = true                   -- Make line numbers default
vim.o.conceallevel = 2
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldnestmax = 4
