local harpoon = require("harpoon")
harpoon:setup({})

-- basic telescope configuration
local conf = require("telescope.config").values

local function toggle_telescope(harpoon_files)
	local file_paths = {}

	for _, item in ipairs(harpoon_files.items) do
		table.insert(file_paths, item.value)
	end

	require("telescope.pickers")
		.new({}, {
			prompt_title = "Harpoon",
			finder = require("telescope.finders").new_table({
				results = file_paths,
			}),
			previewer = conf.file_previewer({}),
			sorter = conf.generic_sorter({}),
		})
		:find()
end

vim.keymap.set("n", "<leader>he", function()
	toggle_telescope(harpoon:list())
end, { desc = "[h]arpoon [e]xplorer" })

vim.keymap.set("n", "<leader>hp", function()
	harpoon:list():prev()
end, { desc = "[h]arpoon [p]rev" })

vim.keymap.set("n", "<leader>hn", function()
	harpoon:list():next()
end, { desc = "[h]arpoon [n]ext" })

vim.keymap.set("n", "<leader>ha", function()
	harpoon:list():add()
end, { desc = "[h]arpoon [a]dd" })
