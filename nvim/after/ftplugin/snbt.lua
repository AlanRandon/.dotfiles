local toggled_types = {
	UB = { "ctypes.c_byte", "sB" },
	US = { "ctypes.c_short", "sS" },
	UI = { "ctypes.c_int", "sI" },
	UL = { "ctypes.c_long", "sL" },
	SB = { "ctypes.c_ubyte", "uB" },
	SS = { "ctypes.c_ushort", "uS" },
	SI = { "ctypes.c_uint", "uI" },
	SL = { "ctypes.c_ulong", "uL" },
}

vim.api.nvim_buf_create_user_command(0, "ToggleIntSignedness", function()
	local word = vim.fn.expand("<cWORD>")
	local before, integer, signedness, type, after = word:match("([^-0-9]*)(-?[0-9]+)([uUsS])([bBsSiIlL])(.*)")

	if before == nil then
		vim.notify(('Failed to parse "%s" as integer'):format(word))
		return
	end

	local toggled = toggled_types[signedness:upper() .. type:upper()]
	local toggled_python_type, suffix = toggled[1], toggled[2]
	local result = vim.fn
		.system({ "python3", "-c", ("import ctypes; print(%s(int(input())).value)"):format(toggled_python_type) }, integer)
		:gsub("\n$", "")

	vim.cmd.normal("ciW" .. before .. result .. suffix .. after)
end, { nargs = 0 })

vim.keymap.set("n", "<leader>ts", "<cmd>ToggleIntSignedness<CR>", { buffer = 0, desc = "[T]oggle Int [S]ignedness" })
