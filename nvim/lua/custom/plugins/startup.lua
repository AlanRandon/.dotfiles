return {
	"goolord/alpha-nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		local utils = require("alpha.utils")
		local fortune = require("alpha.fortune")

		local function center(text)
			local width = string.len([[                                                    ]])
			local padding = (width - string.len(text)) / 2
			return string.format(string.format("%%%ds%%s%%%ds", padding, padding), "", text, "")
		end

		local buttons = {
			dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("i", utils.get_file_icon("devicons", "vim") .. "  ICCF", ":help iccf<CR>"),
			dashboard.button(
				"n",
				utils.get_file_icon("devicons", "paper") .. "  Recent neovim changes",
				":help news<CR>"
			),
			dashboard.button("q", "󰅚  Quit NVIM", ":qa<CR>"),
		}

		for _, button in pairs(buttons) do
			button.opts.hl_shortcut = "AlphaButtonShortcut"
		end

		alpha.setup({
			layout = {
				{ type = "padding", val = 2 },
				{
					type = "text",
					val = {
						[[                                                    ]],
						[[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
						[[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
						[[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
						[[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
						[[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
						[[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
						center(string.format("%s", vim.version())),
						center("Nvim is open source and freely distributable"),
					},
					opts = { hl = "AlphaHeader", position = "center" },
				},
				{ type = "padding", val = 2 },
				{
					type = "group",
					val = buttons,
				},
				{
					type = "text",
					val = fortune(),
					opts = { hl = "AlphaFooter", position = "center" },
				},
			},
			opts = { margin = 5 },
		})
	end,
}
