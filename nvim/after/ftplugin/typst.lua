local o = vim.opt_local
o.wrap = true
o.spell = true

local augroup = vim.api.nvim_create_augroup("custom.typst", {})

vim.keymap.set("n", "<leader>tp", "<cmd>TypstPreviewPdf<CR>", { buffer = 0, desc = "[T]ypst [P]review" })

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

vim.api.nvim_buf_create_user_command(0, "TypstPin", function(opts)
	local clients = vim.lsp.get_clients({ name = "tinymist" })
	if #clients < 1 then
		vim.notify("tinymist not running!", vim.log.levels.ERROR)
		return
	end

	local path = opts.args[1] or "main.typ"
	path = vim.fn.fnamemodify(path, ":p")

	clients[1]:request("workspace/executeCommand", {
		command = "tinymist.pinMain",
		arguments = { path },
	}, function(err)
		if err then
			vim.notify(("error pinning: %s"):format(err.message), vim.log.levels.ERROR)
		else
			vim.notify(("succesfully pinned as main: '%s'"):format(path), vim.log.levels.INFO)
		end
	end, 0)
end, { nargs = "?" })

vim.api.nvim_buf_create_user_command(0, "TypstPreviewPdf", function(_)
	vim.cmd("!tmux new-window -dc . typst watch % --open")
end, { nargs = 0 })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client == nil or client.name ~= "tinymist" then
			return
		end

		vim.cmd({ cmd = "TypstPin" })
	end,
	buffer = 0,
	group = augroup,
})
