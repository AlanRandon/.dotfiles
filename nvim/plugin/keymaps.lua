local set = vim.keymap.set

set("n", "<ESC>", "<cmd>nohlsearch<CR>", { desc = "Hide Highlight" })
set({ "n", "v" }, "<leader>d", [["_d]], { desc = "[D]elete Without Yank" })
set("x", "<leader>p", [["_dP]], { desc = "[P]aste Without Yank" })
set("t", "<ESC>", "<C-\\><C-n>", { desc = "Escape Terminal Mode" })

set("n", "<leader>w", function()
	-- not sure about opt_local here
	vim.opt_local.wrap = not vim.opt_local.wrap:get()
end, { desc = "Toggle [W]rap" })

set("n", "<leader>s", function()
	-- not sure about opt_local here
	vim.opt_local.spell = not vim.opt_local.spell:get()
end, { desc = "Toggle [S]pell" })

set("n", "<C-u>", "<C-u>zz", { desc = "[U]p Half Page" })
set("n", "<C-d>", "<C-d>zz", { desc = "[D]own Half Page" })

-- centre window on next/previous item
set("n", "n", "nzz")
set("n", "N", "Nzz")

set("x", " md", ":!prettier --parser markdown<CR>", { desc = "Format [M]ark[d]own Range" })

vim.keymap.set("n", "<leader>zt", function()
	local old_compiler = vim.b.current_compiler or "make"
	vim.cmd([[
		compiler zig_build_test
		make
		QuickfixDiagnosticsLoad
	]])
	vim.cmd("compiler " .. old_compiler)
end, { desc = "[Z]ig [T]est" })

vim.keymap.set("n", "<leader>zb", function()
	local old_compiler = vim.b.current_compiler or "make"
	vim.cmd([[
		compiler zig_build
		make
		QuickfixDiagnosticsLoad
	]])
	vim.cmd("compiler " .. old_compiler)
end, { desc = "[Z]ig [B]uild" })

-- LSP mappings

set("n", "gd", vim.lsp.buf.definition, { desc = "LSP: [G]oto [D]efinition" })
set("n", "gr", Snacks.picker.lsp_references, { desc = "LSP: [G]oto [R]eferences" })
set("n", "gI", vim.lsp.buf.implementation, { desc = "LSP: [G]oto [I]mplementation" })
set("n", "gt", vim.lsp.buf.type_definition, { desc = "LSP: [G]oto [T]ype Definition" })

set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP: [R]e[n]ame" })
set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: [C]ode [A]ction" })

set("n", "[d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "LSP: Goto Next [D]iagnostic" })

set("n", "]d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "LSP: Goto Previous [D]iagnostic" })

set("n", "K", function()
	vim.lsp.buf.hover({ border = "rounded" })
end, { desc = "LSP: Hover Documentation" })

set("n", "<leader>ih", ":InlayHintsToggle<CR>", { desc = "LSP: Toggle [I]nlay [H]ints" })

vim.api.nvim_create_user_command("InlayHintsToggle", function()
	---@diagnostic disable-next-line missing-parameter
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, {})
