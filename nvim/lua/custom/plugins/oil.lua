return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{ "<leader>ft", "<cmd>Oil<cr>", desc = "[F]ile [T]ree" },
	},
}
