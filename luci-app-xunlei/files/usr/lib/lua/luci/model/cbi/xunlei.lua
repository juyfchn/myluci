local fs = require "nixio.fs"
local util = require "nixio.util"

local running=(luci.sys.call("pidof EmbedThunderManager > /dev/null") == 0)
local button=""
local xunleiinfo=""
local tblXLInfo={}
local detailInfo=""

if running then
	xunleiinfo = luci.sys.exec("wget http://127.0.0.1:9000/getsysinfo -O - 2>/dev/null")

        button = "&nbsp;&nbsp;&nbsp;&nbsp;" .. translate("<br />运行状态：") .. xunleiinfo	
	m = Map("xunlei", translate("Xware"), translate("迅雷远程下载 <font color=\"green\">正在运行</font>") .. button)
	string.gsub(string.sub(xunleiinfo, 2, -2),'[^,]+',function(w) table.insert(tblXLInfo, w) end)
	
	detailInfo = [[<p>启动信息：]] .. xunleiinfo .. [[</p>]]
	if tonumber(tblXLInfo[1]) == 0 then
	  detailInfo = detailInfo .. [[<p>状态正常</p>]]
	else
	  detailInfo = detailInfo .. [[<p style="color:red">执行异常</p>]]
	end
	
	if tonumber(tblXLInfo[2]) == 0 then
	  detailInfo = detailInfo .. [[<p style="color:red">网络异常</p>]]
	else
	  detailInfo = detailInfo .. [[<p>网络正常</p>]]
	end
	
	if tonumber(tblXLInfo[4]) == 0 then
	  detailInfo = detailInfo .. [[<p>未绑定]].. [[&nbsp;&nbsp;激活码：]].. tblXLInfo[5] ..[[</p>]]	  
	else
	  detailInfo = detailInfo .. [[<p>已绑定</p>]]
	end

	if tonumber(tblXLInfo[6]) == 0 then
	  detailInfo = detailInfo .. [[<p style="color:red">磁盘挂载检测失败</p>]]
	else
	  detailInfo = detailInfo .. [[<p>磁盘挂载检测成功</p>]]
	end	
else
	m = Map("xunlei", translate("Xware"), translate("迅雷远程下载 <font color=\"red\">未运行</font>"))
end

-----------
--Xware--
-----------

s = m:section(TypedSection, "xunlei","Xware 设置")
s.anonymous = true

s:tab("basic",  translate("Settings"))

enable = s:taboption("basic", Flag, "enable", "启用 迅雷远程下载")
enable.rmempty = false

local devices = {}
util.consume((fs.glob("/mnt/sd??*")), devices)

device = s:taboption("basic", Value, "device", "挂载点", "<br />迅雷程序下载目录所在的“挂载点”。")
for i, dev in ipairs(devices) do
	device:value(dev)
end
if nixio.fs.access("/etc/config/xunlei") then
        device.titleref = luci.dispatcher.build_url("admin", "system", "fstab")
end

file = s:taboption("basic", Value, "file", "迅雷程序安装路径", "<br />迅雷程序安装路径，例如：/mnt/sda1，将会安装在/mnt/sda1/xunlei 下。")
for i, dev in ipairs(devices) do
	file:value(dev)
end


up = s:taboption("basic", Flag, "up", "升级迅雷远程下载", "首次启动请勾选")
up.rmempty = false

zurl = s:taboption("basic", Value, "url", "地址", "自定义迅雷远程下载地址。")
zurl.rmempty = false
zurl:value("https://git.oschina.net/baibihuiyi/xware_1.0.31/raw/master")
zurl:value("https://coding.net/u/baibihuiyi/p/xware_1.0.31/git/raw/master")
zurl:value("https://raw.githubusercontent.com/baibihuiyi/xware_1.0.31/master")


vod = s:taboption("basic", Flag, "vod", "删除迅雷VOD服务器", "删除迅雷VOD服务器。")
vod.rmempty = false

