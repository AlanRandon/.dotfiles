local augroup = vim.api.nvim_create_augroup("custom.exiftool", { clear = true })
local height = 20

vim.api.nvim_create_autocmd("BufReadCmd", {
	pattern = "*.{jpg,JPG,png,PNG}",
	group = augroup,
	callback = function(opts)
		local result = vim.system({ "exiftool", opts.file }):wait()
		if result.code ~= 0 then
			vim.notify("Failed to run exiftool")
			return
		end

		vim.keymap.set("n", "gx", function()
			vim.ui.open(opts.file)
		end, { desc = "Open File in E[x]ternal Program" })

		vim.schedule(function()
			Snacks.image.placement.new(opts.buf, opts.file, {
				row = 0,
				col = 0,
				height = height,
			})

			local lines = vim.fn.split(result.stdout, "\n")
			vim.bo[opts.buf].modifiable = true
			vim.api.nvim_buf_set_lines(opts.buf, height, -1, false, lines)
			vim.bo[opts.buf].modifiable = false
			vim.bo[opts.buf].swapfile = false
			vim.bo[opts.buf].modified = false
		end)

		vim.bo[opts.buf].modified = false
		vim.bo[opts.buf].modifiable = false
	end,
})
