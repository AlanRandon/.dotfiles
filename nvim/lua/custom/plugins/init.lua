return {
	{ "ThePrimeagen/vim-be-good", cmd = "VimBeGood", cond = not vim.g.vscode },
	{ "NStefan002/speedtyper.nvim", cmd = "Speedtyper", opts = {}, cond = not vim.g.vscode },
	{
		"ActionScripted/tetris.nvim",
		cmd = "Tetris",
		opts = {

			mappings = {
				["<Space>"] = "drop",
				h = "left",
				j = "down",
				k = "rotate",
				l = "right",
				p = "pause",
				q = "quit",
			},
		},
		cond = not vim.g.vscode,
	},
	{ "tpope/vim-fugitive", cmd = "Git", cond = not vim.g.vscode },
	{ "tpope/vim-repeat", event = "VeryLazy" },
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
