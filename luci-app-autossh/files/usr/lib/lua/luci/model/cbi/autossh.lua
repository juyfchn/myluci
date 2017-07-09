--[[
 Copyright (C) 2016 maz-1 <ohmygod19993@gmail.com>

 This is free software, licensed under the GNU General Public License v3.
 See /LICENSE for more information.
]]--

if luci.sys.call("pidof autossh >/dev/null") == 0 then
m = Map("autossh", translate("AutoSSH"),translate("状态 - <font color=\"green\">运行中</font>") )
else
m = Map("autossh", translate("AutoSSH"),translate("状态 - <font color=\"red\">未运行</font>") )
end

s = m:section(TypedSection, "autossh", translate("AutoSSH 设置"))
s.anonymous   = true
s.addremove   = false

o = s:option(Flag, "enabled", translate("Enable"))
o.rmempty = false

function o.cfgvalue(self, section)
	return luci.sys.init.enabled("autossh") and self.enabled or self.disabled
end

function o.write(self, section, value)
	if value == "1" then
		luci.sys.init.enable("autossh")
		luci.sys.call("/etc/init.d/autossh start >/dev/null")
	else
		luci.sys.call("/etc/init.d/autossh stop >/dev/null")
		luci.sys.init.disable("autossh")
	end

	return Flag.write(self, section, value)
end

o = s:option(Value, "ssh", translate("SSH 命令参数"))
o.rmempty     = false

o = s:option(Value, "gatetime", translate("启动前等待时间"))
o.placeholder = 0
o.default     = 0
o.datatype    = "uinteger"

o = s:option(Value, "monitorport", translate("监听端口"))
o.datatype    = "port"
o.rmempty     = false

o = s:option(Value, "poll", translate("检测时间"))
o.placeholder = 600
o.default     = 600
o.datatype    = "uinteger"

return m
