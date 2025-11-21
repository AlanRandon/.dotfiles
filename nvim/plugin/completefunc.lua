local curl = require("plenary.curl")

_G.thesaurusfunc = function(findstart, base)
	-- :h complete-functions
	if findstart == 1 then
		return 0
	end

	local res = curl.get(("https://api.datamuse.com/words?ml=%s"):format(base), { accept = "application/json" })
	if res.status ~= 200 then
		vim.notify("failed to make thesaurus request")
		return {}
	end

	local status, result = pcall(function()
		local body = vim.json.decode(res.body)
		local words = {}
		for _, entry in pairs(body) do
			table.insert(words, entry.word)
		end
		return words
	end)

	if not status then
		vim.notify("failed to parse thesaurus response body")
		return {}
	end

	return result
end

vim.o.thesaurusfunc = "v:lua.thesaurusfunc"

_G.dictionaryfunc = function(findstart, base)
	-- :h complete-functions
	if findstart == 1 then
		return 0
	end

	local res = curl.get(("https://api.datamuse.com/words?sp=%s*"):format(base), { accept = "application/json" })
	if res.status ~= 200 then
		vim.notify("failed to make dictionary request")
		return {}
	end

	local status, result = pcall(function()
		local body = vim.json.decode(res.body)
		local words = {}
		for _, entry in pairs(body) do
			table.insert(words, entry.word)
		end
		return words
	end)

	if not status then
		vim.notify("failed to parse dictionary response body")
		return {}
	end

	return result
end

vim.keymap.set("i", "<C-x><C-k>", "<cmd>set completefunc=v:lua.dictionaryfunc<CR><C-x><C-u>")

_G.coauthorfunc = function(findstart, base)
	-- :h complete-functions
	if findstart == 1 then
		return 0
	end

	local co_authors = vim.fn.systemlist('git -c log.showSignature=false log --format="%aN <%aE>" | sort -u')

	local items = {}
	for _, co_author in pairs(co_authors) do
		if co_author:lower():find(base) then
			table.insert(items, ("Co-authored-by: %s"):format(co_author))
		end
	end

	return items
end

vim.keymap.set("i", "<C-x><C-a>", "<cmd>set completefunc=v:lua.coauthorfunc<CR><C-x><C-u>")
