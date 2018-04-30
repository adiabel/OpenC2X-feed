local s, translate, Flag = ...

-- Start logging
s:tab("statistics", translate("Statistics"))

p = s:taboption("statistics", Flag, "enable_statistics", translate("Enable statistics?"))
p.enabled = "true"
p.disabled = "false"

p = s:taboption("statistics", Flag, "logging_to_file", translate("Log statistics to file?"))
p.enabled = "true"
p.disabled = "false"

p = s:taboption("statistics", Flag, "logging_to_standard_output", translate("Log statistics to standard out?"))
p.enabled = "true"
p.disabled = "false"


s:tab("logging", translate("Logging"))

p = s:taboption("logging", Flag, "enable_logging", translate("Enable logging?"))
p.enabled = "true"
p.disabled = "false"

p = s:taboption("logging", Flag, "logging_to_file", translate("Log to file?"))
p.enabled = "true"
p.disabled = "false"

p = s:taboption("logging", Flag, "logging_to_standard_output", translate("Log to standard out?"))
p.enabled = "true"
p.disabled = "false"




p = s:taboption("logging", Flag, "enable_logging_error", translate("Enable error logging?"))
p.enabled = "true"
p.disabled = "false"

p = s:taboption("logging", Flag, "logging_error_to_file", translate("Log errors to file?"))
p.enabled = "true"
p.disabled = "false"

p = s:taboption("logging", Flag, "logging_error_to_standard_output", translate("Log errors to standard out?"))
p.enabled = "true"
p.disabled = "false"


p = s:taboption("logging", Flag, "enable_logging_info", translate("Enable info logging?"))
p.enabled = "true"
p.disabled = "false"

p = s:taboption("logging", Flag, "logging_info_to_file", translate("Log infos to file?"))
p.enabled = "true"
p.disabled = "false"

p = s:taboption("logging", Flag, "logging_info_to_standard_output", translate("Log infos to standard out?"))
p.enabled = "true"
p.disabled = "false"

	


p = s:taboption("logging", Flag, "enable_logging_debug", translate("Enable debug logging?"))
p.enabled = "true"
p.disabled = "false"

p = s:taboption("logging", Flag, "logging_debug_to_file", translate("Log debug to file?"))
p.enabled = "true"
p.disabled = "false"

p = s:taboption("logging", Flag, "logging_debug_to_standard_output", translate("Log debug to standard out?"))
p.enabled = "true"
p.disabled = "false"



-- End logging
