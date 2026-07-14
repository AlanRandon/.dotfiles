local mp = require("mp")

local queued = {}

mp.register_script_message("queue-item", function(selected_idx)
	selected_idx = tonumber(selected_idx)

	local playlist = mp.get_property_native("playlist")
	local current = mp.get_property_number("playlist-pos")

	local selected_item = playlist[selected_idx + 1]

	if queued[selected_item.id] then
		return
	end

	local target = nil
	for offset = 1, #playlist - 1 do
		local idx = (current + offset) % #playlist
		local item = playlist[idx + 1]
		if not queued[item.id] then
			target = idx
			break
		end
	end

	if target == nil then
		return
	end

	mp.commandv("playlist-move", tostring(selected_idx), tostring(target))

	queued[selected_item.id] = true
end)

mp.observe_property("playlist-pos", "number", function(_, pos)
	local playlist = mp.get_property_native("playlist")
	local item = playlist[pos + 1]

	if item and queued[item.id] then
		queued[item.id] = nil
	end
end)

mp.register_script_message("forget-queue", function()
	queued = {}
end)
