return {
	{ "ThePrimeagen/vim-be-good", cmd = "VimBeGood" },
	{
		"m4xshen/hardtime.nvim",
		lazy = false,
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = { enabled = false },
	},
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
}
