return {
	"neovim/nvim-lspconfig",
	"nvimtools/none-ls.nvim",
	{
		"mrcjkb/rustaceanvim",
		version = "^6",
		lazy = false,
	},
	{
		"mrcjkb/haskell-tools.nvim",
		version = "^4",
		dependencies = {},
		lazy = false,
	},
	{
		"Julian/lean.nvim",
		event = { "BufReadPre *.lean", "BufNewFile *.lean" },
		opts = {
			abbreviations = { builtin = true },
			lsp = {},
			mappings = true,
		},
	},
}
