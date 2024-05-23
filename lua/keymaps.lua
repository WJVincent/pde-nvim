--[[
Command Mnemonics

[f] - files
[s] - search
[c] - code

]]
--

local function toggle_line_numbers()
	if not vim.wo.relativenumber then
		vim.wo.relativenumber = true
	else
		vim.wo.relativenumber = false
	end
end

local function run_make_file(buf, grep_check)
	if grep_check == 0 then
		os.execute("make >> tmp")
		local res_split = {}

		for line in io.lines("tmp") do
			table.insert(res_split, line)
		end

		os.remove("tmp")

		for i, v in ipairs(res_split) do
			if i == 1 then
				vim.api.nvim_buf_set_lines(buf, 0, -1, false, { v })
			else
				vim.api.nvim_buf_set_lines(buf, -1, -1, false, { v })
			end
		end
	else
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "there is not a makefile" })
	end
end

local function run_node_js(buf, curr_file_path)
	local cmd = "node " .. curr_file_path .. " >> tmp"
	os.execute(cmd)
	local res_split = {}

	for line in io.lines("tmp") do
		table.insert(res_split, line)
	end

	os.remove("tmp")

	for i, v in ipairs(res_split) do
		if i == 1 then
			vim.api.nvim_buf_set_lines(buf, 0, -1, false, { v })
		else
			vim.api.nvim_buf_set_lines(buf, -1, -1, false, { v })
		end
	end
end

function string:endswith(suffix)
	return self:sub(-#suffix) == suffix
end

local function attempt_to_compile()
	local width = 150
	local height = 15

	local buf = vim.api.nvim_create_buf(false, true)
	local ui = vim.api.nvim_list_uis()[1]

	local opts = {
		relative = "editor",
		row = (ui.height / 2) - (height / 2),
		col = (ui.width / 2) - (width / 2),
		width = width,
		height = height,
		anchor = "NW",
		style = "minimal",
	}

	local curr_file_path = vim.fn.expand("%:p")
	if curr_file_path:endswith(".js") then
		run_node_js(buf, curr_file_path)
	else
		local handle = os.execute("ls | grep -c Makefile")
		run_make_file(buf, handle)
	end

	vim.api.nvim_open_win(buf, true, opts)
end

vim.keymap.set("n", "<leader>cc", attempt_to_compile)
-- register command group labels
local wk = require("which-key")
wk.register({
	["<leader>f"] = { name = "+file" },
	["<leader>s"] = { name = "+search" },
	["<leader>c"] = { name = "+code" },
})

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "find existing buffers" })
vim.keymap.set("n", "<leader>fe", require("oil").toggle_float, { desc = "file [e]xplorer" })
vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "file [f]ind" })
vim.keymap.set("n", "<leader>fg", require("telescope.builtin").git_files, { desc = "file in [g]it" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "search [h]elp" })
vim.keymap.set("n", "<leader>sG", require("telescope.builtin").live_grep, { desc = "[G]rep search in dir" })
vim.keymap.set("n", "<leader>sg", ":LiveGrepGitRoot<cr>", { desc = "[g]rep search git files or cwd" })
vim.keymap.set("n", "<leader>cd", require("telescope.builtin").diagnostics, { desc = "view code [d]iagnostics" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "go to [definition]" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "code [a]ction" })
vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "code [f]ormat" })
vim.keymap.set("n", "<leader>sf", function()
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "fuzzy search current [f]ile/buffer" })
vim.keymap.set("n", "<leader>t", toggle_line_numbers, { desc = "[t]oggle rel line nums" })
vim.keymap.set("n", "<leader>ww", "<cmd>lua require('kiwi').open_wiki_index()<cr>")
