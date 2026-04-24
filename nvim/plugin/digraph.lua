local digraphs = {
	["\\N"] = "ℕ",
	["\\Z"] = "ℤ",
	["\\Q"] = "ℚ",
	["\\R"] = "ℝ",
	["\\C"] = "ℂ",
}

for chars, digraph in pairs(digraphs) do
	vim.fn.digraph_set(chars, digraph)
end
