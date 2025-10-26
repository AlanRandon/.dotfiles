--- @module 'blink.cmp'
--- @class blink.cmp.Source
local source = {}

function source.new(opts)
	local self = setmetatable({}, { __index = source })
	self.opts = opts
	return self
end

function source:enabled()
	return vim.bo.filetype == "gitcommit"
end

function source:get_trigger_characters()
	return { "ca" }
end

local Text = require("blink.cmp.types").CompletionItemKind.Text

function source:get_completions(ctx, callback)
	local co_authors = vim.fn.systemlist('git -c log.showSignature=false log --format="%aN <%aE>" | sort -u')

	local items = {}
	for _, co_author in pairs(co_authors) do
		table.insert(items, {
			label = ("ca-%s"):format(co_author:lower():gsub(" ", "-"):gsub("<.*>", "")),
			kind = Text,
			insertText = ("Co-authored-by: %s"):format(co_author),
			insertTextFormat = vim.lsp.protocol.InsertTextFormat.PlainText,
		})
	end

	callback({
		items = items,
		is_incomplete_backward = false,
		is_incomplete_forward = false,
	})

	return function() end
end

function source:resolve(item, callback)
	item = vim.deepcopy(item)

	item.documentation = {
		kind = "plaintext",
		value = item.insertText,
	}

	callback(item)
end

function source:execute(ctx, item, callback, default_implementation)
	default_implementation()
	callback()
end

return source
