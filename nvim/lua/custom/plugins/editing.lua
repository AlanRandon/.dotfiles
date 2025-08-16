return {
	{ "tpope/vim-repeat", event = "VeryLazy" },
	{ "mbbill/undotree", cmd = "UndotreeToggle" },
	"tpope/vim-commentary",
	{
		"kylechui/nvim-surround",
		version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
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
