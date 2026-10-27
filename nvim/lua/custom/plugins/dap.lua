return {
	{
		"mfussenegger/nvim-dap",
		keys = {
			{ "<leader>dr", "<cmd>DapContinue<CR>", desc = "[D]AP: [R]un" },
			{
				"<leader>dR",
				function()
					require("dap").run_to_cursor()
				end,
				desc = "[D]AP: [R]un To Cursor",
			},
			{ "<leader>b", "<cmd>DapToggleBreakpoint<CR>", desc = "DAP: Toggle [B]reakpoint" },
			{
				"<Plug>(DapStepOver)",
				function()
					vim.cmd("DapStepOver")
					vim.fn["repeat#set"](vim.api.nvim_replace_termcodes("<Plug>(DapStepOver)", true, true, true))
				end,
				desc = "[D]AP: [S]tep (Repeatable)",
			},
			{ "<leader>ds", "<Plug>(DapStepOver)", desc = "[D]AP: [S]tep Over", remap = true },
			{
				"<Plug>(DapStepInto)",
				function()
					vim.cmd("DapStepInto")
					vim.fn["repeat#set"](vim.api.nvim_replace_termcodes("<Plug>(DapStepInto)", true, true, true))
				end,
				desc = "[D]AP: [S]tep Into (Repeatable)",
			},
			{ "<leader>dS", "<Plug>(DapStepInto)", desc = "[D]AP: [S]tep Into", remap = true },
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
