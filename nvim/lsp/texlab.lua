---@type vim.lsp.Config
return {
	settings = {
		texlab = {
			build = {
				executable = "tectonic",
				args = { "-X", "build" },
				onSave = true,
			},
		},
	},
}
