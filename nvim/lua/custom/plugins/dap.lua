return {
	{
		"mfussenegger/nvim-dap",
		keys = {
			{ "<leader>dr", "<cmd>DapContinue<CR>", desc = "[D]AP: [R]un" },

			{ "<leader>b", "<cmd>DapToggleBreakpoint<CR>", desc = "DAP: Toggle [B]reakpoint" },
			{
				"<Plug>(DapStepOver)",
				function()
					vim.cmd("DapStepOver")
					vim.fn["repeat#set"](vim.api.nvim_replace_termcodes("<Plug>(DapStepOver)", true, true, true))
				end,
				desc = "[D]AP: [S]tep (Repeatable)",
			},
			{ "<leader>ds", "<Plug>(DapStepOver)", desc = "[D]AP: [S]tep", remap = true },
		},
	},
	{
		"igorlfs/nvim-dap-view",
		opts = { virtual_text = { enabled = true, position = "eol" } },
		keys = {
			{ "<leader>dv", "<cmd>DapViewToggle<CR>", desc = "[D]AP: Toggle [V]iew" },
		},
	},
}
