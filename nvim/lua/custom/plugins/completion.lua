return {
	{
		"saghen/blink.cmp",
		version = "*",
		---@module "blink.cmp"
		---@type blink.cmp.Config
		opts = {
			signature = {
				enabled = true,
				window = { show_documentation = false },
			},
			completion = {
				documentation = { window = { border = "rounded" }, auto_show = true },
				menu = { auto_show = false, border = "rounded" },
			},
			keymap = {
				["<C-y>"] = { "select_and_accept", "fallback" },
				["<C-k>"] = false,
				["<S-Tab>"] = false,
				["<C-s>"] = {
					"show_signature",
					"hide_signature",
					"fallback",
				},
				["<Tab>"] = false,
			},
			snippets = { preset = "luasnip" },
			sources = {
				default = { "lsp", "snippets" },
				providers = {
					snippets = {
						score_offset = 200,
					},
				},
			},
		},
	},
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
	},
}
