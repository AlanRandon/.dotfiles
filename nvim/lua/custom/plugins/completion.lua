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
				default = { "lazydev", "lsp", "snippets", "co_author" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
					snippets = {
						score_offset = 200,
					},
					co_author = {
						name = "CoAuthor",
						module = "blink-cmp-co-author",
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
