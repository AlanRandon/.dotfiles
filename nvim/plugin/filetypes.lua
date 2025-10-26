vim.filetype.add({
	extension = {
		wgsl = "wgsl",
	},
})

vim.api.nvim_create_autocmd("BufRead", {
	pattern = "*.h",
	callback = function()
		if vim.fn.search("#ifdef __cplusplus", "nw") == 0 then
			vim.bo.filetype = "c"
		end
	end,
})
