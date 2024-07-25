if vim.g.vscode then
	return
end

vim.g.netrw_list_hide = "^\\..*,node_modules,target"
vim.g.netrw_banner = 0

vim.keymap.set("n", "<leader>ft", "<cmd>Ex<cr>", { desc = "[F]ile [T]ree" })

vim.api.nvim_create_autocmd("BufModifiedSet", {
	pattern = { "*" },
	callback = function(_)
		local bufnr = vim.api.nvim_get_current_buf()

		if not (vim.bo and vim.bo.filetype == "netrw") then
			return
		end

		if vim.b.netrw_liststyle ~= 0 and vim.b.netrw_liststyle ~= 1 and vim.b.netrw_liststyle ~= 3 then
			return
		end

		vim.keymap.set("n", "<leader>o", function()
			local line = vim.api.nvim_get_current_line()
			local node = require("netrw.parse").get_node(line)

			if node == nil then
				return
			end

			vim.cmd.XdgOpen(node.dir .. "/" .. node.node)
		end, { buffer = bufnr })
	end,
	group = vim.api.nvim_create_augroup("netrw-mappings", { clear = true }),
})

require("netrw").setup()
