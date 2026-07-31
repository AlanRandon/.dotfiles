local augroup = vim.api.nvim_create_augroup("custom.opustags", { clear = true })

vim.api.nvim_create_autocmd("BufReadCmd", {
	pattern = "*.opus",
	group = augroup,
	callback = function(opts)
		local result = vim.system({ "opustags", opts.file }):wait()
		if result.code ~= 0 then
			vim.notify("Failed to run opustags")
			return
		end

		local lines = vim.fn.split(result.stdout, "\n")
		vim.api.nvim_buf_set_lines(opts.buf, 0, -1, false, lines)

		vim.bo[opts.buf].swapfile = false
		vim.bo[opts.buf].modified = false
	end,
})

vim.api.nvim_create_autocmd("BufWriteCmd", {
	pattern = "*.opus",
	group = augroup,
	callback = function(opts)
		if vim.fn.confirm("Write tags", "&Yes\n&Cancel", 2) ~= 1 then
			return
		end

		local writer = vim.system({ "opustags", "-Si", opts.file }, { text = true, stdin = true })
		local lines = vim.api.nvim_buf_get_lines(opts.buf, 0, -1, false)
		writer:write(lines)
		writer:write(nil)
		local result = writer:wait()

		if result.code ~= 0 then
			vim.notify("Failed to run opustags")
			return
		end

		vim.bo[opts.buf].modified = false
	end,
})
