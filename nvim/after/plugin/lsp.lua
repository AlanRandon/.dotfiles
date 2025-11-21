---@module "snacks"

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
				semanticHighlighting = {
					strings = {
						enable = false,
					},
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
		null_ls.builtins.formatting.djlint,
		null_ls.builtins.completion.spell.with(writing_mode_source),
		null_ls.builtins.hover.dictionary.with(writing_mode_source),
	},
})

local lsps = {
	"html",
	"cssls",
	"ts_ls",
	"blueprint_ls",
	"tinymist",
	"zls",
	"emmet_ls",
	"texlab",
	"tailwindcss",
	"taplo",
	"ruff",
	"pyright",
	"buf_ls",
	"lua_ls",
	"tinymist",
	"nixd",
	"texlab",
	"clangd",
	"ocamllsp",
	"asm_lsp",
}

for _, lsp in ipairs(lsps) do
	vim.lsp.config(lsp, { capabilities = capabilities })
	vim.lsp.enable(lsp)
end
