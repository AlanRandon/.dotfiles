---@type vim.lsp.Config
return {
	-- see ~/.local/share/nvim/lazy/nvim-lspconfig/lsp/lua_ls.lua
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if
				path ~= vim.fn.stdpath("config")
				and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
			then
				return
			end
		end

		local library = vim.tbl_filter(function(d)
			return not d:match(vim.fn.stdpath("config") .. "/?a?f?t?e?r?")
		end, vim.api.nvim_get_runtime_file("", true))

		table.insert(library, "${3rd}/luv/library")
		table.insert(library, "${3rd}/busted/library")

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				version = "LuaJIT",
				-- Tell the language server how to find Lua modules same way as Neovim
				-- (see `:h lua-module-load`)
				path = {
					"lua/?.lua",
					"lua/?/init.lua",
				},
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = library,
			},
		})
	end,
	settings = {
		Lua = {},
	},
}
