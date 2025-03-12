--[[
Command Mnemonics

[f] - files
[s] - search
[c] - code

]]
--

local set = vim.keymap.set

local function trim(s)
	local l = 1
	while string.sub(s, l, l) == " " do
		l = l + 1
	end
	local r = string.len(s)
	while string.sub(s, r, r) == " " do
		r = r - 1
	end
	return string.sub(s, l, r)
end

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
			table.insert(res_split, trim(line))
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
	local cmd = "node " .. curr_file_path .. " > tmp"
	local out = os.execute(cmd)
	print(out)
	local res_split = {}

	for line in io.lines("tmp") do
		table.insert(res_split, trim(line))
	end

	os.execute("rm tmp")
	if out == 0 then
		for i, v in ipairs(res_split) do
			if i == 1 then
				vim.api.nvim_buf_set_lines(buf, 0, -1, false, { v })
			else
				vim.api.nvim_buf_set_lines(buf, -1, -1, false, { v })
			end
		end
	else
		vim.api.nvim_buf_set_lines(
			buf,
			0,
			-1,
			false,
			{ "something went wrong, go run this in a terminal you lazy git" }
		)
	end
end

function string:endswith(suffix)
	---@diagnostic disable-next-line: param-type-mismatch
	return self:sub(-#suffix) == suffix
end

local function attempt_to_compile()
	local width = 100
	local height = 10

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

-- register command group labels
local wk = require("which-key")
wk.add({
	{ "<leader>f", group = "+file" },
	{ "<leader>s", group = "+search" },
	{ "<leader>c", group = "+code" },
})

-- misc
set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "find existing buffers" })
set("n", "K", vim.lsp.buf.hover, {})
set("n", "gd", vim.lsp.buf.definition, { desc = "go to [d]efinition" })
set("n", "<leader>t", toggle_line_numbers, { desc = "[t]oggle rel line nums" })
set("n", "<leader>ww", "<cmd>lua require('kiwi').open_wiki_index()<cr>")

-- [s]earch
set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "search [h]elp" })
set("n", "<leader>sG", require("telescope.builtin").live_grep, { desc = "[G]rep search in dir" })
set("n", "<leader>sg", ":LiveGrepGitRoot<cr>", { desc = "[g]rep search git files or cwd" })
set("n", "<leader>sf", function()
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "fuzzy search current [f]ile/buffer" })

-- [file]
set("n", "<leader>fe", require("oil").toggle_float, { desc = "file [e]xplorer" })
set("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "[f]ind all files" })
set("n", "<leader>fg", require("telescope.builtin").git_files, { desc = "find file in [g]it" })

-- [c]ode
set("n", "<leader>cc", attempt_to_compile, { desc = "attempt to [c]ompile/run" })
set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "code [r]ename" })
set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "code [a]ction" })
set("n", "<leader>cf", vim.lsp.buf.format, { desc = "code [f]ormat" })
set("n", "<leader>cd", require("telescope.builtin").diagnostics, { desc = "code [d]iagnostics" })

-- split navigation
set("n", "<c-j>", "<c-w><c-j>")
set("n", "<c-k>", "<c-w><c-k>")
set("n", "<c-l>", "<c-w><c-l>")
set("n", "<c-h>", "<c-w><c-h>")
