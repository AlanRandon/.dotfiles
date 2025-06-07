return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function() end,
	},
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
	{
		"nvimtools/none-ls.nvim",
		config = function() end,
	},
	{
		"Julian/lean.nvim",
		opts = {
			abbreviations = { builtin = true },
			lsp = {},
			mappings = true,
		},
	},
}
