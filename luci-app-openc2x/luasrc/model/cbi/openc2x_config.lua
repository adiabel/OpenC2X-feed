local sysfs_path = "/sys/class/net/"
local nets = {}

local fs   = require "nixio.fs"
local nu   = require "nixio.util"
local util = require "luci.util"


if fs.access(sysfs_path) then
	nets = nu.consume((fs.dir(sysfs_path)))
end

--Start common

common_map = Map("openc2x_common")

s = common_map:section(NamedSection, arg[1], "common", translate("Common Configuration"))
s.addremove = false
s.anonymous = true

p = s:option(ListValue, "ethernetDevice", "Ethernet Device") -- Creates an element list (select box)

for k, v in ipairs(nets) do
        local iw = luci.sys.wifi.getiwinfo(v)
        if iw ~= null and iw.freqlist then
                local freq = math.floor(iw.freqlist[1].mhz / 1000)
                local str = v .. " - " .. freq .. " GHz"
                p:value(v, str)
        else
                p:value(v, v)
        end
end



s:option(Value, "stationId", translate("Station Id"))

s:option(Value, "countryCode", translate("Country where system is used"))

s:option(Value, "txPower", translate("Power of wlan sender"))

-- End common

--Start cam

cam_map = Map("openc2x_cam")

s = cam_map:section(NamedSection, arg[1], "cam", translate("CAM Configuration"))

s:tab("cam", translate("Settings"))

p = s:taboption("cam", Flag, "generateMsgs", translate("Generate Messages"))
p.enabled = "true"
p.disabled = "false"

p = s:taboption("cam", Value, "expirationTime", translate("Expiration Time in seconds"))

p = s:taboption("cam", Value, "maxGpsAge", translate("Maximum GPS age in seconds"))

p = s:taboption("cam", Value, "maxObd2Age", translate("Maximum OBD2 age in seconds"))

p = s:taboption("cam", Value, "thresholdRadiusForHeading", translate("Threshold radius for Heading in metres"))

p = s:taboption("cam", Flag, "isRSU", translate("Basic Container in CAM. Is RSU?"))
p.enabled = "true"
p.disabled = "false"

assert(loadfile("/usr/lib/lua/luci/model/cbi/openc2x_config/statistics.lua"))(s, translate, Flag)


-- End cam




-- Start http server

http_map = Map("openc2x_httpServer")




s = http_map:section(NamedSection, arg[1], "httpServer", translate("HTTPServer Configuration"))
s:tab("settings", translate("Settings"))
p = s:taboption("settings", Value, "timeout", translate("Timeout in milliseconds"))


assert(loadfile("/usr/lib/lua/luci/model/cbi/openc2x_config/statistics.lua"))(s, translate, Flag)


-- End http server


-- Start OBD2

obd2_map = Map("openc2x_obd2")

s = obd2_map:section(NamedSection, arg[1], "obd2", translate("OBD2 Configuration"))

s:tab("settings", translate("Settings"))

p = s:taboption("settings", Flag, "simulateData", translate("Simulate data?"))
p.enabled = "true"
p.disabled = "false"

p = s:taboption("settings", Value, "device", translate("Device"))

p = s:taboption("settings", Value, "frequency", translate("frequency in milliseconds ??????????"))


assert(loadfile("/usr/lib/lua/luci/model/cbi/openc2x_config/statistics.lua"))(s, translate, Flag)


-- End OBD2


-- Start GPS

gps_map = Map("openc2x_gps")

s = gps_map:section(NamedSection, arg[1], "gps", translate("GPS Configuration"))
s:tab("settings", translate("Settings"))

p = s:taboption("settings", Flag, "simulateData", translate("Simulate data?"))
p.enabled = "true"
p.disabled = "false"

p = s:taboption("settings", ListValue, "simulationMode", translate("Use mathematical simulation?"))

p:value(0, "mathematical simuation")
p:value(1, "demo trails")

p = s:taboption("settings", Value, "dataFile", translate("data file"))


