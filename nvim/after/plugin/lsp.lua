-- Only load on native
if not vim.g.vscode then
	local lsp = require("lsp-zero").preset({})

	lsp.preset("recommended")

	-- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
	lsp.ensure_installed({
		"lua_ls",
		"rust_analyzer"
	})

	local cmp = require("cmp")
	local cmp_action = require("lsp-zero").cmp_action()

	cmp.setup({
		sources = {
			{ name = "nvim_lua" },
			{ name = "path" },
			{ name = "nvim_lsp" },
			{ name = "buffer",  keyword_length = 3 },
			{ name = "luasnip", keyword_length = 2 },
		},
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		mapping = {
			["<C-Space>"] = cmp.mapping.complete(),
			["<Tab>"] = cmp.mapping.confirm({ select = true }),
			["<C-n>"] = cmp_action.luasnip_jump_forward(),
			["<C-p>"] = cmp_action.luasnip_jump_backward(),
		}
	})

	local function on_attach(client, bufnr)
		local opts = { buffer = bufnr, remap = false }

		lsp.buffer_autoformat()

		vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
		vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
		vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
		vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
		vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
		vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
		vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
		vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
		vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
		vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
	end

	lsp.on_attach(on_attach)

	lsp.skip_server_setup({ "rust_analyzer" })

	-- lua/neovim config config
	local runtime_path = vim.split(package.path, ";")
	table.insert(runtime_path, "lua/?.lua")
	table.insert(runtime_path, "lua/?/init.lua")

	require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls({
		settings = {
			Lua = {
				runtime = {
					path = runtime_path
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file('', true),
				},
			}
		}
	}))

	lsp.setup()

	-- rust config
	local rust_tools = require("rust-tools")

	rust_tools.setup({
		server = {
			on_attach = function(client, bufnr)
				on_attach(client, bufnr)
				rust_tools.inlay_hints.set()
				vim.keymap.set("n", "<leader>K", rust_tools.hover_actions.hover_actions,
					{ buffer = bufnr, remap = false })
			end,
			settings = {
				["rust-analyzer"] = {
					checkOnSave = {
						command = "clippy"
					},
					completions = {
						snippets = {
							custom = vim.json.decode([[
								{
									"Arc::new": {
										"postfix": "arc",
										"body": "Arc::new(${receiver})",
										"requires": "std::sync::Arc",
										"description": "Put the expression into an `Arc`",
										"scope": "expr"
									},
									"Rc::new": {
										"postfix": "rc",
										"body": "Rc::new(${receiver})",
										"requires": "std::rc::Rc",
										"description": "Put the expression into an `Rc`",
										"scope": "expr"
									},
									"Box::pin": {
										"postfix": "pinbox",
										"body": "Box::pin(${receiver})",
										"requires": "std::boxed::Box",
										"description": "Put the expression into a pinned `Box`",
										"scope": "expr"
									},
									"Ok": {
										"postfix": "ok",
										"body": "Ok(${receiver})",
										"description": "Wrap the expression in a `Result::Ok`",
										"scope": "expr"
									},
									"Err": {
										"postfix": "err",
										"body": "Err(${receiver})",
										"description": "Wrap the expression in a `Result::Err`",
										"scope": "expr"
									},
									"Some": {
										"postfix": "some",
										"body": "Some(${receiver})",
										"description": "Wrap the expression in an `Option::Some`",
										"scope": "expr"
									}
								}
							]])
						}
					}
				}
			}
		},
	})


	vim.diagnostic.config({
		virtual_text = true
	})
end