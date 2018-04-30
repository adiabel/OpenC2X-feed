require("luci.model.uci")

m = SimpleForm("openc2x", translate("Create OpenC2X Configuration"))
m.redirect = luci.dispatcher.build_url("admin/openc2x/configs")
m.reset = false

newconfig = m:field(Value, "_name", translate("Name of the new configuration"),
	translate("The allowed characters are: <code>A-Z</code>, <code>a-z</code>, " ..
		"<code>0-9</code> and <code>_</code>. Maximum length of the name is 15 characters"
	))

newconfig:depends("_attach", "")
newconfig.datatype = "and(uciname,maxlength(15))"



newdescription = m:field(Value, "_openc2xdesc", translate("Description"))

newdatetime = m:field(Value, "_openc2xdatetime", translate("Date and time"))
newdatetime.template = "cbi_timeval"            -- Template name from above






function copyValues(x, section_type, section_file, config_name)
	x:set(section_file, config_name, section_type)
	x:foreach("openc2x_default", section_type, function(s)
		for key, value in pairs(s) do
			if key ~= ".index" and key ~= ".name" and key ~= ".anonymous" and key ~= ".type" then
				x:set(section_file, config_name, key, tostring(value))
			end
		end
	end)
	x:commit(section_file)
end

function newconfig.write(self, section, value)
	local name = newconfig:formvalue(section)
	local description = newdescription:formvalue(section)
	local datetime = newdatetime:formvalue(section)
	if name and #name > 0 then

		local x = uci.cursor()
		x:set("openc2x",  name, "openc2x")
		x:set("openc2x", name, "description", description)
		x:set("openc2x", name, "datetime", datetime)	
		x:foreach("openc2x", "global", function(s)
			local oldname = x:get("openc2x", s['.name'], "config_name")
			if not oldname or #oldname <= 0 then
				x:set("openc2x", s['.name'], "config_name", name)
			end
		end)
		x:commit("openc2x")

		copyValues(x, "dcc", "openc2x_dcc", name)
		copyValues(x, "cam", "openc2x_cam", name)
		copyValues(x, "common", "openc2x_common", name)
		copyValues(x, "httpServer", "openc2x_httpServer", name)
		copyValues(x, "obd2", "openc2x_obd2", name)
		copyValues(x, "gps", "openc2x_gps", name)
		copyValues(x, "ldm", "openc2x_ldm", name)
		copyValues(x, "denm", "openc2x_denm", name)
		
		luci.http.redirect(luci.dispatcher.build_url("admin/openc2x/config", name))
	end
end

return m -- Returns the map
