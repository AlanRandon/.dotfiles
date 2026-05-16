---@diagnostic disable: undefined-global

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
					local path = vim.fn.expand("%:p:r")
					if path:match("src/") then
						return path:gsub(".*src/", ""):gsub("/", "_"):upper()
					end

					return vim.fn.expand("%:t:r"):upper()
				end),
				placeholder = i(1, "int main(void);"),
			}
		),
		{
			desc = "Header Boilerplate",
		}
	),
}
