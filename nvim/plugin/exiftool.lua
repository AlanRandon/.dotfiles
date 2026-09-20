local augroup = vim.api.nvim_create_augroup("custom.exiftool", { clear = true })

vim.api.nvim_create_autocmd("BufReadCmd", {
	pattern = "*.{jpg,JPG,jpeg,JPEG,png,PNG}",
	group = augroup,
	callback = function(opts)
		vim.bo[opts.buf].swapfile = false
		vim.api.nvim_buf_set_lines(opts.buf, 0, -1, false, { "Loading EXIF..." })
		vim.bo[opts.buf].modifiable = false
		vim.bo[opts.buf].modified = false

		vim.keymap.set("n", "gx", function()
			vim.ui.open(opts.file)
		end, { desc = "Open File in E[x]ternal Program" })

		vim.schedule(function()
			local result = vim.system({ "exiftool", opts.file }):wait()
			if result.code ~= 0 then
				vim.notify("Failed to run exiftool")
				return
			end

			local lines = vim.fn.split(result.stdout, "\n")
			vim.bo[opts.buf].modifiable = true
			vim.api.nvim_buf_set_lines(opts.buf, 0, -1, false, lines)
			vim.bo[opts.buf].modifiable = false
			vim.bo[opts.buf].modified = false
		end)
	end,
})
