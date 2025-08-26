local o = vim.opt_local
o.wrap = true
o.spell = true

vim.keymap.set("n", "<leader>tp", "<cmd>TypstPreview<CR>", { buffer = 0, desc = "[T]ypst [P]review" })

vim.api.nvim_buf_create_user_command(0, "Export", function()
	vim.ui.select({
		"Svg",
		"Png",
		"Pdf",
		"Markdown",
		"Text",
		"Query",
		"AnsiHighlight",
	}, { prompt = "Export with format" }, function(item)
		if item ~= nil then
			vim.cmd("LspTinymistExport" .. item)
		end
	end)
end, { nargs = 0 })

vim.keymap.set("n", "<leader>te", "<cmd>Export<CR>")
