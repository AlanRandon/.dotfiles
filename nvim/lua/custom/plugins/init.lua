return {
	{ "ThePrimeagen/vim-be-good", cmd = "VimBeGood", cond = not vim.g.vscode },
	{ "NStefan002/speedtyper.nvim", cmd = "Speedtyper", opts = {}, cond = not vim.g.vscode },
	{ "alec-gibson/nvim-tetris", cmd = "Tetris", cond = not vim.g.vscode },
	{ "tpope/vim-fugitive", cmd = "Git", cond = not vim.g.vscode },
	{ "mbbill/undotree", cmd = "UndotreeToggle", cond = not vim.g.vscode },
	{ "prichrd/netrw.nvim", cond = not vim.g.vscode },
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
		"tversteeg/registers.nvim",
		cmd = "Registers",
		config = true,
		opts = {
			window = { border = "rounded", transparency = 0 },
		},
		keys = {
			{ '"', mode = { "n", "v" } },
			{ "<C-R>", mode = "i" },
		},
		name = "registers",
		cond = vim.g.vscode,
	},
}