assert(loadfile("/usr/lib/lua/luci/model/cbi/openc2x_config/statistics.lua"))(s, translate, Flag)


-- End GPS

-- Start DCC

dcc_map = Map("openc2x_dcc")

s = dcc_map:section(NamedSection, arg[1], "dcc", translate("DCC Configuration"))

s:tab("settings", translate("Settings"))

p = s:taboption("settings", Flag, "simulateChannelLoad", translate("Simulate channel load?"))
p.enabled = "true"
p.disabled = "false"

p = s:taboption("settings", Flag, "ignoreOwnMessages", translate("Ignore own messages?"))
p.enabled = "true"
p.disabled = "false"

p = s:taboption("settings", Value, "dccInfoInterval", translate("DCC info interval in milliseconds"))

p = s:taboption("settings", Value, "DCC_measure_interval_Tm", translate("DCC_measure_interval_Tm"))

p = s:taboption("settings", Value, "DCC_collect_pkt_flush_stats", translate("DCC_collect_pkt_flush_stats"))

s:tab("sizes", translate("Sizes"))

p = s:taboption("sizes", Value, "bucketSize_AC_VI", translate("Bucketsize AC_VI"))
p = s:taboption("sizes", Value, "bucketSize_AC_VO", translate("Bucketsize AC_VO"))
p = s:taboption("sizes", Value, "bucketSize_AC_BE", translate("Bucketsize AC_BE"))
p = s:taboption("sizes", Value, "bucketSize_AC_BK", translate("Bucketsize AC_BK"))

p = s:taboption("sizes", Value, "queueSize_AC_VI", translate("Queuesize AC_VI"))
p = s:taboption("sizes", Value, "queueSize_AC_VO", translate("Queuesize AC_VO"))
p = s:taboption("sizes", Value, "queueSize_AC_BE", translate("Queuesize AC_BE"))
p = s:taboption("sizes", Value, "queueSize_AC_BK", translate("Queuesize AC_BK"))

s:tab("ndl", translate("NDL"))

p = s:taboption("ndl", Value, "NDL_minPacketInterval", translate("NDL minimal packet interval (#default 0.04!)"))

p = s:taboption("ndl", Value, "NDL_maxPacketInterval", translate("NDL maximal packet interval (#default 1.00!)"))

p = s:taboption("ndl", Value, "NDL_defPacketInterval", translate("NDL defined packet interval"))


p = s:taboption("ndl", Value, "NDL_minTxPower", translate("NDL minimal TxPower"))

p = s:taboption("ndl", Value, "NDL_maxTxPower", translate("NDL maximal TxPower"))

p = s:taboption("ndl", Value, "NDL_defTxPower", translate("NDL defined TxPower"))


p = s:taboption("ndl", Value, "NDL_minDatarate", translate("NDL minimal datarate"))

p = s:taboption("ndl", Value, "NDL_maxDatarate", translate("NDL maximal datarate"))

p = s:taboption("ndl", Value, "NDL_defDatarate", translate("NDL defined datarate"))


p = s:taboption("ndl", Value, "NDL_minCarrierSense", translate("NDL minimal CarrierSense"))

p = s:taboption("ndl", Value, "NDL_maxCarrierSense", translate("NDL maximal CarrierSense"))

p = s:taboption("ndl", Value, "NDL_defCarrierSense", translate("NDL defined CarrierSense"))


p = s:taboption("ndl", Value, "NDL_minChannelLoad", translate("NDL minimal channel load"))

p = s:taboption("ndl", Value, "NDL_maxChannelLoad", translate("NDL maximal channel load"))


p = s:taboption("ndl", Value, "NDL_numActiveState", translate("NDL number of active states"))

p = s:taboption("ndl", Value, "NDL_asChanLoad_active1", translate("NDL_asChanLoad_active1"))


