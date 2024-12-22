return {
	{ "krady21/compiler-explorer.nvim" },
	{ "ThePrimeagen/vim-be-good", cmd = "VimBeGood" },
	{ "NStefan002/speedtyper.nvim", cmd = "Speedtyper", opts = {} },
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
	},
	{ "tpope/vim-fugitive", cmd = "Git" },
	{ "tpope/vim-repeat", event = "VeryLazy" },
	{ "mbbill/undotree", cmd = "UndotreeToggle" },
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
	},
}
