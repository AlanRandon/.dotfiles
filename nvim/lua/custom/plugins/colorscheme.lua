return {
	"catppuccin/nvim",
	name = "catppuccin",
	init = function()
		local pallette = require("catppuccin.palettes.frappe")

		vim.opt.termguicolors = true

		require("catppuccin").setup({
			flavour = "frappe",
			integrations = {
				blink_cmp = true,
				notify = true,
				mason = true,
			},
			custom_highlights = {
				LineNr = { fg = pallette.overlay1 },
			},
			transparent_background = true,
			no_italic = true,
		})

		vim.cmd.colorscheme("catppuccin")

		vim.api.nvim_set_hl(0, "SpellBad", {
			bg = pallette.red,
			fg = pallette.base,
		})
	end,
	lazy = false,
	priority = 1000,
}
