vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

vim.api.nvim_create_user_command("InlayHintsToggle", function()
	---@diagnostic disable-next-line missing-parameter
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, {})

local function on_attach(client, bufnr)
	local function nmap(key, action, desc)
		vim.keymap.set("n", key, action, { buffer = bufnr, desc = ("LSP: %s"):format(desc) })
	end

	nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	nmap("gt", vim.lsp.buf.type_definition, "[G]oto [T]ype Definition")

	nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

	nmap("[d", vim.diagnostic.goto_next, "Goto Next [D]iagnostic")
	nmap("]d", vim.diagnostic.goto_prev, "Goto Previous [D]iagnostic")

	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("<leader>ih", ":InlayHintsToggle<CR>", "Toggle [I]nlay [H]ints")

	vim.keymap.set(
		{ "i", "n" },
		"<C-s>",
		vim.lsp.buf.signature_help,
		{ buffer = bufnr, desc = "LSP: [S]ignature Help" }
	)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

vim.g.haskell_tools = {
	hls = {
		on_attach = on_attach,
	},
}

vim.g.rustaceanvim = {
	inlay_hints = {
		highlight = "NonText",
	},
	tools = {
		inlay_hints = {
			auto = false,
		},
	},
	server = {
		handlers = {
			-- errors without
			["experimental/serverStatus"] = function() end,
		},
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			["rust-analyzer"] = {
				checkOnSave = {
					command = "clippy",
				},
			},
		},
	},
}

local null_ls = require("null-ls")

vim.g.writing_mode = false
local writing_mode_source = {
	filetypes = {},
	runtime_condition = function()
		return vim.g.writing_mode
	end,
}

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.ocamlformat,
		null_ls.builtins.formatting.nixpkgs_fmt,
		null_ls.builtins.completion.spell.with(writing_mode_source),
		null_ls.builtins.hover.dictionary.with(writing_mode_source),
	},
})

require("mason").setup()
require("mason-lspconfig").setup({
	automatic_installation = false,
	ensure_installed = {
		"rust_analyzer",
		"lua_ls",
		"cssls",
		"emmet_ls",
		"html",
	},
	handlers = {
		function(server_name)
			require("lspconfig")[server_name].setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
		end,
		asm_lsp = function()
			require("lspconfig")["asm_lsp"].setup({
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "asm", "vmasm", "nasm" },
			})
		end,
		-- rustaceanvim handles this
		rust_analyzer = function() end,
	},
})

require("lspconfig").ocamllsp.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		codelens = { enable = true },
		inlayHints = { enable = true },
	},
})

require("lspconfig").zls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})
