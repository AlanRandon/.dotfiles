return {
	{
		"stevearc/dressing.nvim",
		opts = {
			input = {
				mappings = {
					i = {
						["<C-p>"] = "HistoryPrev",
						["<C-n>"] = "HistoryNext",
					},
				},
			},
		},
		cond = not vim.g.vscode,
	},
	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		config = function()
			local notify = require("notify")
			vim.notify = notify

			---@diagnostic disable-next-line missig-fields
			notify.setup({
				render = "wrapped-compact",
				stages = "slide",
			})
		end,
		cond = not vim.g.vscode,
	},
}