return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		keymaps = {
			["gm"] = {
				function()
					local oil = require("oil")

					local dir = oil.get_current_dir()
					if not dir then
						return
					end

					vim.system({ "mpv", dir }, { detach = true })
				end,
				desc = "Open the current directory in mpv",
			},
		},
	},
	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	lazy = false,
	keys = {
		{ "-", "<cmd>Oil<cr>", desc = "File Tree" },
	},
}
