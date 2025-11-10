---@module "snacks"

local set = vim.keymap.set

set("n", "gd", vim.lsp.buf.definition, { desc = "LSP: [G]oto [D]efinition" })
set("n", "gr", Snacks.picker.lsp_references, { desc = "LSP: [G]oto [R]eferences" })
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

set("n", "K", function()
	vim.lsp.buf.hover({ border = "rounded" })
end, { desc = "LSP: Hover Documentation" })

set("n", "<leader>ih", ":InlayHintsToggle<CR>", { desc = "LSP: Toggle [I]nlay [H]ints" })

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

---@type (string | {[1]: string, opts: vim.lsp.Config})[]
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
	{
		"lua_ls",
		opts = {
			-- see ~/.local/share/nvim/lazy/nvim-lspconfig/lsp/lua_ls.lua
			on_init = function(client)
				if client.workspace_folders then
					local path = client.workspace_folders[1].name
					if
						path ~= vim.fn.stdpath("config")
						and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
					then
						return
					end
				end

				local library = vim.tbl_filter(function(d)
					return not d:match(vim.fn.stdpath("config") .. "/?a?f?t?e?r?")
				end, vim.api.nvim_get_runtime_file("", true))

				table.insert(library, "${3rd}/luv/library")
				table.insert(library, "${3rd}/busted/library")

				client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
					runtime = {
						version = "LuaJIT",
						-- Tell the language server how to find Lua modules same way as Neovim
						-- (see `:h lua-module-load`)
						path = {
							"lua/?.lua",
							"lua/?/init.lua",
						},
					},
					-- Make the server aware of Neovim runtime files
					workspace = {
						checkThirdParty = false,
						library = library,
					},
				})
			end,
			settings = {
				Lua = {},
			},
		},
	},
	{
		"tinymist",
		opts = {
			settings = {
				formatterMode = "typstyle",
			},
		},
	},
	{
		"nixd",
		opts = {
			settings = {
				nixd = {
					formatting = {
						command = { "nixfmt" },
					},
				},
			},
		},
	},
	{
		"texlab",
		opts = {
			settings = {
				texlab = {
					build = {
						executable = "tectonic",
						args = { "-X", "build" },
						onSave = true,
					},
				},
			},
		},
	},
	{
		"clangd",
		opts = {
			filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "hpp" },
		},
	},
	{
		"ocamllsp",
		opts = {
			settings = {
				codelens = { enable = true },
				inlayHints = { enable = true },
			},
		},
	},
	{
		"asm_lsp",
		opts = {
			filetypes = { "asm", "vmasm", "nasm" },
		},
	},
}

for _, lsp in ipairs(lsps) do
	local lsp_name
	local opts = { capabilities = capabilities }
	if type(lsp) == "string" then
		lsp_name = lsp
	else
		lsp_name = lsp[1]
		opts = vim.tbl_extend("force", opts, lsp.opts or {})
	end

	vim.lsp.enable(lsp_name)
	vim.lsp.config(lsp_name, opts)
end
