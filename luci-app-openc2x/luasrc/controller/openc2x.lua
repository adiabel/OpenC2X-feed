module("luci.controller.openc2x", package.seeall)

require("luci.model.uci")
local sys = require "luci.sys"

function index()
	entry({"admin", "openc2x"}, template("openc2x/openc2x"), "OpenC2X", 20).dependent=false
	entry({"admin", "openc2x", "overview"}, template("openc2x/openc2x"), "Overview", 20)
	entry({"admin", "openc2x", "configs"}, cbi("openc2x_configs"), "Configurations", 20)
	entry({"admin", "openc2x", "results"}, template("openc2x/list_results"), "Results", 20)
	entry({"admin", "openc2x", "licenses"}, template("openc2x/licenses"), "Licenses", 20)
	entry({"admin", "openc2x", "config_add"}, cbi("openc2x_config_add"),  nil)

	page = entry({"admin", "openc2x", "config_delete"}, post("config_delete"), nil)
	page.leaf = true
	page = entry({"admin", "openc2x", "config_current"}, post("config_current"), nil)
	page.leaf = true
	page = entry({"admin", "openc2x", "start_openc2x"}, post("start_openc2x"), nil)
	page.leaf = true
	page = entry({"admin", "openc2x", "stop_openc2x"}, post("stop_openc2x"), nil)
	page.leaf = true
	page = entry({"admin", "openc2x", "download_results"}, post("download_results"), nil)
	page.leaf = true
	page = entry({"admin", "openc2x", "download_all"}, post("download_all"), nil)
	page.leaf = true
	page = entry({"admin", "openc2x", "config"}, cbi("openc2x_config"), nil)
	page.leaf   = true
	page.subindex = true
end


function delete_section(_uci, section_file, section_type, config_name)
	_uci:delete_all(section_file, section_type, function(s)
		if s['.name'] == config_name then
			return true
		end
		return false
	end)
	_uci:commit(section_file)
end

function config_delete(config)
	local _uci = uci.cursor()
	delete_section(_uci, "openc2x", "openc2x", config)
	delete_section(_uci, "openc2x_cam", "cam", config)
	delete_section(_uci, "openc2x_common", "common", config)
	delete_section(_uci, "openc2x_dcc", "dcc", config)
	delete_section(_uci, "openc2x_gps", "gps", config)
	delete_section(_uci, "openc2x_httpServer", "httpServer", config)
	delete_section(_uci, "openc2x_obd2", "obd2", config)
	x:foreach("openc2x", "global", function(s)
			local oldname = x:get("openc2x", s['.name'], "config_name")
			if oldname == config then
				x:set("openc2x", s['.name'], "config_name", "")
			end
		end)
	x:commit("openc2x")
end

function config_current(config)
	local _uci = uci.cursor()
	_uci:foreach("openc2x", "global", function(s)
		_uci:set("openc2x", s['.name'], "config_name", config)
	end)
	_uci:commit("openc2x")
end

function start_openc2x()
	sys.call("/etc/init.d/openc2x start >/dev/null")
end

function stop_openc2x()
	sys.call("/etc/init.d/openc2x stop >/dev/null")
end

function download_results()
	local path = luci.http.formvalue("path")
	local config = luci.http.formvalue("config")
	local expNo = luci.http.formvalue("expNo")
	local log_path = path .. "/" .. config .. "/" .. expNo
	local reader = ltn12_popen('cd ' .. log_path .. ' && tar -zcvf - * 2>/dev/null')

	luci.http.header(
		'Content-Disposition', 'attachment; filename="results-%s-%s.tar.gz"' %{
			config,
			expNo
		})

	luci.http.prepare_content("application/x-targz")
	luci.ltn12.pump.all(reader, luci.http.write)
end

function download_all()
	local path = luci.http.formvalue("path")
	local log_path = path
	local reader = ltn12_popen('cd ' .. log_path .. ' && tar -zcvf - * 2>/dev/null')

	luci.http.header(
		'Content-Disposition', 'attachment; filename="results-all-%s-%s.tar.gz"' %{
			config,
			expNo
		})

	luci.http.prepare_content("application/x-targz")
	luci.ltn12.pump.all(reader, luci.http.write)
end

function ltn12_popen(command)

	local fdi, fdo = nixio.pipe()
	local pid = nixio.fork()

	if pid > 0 then
		fdo:close()
		local close
		return function()
			local buffer = fdi:read(2048)
			local wpid, stat = nixio.waitpid(pid, "nohang")
			if not close and wpid and stat == "exited" then
				close = true
			end

			if buffer and #buffer > 0 then
				return buffer
			elseif close then
				fdi:close()
				return nil
			end
		end
	elseif pid == 0 then
		nixio.dup(fdo, nixio.stdout)
		fdi:close()
		fdo:close()
		nixio.exec("/bin/sh", "-c", command)
	end
end
