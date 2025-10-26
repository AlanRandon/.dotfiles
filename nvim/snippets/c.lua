---@diagnostic disable: undefined-global

local Path = require("plenary.path")

---@param start Path
---@return Path?
local function find_src(start)
	local current = start

	while current:absolute() ~= "/" do
		if current:is_dir() and vim.fn.fnamemodify(current:absolute(), ":t") == "src" then
			return current
		end

		current = current:parent()
	end

	return nil
end

return {
	s(
		"header",
		fmt(
			[[
#ifndef {name}_H
#define {name}_H

{placeholder}

#endif
]],

			{
				name = f(function(_, _)
					local path = Path.new(vim.fn.expand("%"))
					local src = find_src(path)
					if src == nil then
						return path:stem():upper()
					end

					local relative_path = path:make_relative(src:absolute())
					return vim.fn.fnamemodify(relative_path, ":r"):gsub("/", "_"):upper()
				end),
				placeholder = i(1, "int main(void);"),
			}
		),
		{
			desc = "Header Boilerplate",
		}
	),
}
