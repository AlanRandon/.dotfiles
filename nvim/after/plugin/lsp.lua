local set = vim.keymap.set
local telescope_builtin = require("telescope.builtin")

set("n", "gd", vim.lsp.buf.definition, { desc = "LSP: [G]oto [D]efinition" })
set("n", "gr", telescope_builtin.lsp_references, { desc = "LSP: [G]oto [R]eferences" })
set("n", "gI", vim.lsp.buf.implementation, { desc = "LSP: [G]oto [I]mplementation" })
set("n", "gt", vim.lsp.buf.type_definition, { desc = "LSP: [G]oto [T]ype Definition" })

set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP: [R]e[n]ame" })
set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: [C]ode [A]ction" })

set("n", "[d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "LSP: Goto Next [D]iagnostic" })

set("n", "]d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "LSP: Goto Previous [D]iagnostic" })

set("n", "<leader>ds", telescope_builtin.lsp_document_symbols, { desc = "LSP: [D]ocument [S]ymbols" })
set("n", "<leader>ws", telescope_builtin.lsp_dynamic_workspace_symbols, { desc = "LSP: [W]orkspace [S]ymbols" })

set("n", "K", function()
	vim.lsp.buf.hover({ border = "rounded" })
end, { desc = "LSP: Hover Documentation" })

set("n", "<leader>ih", ":InlayHintsToggle<CR>", { desc = "LSP: Toggle [I]nlay [H]ints" })

set({ "i", "n" }, "<C-s>", vim.lsp.buf.signature_help, { desc = "LSP: [S]ignature Help" })

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

vim.g.haskell_tools = {
	hls = {},
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
		null_ls.builtins.completion.spell.with(writing_mode_source),
		null_ls.builtins.hover.dictionary.with(writing_mode_source),
	},
})

local lspconfig = require("lspconfig")

require("mason").setup({ PATH = "append" })
require("mason-lspconfig").setup({
	automatic_installation = false,
	ensure_installed = {
		"lua_ls",
		"cssls",
		"emmet_ls",
		"html",
		"tailwindcss",
		"texlab",
	},
	handlers = {
		function(server_name)
			lspconfig[server_name].setup({
				capabilities = capabilities,
			})
		end,
		asm_lsp = function()
			lspconfig["asm_lsp"].setup({
				capabilities = capabilities,
				filetypes = { "asm", "vmasm", "nasm" },
			})
		end,
		-- rustaceanvim handles this
		rust_analyzer = function() end,
	},
})

lspconfig.ocamllsp.setup({
	capabilities = capabilities,
	settings = {
		codelens = { enable = true },
		inlayHints = { enable = true },
	},
})

lspconfig.zls.setup({
	capabilities = capabilities,
})

lspconfig.clangd.setup({
	capabilities = capabilities,
})

lspconfig.nixd.setup({
	capabilities = capabilities,
	settings = {
		nixd = {
			formatting = {
				command = { "nixfmt" },
			},
		},
	},
})

lspconfig.texlab.setup({
	capabilities = capabilities,
	settings = {
		texlab = {
			build = {
				executable = "tectonic",
				args = { "-X", "build" },
				onSave = true,
			},
		},
	},
})
