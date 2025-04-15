local set = vim.keymap.set

set("n", "<ESC>", "<cmd>nohlsearch<CR>", { desc = "Hide Highlight" })
set({ "n", "v" }, "<leader>d", [["_d]], { desc = "[D]elete Without Yank" })
set("x", "<leader>p", [["_dP]], { desc = "[P]aste Without Yank" })
set("t", "<ESC>", "<C-\\><C-n>", { desc = "Escape Terminal Mode" })

set("n", "<C-h>", "<C-w>h")
set("n", "<C-j>", "<C-w>j")
set("n", "<C-k>", "<C-w>k")
set("n", "<C-l>", "<C-w>l")

set("n", "<C-u>", "<C-u>zz", { desc = "[U]p Half Page" })
set("n", "<C-d>", "<C-d>zz", { desc = "[D]own Half Page" })
-- centre window on next/previous item
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")

set("x", " md", ":!prettier --parser markdown<CR>", { desc = "Format [M]ark[d]own Range" })

vim.api.nvim_create_user_command("InlayHintsToggle", function()
	---@diagnostic disable-next-line missing-parameter
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, {})
