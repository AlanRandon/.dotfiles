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
			local banned_messages = { "No information available" }
			vim.notify = function(msg, ...)
				for _, banned in ipairs(banned_messages) do
					if msg == banned then
						return
					end
				end
				return require("notify")(msg, ...)
			end

			---@diagnostic disable-next-line missig-fields
			notify.setup({
				render = "wrapped-compact",
				stages = "slide",
			})

			vim.keymap.set({ "n", "v" }, "<leader>un", function()
				notify.dismiss({})
			end)
		end,
		cond = not vim.g.vscode,
	},
}