p = s:taboption("ndl", Value, "NDL_asDcc_active1_AC_VI", translate("NDL_asDcc_active1_AC_VI"))
p = s:taboption("ndl", Value, "NDL_asDcc_active1_AC_VO", translate("NDL_asDcc_active1_AC_VO"))
p = s:taboption("ndl", Value, "NDL_asDcc_active1_AC_BE", translate("NDL_asDcc_active1_AC_BE"))
p = s:taboption("ndl", Value, "NDL_asDcc_active1_AC_BK", translate("NDL_asDcc_active1_AC_BK"))


p = s:taboption("ndl", Value, "NDL_asTxPower_active1_AC_VI", translate("NDL_asTxPower_active1_AC_VI"))
p = s:taboption("ndl", Value, "NDL_asTxPower_active1_AC_VO", translate("NDL_asTxPower_active1_AC_VO"))
p = s:taboption("ndl", Value, "NDL_asTxPower_active1_AC_BE", translate("NDL_asTxPower_active1_AC_BE"))
p = s:taboption("ndl", Value, "NDL_asTxPower_active1_AC_BK", translate("NDL_asTxPower_active1_AC_BK"))


p = s:taboption("ndl", Value, "NDL_asPacketInterval_active1_AC_VI", translate("NDL_asPacketInterval_active1_AC_VI"))
p = s:taboption("ndl", Value, "NDL_asPacketInterval_active1_AC_VO", translate("NDL_asPacketInterval_active1_AC_VO"))
p = s:taboption("ndl", Value, "NDL_asPacketInterval_active1_AC_BE", translate("NDL_asPacketInterval_active1_AC_BE"))
p = s:taboption("ndl", Value, "NDL_asPacketInterval_active1_AC_BK", translate("NDL_asPacketInterval_active1_AC_BK"))


p = s:taboption("ndl", Value, "NDL_asDatarate_active1_AC_VI", translate("NDL_asDatarate_active1_AC_VI"))
p = s:taboption("ndl", Value, "NDL_asDatarate_active1_AC_VO", translate("NDL_asDatarate_active1_AC_VO"))
p = s:taboption("ndl", Value, "NDL_asDatarate_active1_AC_BE", translate("NDL_asDatarate_active1_AC_BE"))
p = s:taboption("ndl", Value, "NDL_asDatarate_active1_AC_BK", translate("NDL_asDatarate_active1_AC_BK"))


p = s:taboption("ndl", Value, "NDL_asCarrierSense_active1_AC_VI", translate("NDL_asCarrierSense_active1_AC_VI"))
p = s:taboption("ndl", Value, "NDL_asCarrierSense_active1_AC_VO", translate("NDL_asCarrierSense_active1_AC_VO"))
p = s:taboption("ndl", Value, "NDL_asCarrierSense_active1_AC_BE", translate("NDL_asCarrierSense_active1_AC_BE"))
p = s:taboption("ndl", Value, "NDL_asCarrierSense_active1_AC_BK", translate("NDL_asCarrierSense_active1_AC_BK"))


p = s:taboption("ndl", Value, "NDL_timeUp", translate("NDL time up"))

p = s:taboption("ndl", Value, "NDL_timeDown", translate("NDL time down"))

p = s:taboption("ndl", Value, "NDL_minDccSampling", translate("NDL_minDccSampling"))	
	




assert(loadfile("/usr/lib/lua/luci/model/cbi/openc2x_config/statistics.lua"))(s, translate, Flag)



-- End DCC



-- Start ldm

ldm_map = Map("openc2x_ldm")

s = ldm_map:section(NamedSection, arg[1], "ldm", translate("LDM Configuration"))
assert(loadfile("/usr/lib/lua/luci/model/cbi/openc2x_config/statistics.lua"))(s, translate, Flag)



-- End LDM


-- Start ldm

denm_map = Map("openc2x_denm")

s = denm_map:section(NamedSection, arg[1], "denm", translate("DENM Configuration"))


assert(loadfile("/usr/lib/lua/luci/model/cbi/openc2x_config/statistics.lua"))(s, translate, Flag)


-- End DENM



return common_map, cam_map, dcc_map, http_map, obd2_map, gps_map, ldm_map, denm_map
