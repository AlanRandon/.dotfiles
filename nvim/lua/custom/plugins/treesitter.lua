return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		branch = "main",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").install({
				"haskell",
				"blueprint",
				"python",
				"protobuf",
				"rust",
				"toml",
				"zig",
				"nasm",
				"sql",
				"nix",
				"ocaml",
				"markdown",
				"typst",
				"latex",
				"html",
				"typescript",
				"javascript",
				"css",
				"json",
				-- required
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
			})

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("custom.treesitter-highlight", { clear = true }),
				callback = function(ev)
					pcall(vim.treesitter.start, ev.buf)
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
	},
}
