return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons", lazy = true },
	},
	opts = {
		options = {
			component_separators = "",
			section_separators = { left = "", right = "" },
			theme = "catppuccin",
		},
		extensions = { "oil", "fugitive" },
	},
}
