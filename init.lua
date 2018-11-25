local color = minetest.settings:get("colored_pms")

minetest.unregister_chatcommand("msg")

minetest.register_chatcommand("msg", {
	params = "<name> <message>",
	description = "Send a private message",
	privs = {shout=true},
	func = function(name, param)
		local sendto, message = param:match("^(%S+)%s(.+)$")

		if not sendto then
			return false, "Invalid usage, see /help msg."
		end

		if not core.get_player_by_name(sendto) then
			return false, "The player " .. sendto
					.. " is not online."
		end

		core.log("action", "PM from " .. name .. " to " .. sendto
				.. ": " .. message)

		core.chat_send_player(sendto, minetest.colorize(color, "PM from " .. name .. ": "
				.. message))

		music = minetest.sound_play("notif", {
			to_player = sendto,
			loop = false,
	 		gain = 1.0,
		})

		return true, "Message sent."
	end,
})