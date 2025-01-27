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
				ghost_text = { enabled = true },
				documentation = { window = { border = "single" } },
				menu = { auto_show = false, border = "single" },
			},
			keymap = {
				["<C-y>"] = {},
				["<S-Tab>"] = {},
				["<Tab>"] = {
					function(cmp)
						if cmp.snippet_active() then
							return cmp.accept()
						else
							return cmp.select_and_accept()
						end
					end,
					"snippet_forward",
					"fallback",
				},
			},
			snippets = { preset = "luasnip" },
			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
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
