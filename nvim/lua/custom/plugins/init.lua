return {
	{ "ThePrimeagen/vim-be-good", cmd = "VimBeGood", cond = not vim.g.vscode },
	{ "alec-gibson/nvim-tetris", cmd = "Tetris", cond = not vim.g.vscode },
	{ "tpope/vim-fugitive", cmd = "Git", cond = not vim.g.vscode },
	{ "mbbill/undotree", cmd = "UndotreeToggle", cond = not vim.g.vscode },
	{ "2kabhishek/co-author.nvim", cmd = "CoAuthor" },
	"tpope/vim-commentary",
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
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
			})
		end,
		cond = not vim.g.vscode,
	},
	{
		"mrded/nvim-lsp-notify",
		dependencies = { "rcarriga/nvim-notify" },
		config = function()
			require("lsp-notify").setup({
				icons = false,
			})
		end,
		cond = not vim.g.vscode,
	},
	-- "ggandor/leap.nvim"
}
