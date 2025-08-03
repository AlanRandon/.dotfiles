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
				documentation = { window = { border = "rounded" } },
				menu = { auto_show = false, border = "rounded" },
			},
			keymap = {
				["<C-x><C-f>"] = {
					function(cmp)
						return cmp.show({ providers = { "path" } })
					end,
				},
				["<C-x><C-n>"] = {
					function(cmp)
						return cmp.show({ providers = { "buffer" } })
					end,
				},
				["<C-y>"] = false,
				["<C-k>"] = false,
				["<S-Tab>"] = false,
				["<C-s>"] = {
					"show_signature",
					"hide_signature",
					"fallback",
				},
				["<Tab>"] = {
					function(cmp)
						if cmp.snippet_active() then
							return cmp.accept()
						else
							return cmp.select_and_accept()
						end
					end,
					"fallback",
				},
			},
			snippets = { preset = "luasnip" },
			sources = {
				default = { "lazydev", "lsp", "snippets" },
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
