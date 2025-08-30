local qf_ns = vim.api.nvim_create_namespace("qflist_diags")

vim.api.nvim_create_user_command("QuickfixDiagnosticsLoad", function()
	local qfl = vim.fn.getqflist()
	local diags_per_buf = {}

	for _, item in ipairs(qfl) do
		local bufnr = item.bufnr

		if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
			diags_per_buf[bufnr] = diags_per_buf[bufnr] or {}

			table.insert(diags_per_buf[bufnr], {
				lnum = (item.lnum or 1) - 1,
				col = (item.col or 1) - 1,
				severity = (item.type == "W") and vim.diagnostic.severity.WARN or vim.diagnostic.severity.ERROR,
				source = "qf",
				message = item.text or "",
				user_data = { qf_nr = item.nr },
			})
		end
	end

	vim.diagnostic.reset(qf_ns)
	for bufnr, diags in pairs(diags_per_buf) do
		if not vim.api.nvim_buf_is_loaded(bufnr) then
			vim.fn.bufload(bufnr)
		end

		vim.diagnostic.set(qf_ns, bufnr, diags, {})
	end
end, {})

vim.api.nvim_create_user_command("QuickfixDiagnosticsQuit", function()
	vim.diagnostic.reset(qf_ns)
	vim.cmd("cclose")
end, {})

vim.keymap.set("n", "<leader>ql", "<cmd>QuickfixDiagnosticsLoad<cr>", { desc = "[Q]uickfix [D]iagnotics" })
vim.keymap.set("n", "<leader>qq", "<cmd>QuickfixDiagnosticsQuit<cr>", { desc = "[Q]uickfix Diagnostics [Q]uit" })
