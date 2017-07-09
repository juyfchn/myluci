#
# Copyright (C) 2010-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-xunlei
PKG_VERSION:=1.0.31
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-xunlei
	SECTION:=LuCI
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=LuCI luci-app-xunlei
	DEPENDS:=+wget +unzip
	PKGARCH:=all
endef

define Package/luci-app-xunlei/description
LuCI support for xware
endef

define Package/luci-app-xunlei/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	( . /etc/uci-defaults/luci-app-xunlei ) && rm -f /etc/uci-defaults/luci-app-xunlei
	rm -f /tmp/luci-indexcache
fi
exit 0
endef

define Build/Compile
endef

define Package/luci-app-xunlei/install
	$(CP) ./files/* $(1)
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./xunlei.init $(1)/etc/init.d/xunlei
	$(INSTALL_DIR) $(1)/etc/uci-defaults/
	$(INSTALL_BIN) ./luci-xunlei $(1)/etc/uci-defaults/luci-app-xunlei
endef

$(eval $(call BuildPackage,luci-app-xunlei))
