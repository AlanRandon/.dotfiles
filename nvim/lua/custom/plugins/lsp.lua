return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		cond = not vim.g.vscode,
		config = function() end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		cond = not vim.g.vscode,
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true },
	{
		"mrcjkb/rustaceanvim",
		cond = not vim.g.vscode,
		version = "^3",
		ft = { "rust" },
	},
	{
		"nvimtools/none-ls.nvim",
		cond = not vim.g.vscode,
		config = function() end,
	},
}
