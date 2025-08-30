vim.keymap.set("n", "<leader>zt", function()
	local old_compiler = vim.b.current_compiler or "make"
	vim.cmd([[
		compiler zig_build_test
		make
		QuickfixDiagnosticsLoad
	]])
	vim.cmd("compiler " .. old_compiler)
end, { buffer = 0, desc = "[Z]ig [T]est" })
