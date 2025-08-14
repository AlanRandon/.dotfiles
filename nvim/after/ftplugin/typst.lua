local o = vim.opt_local
o.wrap = true
o.spell = true

vim.keymap.set("n", "<leader>tp", ":TypstPreview<CR>", { buffer = 0 })

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local export_commands = {
	"LspTinymistExportSvg",
	"LspTinymistExportPng",
	"LspTinymistExportPdf",
	"LspTinymistExportMarkdown",
	"LspTinymistExportText",
	"LspTinymistExportQuery",
	"LspTinymistExportAnsiHighlight",
}

vim.keymap.set("n", "<leader>te", function()
	pickers
		.new({}, {
			prompt_title = "Select Export Format",
			finder = finders.new_table({
				results = export_commands,
			}),
			sorter = conf.generic_sorter({}),
			attach_mappings = function(prompt_bufnr, _)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					vim.cmd(selection[1])
				end)
				return true
			end,
		})
		:find()
end, { buffer = 0 })
