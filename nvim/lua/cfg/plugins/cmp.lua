return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			---@diagnostic disable-next-line: missing-fields
			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				sources = {
					{ name = "path" },
					{ name = "nvim_lsp" },
					{ name = "buffer", keyword_length = 3 },
					{ name = "luasnip", keyword_length = 2 },
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = {
					["<C-Space>"] = cmp.mapping.complete(),
					["<Tab>"] = cmp.mapping.confirm({ select = true }),
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
				},
			})

			---@diagnostic disable-next-line: missing-fields
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
		cond = not vim.g.vscode,
		event = { "InsertEnter", "CmdlineEnter" },
	},
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		cond = not vim.g.vscode,
		config = function()
			local ls = require("luasnip")
			require("luasnip.loaders.from_vscode").lazy_load()
			ls.config.setup()

			local s = ls.snippet
			local sn = ls.snippet_node
			local t = ls.text_node
			local i = ls.insert_node
			-- local f = ls.function_node
			local c = ls.choice_node
			-- local d = ls.dynamic_node
			-- local r = ls.restore_node
			local rep = require("luasnip.extras").rep

			ls.add_snippets("toml", {
				s("card", {
					c(1, {
						sn("normal", {
							t({ "[[cards]]", 'term = "' }),
							i(1, "term"),
							t({ '"', 'definition = "' }),
							i(2, "definition"),
							t({ '"', "" }),
						}),
						sn("latin", {
							t({ "[[cards]]", "term = '''", "L. " }),
							i(1, "lines"),
							t(' "'),
							i(2, "quote"),
							t({ '"', "'''", "definition = '''", "L. " }),
							rep(1),
							t(' "'),
							i(3, "translation"),
							t({ '"', "" }),
							i(4, "explanation"),
							t({ "", "'''", "" }),
						}),
						sn("tex", {
							t({ "[[cards]]", 'term = "' }),
							i(1, "term"),
							t({ '"', "definition = { text = '''", "" }),
							i(2, "definition"),
							t({ "", "''', format = \"tex\" }", "" }),
						}),
					}),
				}),
			})

			vim.keymap.set({ "i", "s" }, "<C-L>", function()
				ls.jump(1)
			end, { silent = true })

			vim.keymap.set({ "i", "s" }, "<C-H>", function()
				ls.jump(-1)
			end, { silent = true })

			vim.keymap.set({ "i", "s" }, "<C-E>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, { silent = true })
		end,
	},
}
