return {
	"neovim/nvim-lspconfig",
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true },
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
	{ "nvimtools/none-ls.nvim" },
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
