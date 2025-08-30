if vim.g.current_compiler then
	return
end

vim.g.current_compiler = "zig_build_test"

vim.cmd([[
runtime compiler/zig_build.vim

CompilerSet makeprg=zig\ build\ test\ $*
CompilerSet errorformat=%E%f:%l:%c:\ %m,%Z%m
]])

local function fix_list(lst)
	local fixed = {}
	for _, item in ipairs(lst) do
		if item.bufnr ~= nil and item.bufnr > 0 then
			local prefixed_fname = vim.api.nvim_buf_get_name(item.bufnr)
			local test_name, fname = prefixed_fname:match("error: '([^']*)' failed: ([^:]+)")
			if test_name ~= nil and fname ~= nil then
				vim.api.nvim_buf_delete(item.bufnr, {})
				item.bufnr = vim.fn.bufnr(fname, true)
				item.text = ("error '%s' failed: %s"):format(test_name, item.text)
			end
		end

		table.insert(fixed, item)
	end
	return lst
end

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
	pattern = "make",
	callback = function()
		if vim.b.current_compiler ~= "zig_build_test" then
			return
		end

		vim.fn.setqflist(fix_list(vim.fn.getqflist()), "r")
	end,
})

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
	pattern = "lmake",
	callback = function()
		if vim.b.current_compiler ~= "zig_build_test" then
			return
		end

		local win = vim.api.nvim_get_current_win()
		vim.fn.setloclist(win, fix_list(vim.fn.getloclist(win)), "r")
	end,
})

-- vim: tabstop=8 shiftwidth=4 softtabstop=4 expandtab
