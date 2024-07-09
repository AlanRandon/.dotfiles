return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"https://codeberg.org/FelipeLema/cmp-async-path.git",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			require("custom.completion")
		end,
		cond = not vim.g.vscode,
		event = { "InsertEnter", "CmdlineEnter" },
	},
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		cond = not vim.g.vscode,
		config = function()
			require("custom.snippet")
		end,
	},
}