xwareup = s:taboption("basic", Value, "xware", "Xware 程序版本：","<br />版本选择说明：<br />ar71xx:mipseb_32_uclibc<br />ramips:mipsel_32_uclibc<br />其他型号的路由根据CPU选择。")
xwareup.rmempty = false
xwareup:value("Xware1.0.31_mipseb_32_uclibc.zip", "mipseb_32_uclibc")
xwareup:value("Xware1.0.31_mipsel_32_uclibc.zip", "mipsel_32_uclibc")
xwareup:value("Xware1.0.31_x86_32_glibc.zip", "x86_32_glibc")
xwareup:value("Xware1.0.31_x86_32_uclibc.zip", "x86_32_uclibc")
xwareup:value("Xware1.0.31_pogoplug.zip", "pogoplug")
xwareup:value("Xware1.0.31_armeb_v6j_uclibc.zip", "armeb_v6j_uclibc")
xwareup:value("Xware1.0.31_armeb_v7a_uclibc.zip", "armeb_v7a_uclibc")
xwareup:value("Xware1.0.31_armel_v5t_uclibc.zip", "armel_v5t_uclibc")
xwareup:value("Xware1.0.31_armel_v5te_android.zip", "armel_v5te_android")
xwareup:value("Xware1.0.31_armel_v5te_glibc.zip", "armel_v5te_glibc")
xwareup:value("Xware1.0.31_armel_v6j_uclibc.zip", "armel_v6j_uclibc")
xwareup:value("Xware1.0.31_armel_v7a_uclibc.zip", "armel_v7a_uclibc")
xwareup:value("Xware1.0.31_asus_rt_ac56u.zip", "asus_rt_ac56u")
xwareup:value("Xware1.0.31_cubieboard.zip", "cubieboard")
xwareup:value("Xware1.0.31_iomega_cloud.zip", "iomega_cloud")
xwareup:value("Xware1.0.31_my_book_live.zip", "my_book_live")
xwareup:value("Xware1.0.31_netgear_6300v2.zip", "netgear_6300v2")

s:taboption("basic", DummyValue,"opennewwindow" ,"<br /><p align=\"justify\"><script type=\"text/javascript\"></script><input type=\"button\" class=\"cbi-button cbi-button-apply\" value=\"获取启动信息\" onclick=\"window.open('http://'+window.location.host+':9000/getsysinfo')\" /></p>", detailInfo)


s:taboption("basic", DummyValue,"opennewwindow" ,"<br /><p align=\"justify\"><script type=\"text/javascript\"></script><input type=\"button\" class=\"cbi-button cbi-button-apply\" value=\"迅雷远程下载页面\" onclick=\"window.open('http://yuancheng.xunlei.com')\" /></p>", "将激活码填进网页即可绑定。")


s:tab("editconf_mounts", translate("挂载点配置"))
editconf_mounts = s:taboption("editconf_mounts", Value, "_editconf_mounts", 
	translate("挂载点配置(一般情况下只需填写你的挂载点目录即可)"), 
	translate("Comment Using #"))
editconf_mounts.template = "cbi/tvalue"
editconf_mounts.rows = 20
editconf_mounts.wrap = "off"

function editconf_mounts.cfgvalue(self, section)

	return fs.readfile("/tmp/etc/thunder_mounts.cfg") or ""
end
function editconf_mounts.write(self, section, value1)
	if value1 then
		value1 = value1:gsub("\r\n?", "\n")
		fs.writefile("/tmp/thunder_mounts.cfg", value1)
		if (luci.sys.call("cmp -s /tmp/thunder_mounts.cfg /tmp/etc/thunder_mounts.cfg") == 1) then
			fs.writefile("/tmp/etc/thunder_mounts.cfg", value1)
		end
		fs.remove("/tmp/thunder_mounts.cfg")
	end
end

s:tab("editconf_etm", translate("Xware 配置"))
editconf_etm = s:taboption("editconf_etm", Value, "_editconf_etm", 
	translate("Xware 配置："), 
	translate("注释用“ ; ”"))
editconf_etm.template = "cbi/tvalue"
editconf_etm.rows = 20
editconf_etm.wrap = "off"

function editconf_etm.cfgvalue(self, section)
	return fs.readfile("/tmp/etc/etm.cfg") or ""
end
function editconf_etm.write(self, section, value2)
	if value2 then
		value2 = value2:gsub("\r\n?", "\n")
		fs.writefile("/tmp/etm.cfg", value2)
		if (luci.sys.call("cmp -s /tmp/etm.cfg /tmp/etc/etm.cfg") == 1) then
			fs.writefile("/tmp/etc/etm.cfg", value2)
		end
		fs.remove("/tmp/etm.cfg")
	end
end

s:tab("editconf_download", translate("下载配置"))
editconf_download = s:taboption("editconf_download", Value, "_editconf_download", 
	translate("下载配置"), 
	translate("注释用“ ; ”"))
editconf_download.template = "cbi/tvalue"
editconf_download.rows = 20
editconf_download.wrap = "off"

function editconf_download.cfgvalue(self, section)
	return fs.readfile("/tmp/etc/download.cfg") or ""
end
function editconf_download.write(self, section, value3)
	if value3 then
		value3 = value3:gsub("\r\n?", "\n")
		fs.writefile("/tmp/download.cfg", value3)
		if (luci.sys.call("cmp -s /tmp/download.cfg /tmp/etc/download.cfg") == 1) then
			fs.writefile("/tmp/etc/download.cfg", value3)
		end
		fs.remove("/tmp/download.cfg")
	end
end
return m
