#
# Copyright (C) 2010-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-autossh
PKG_VERSION:=1
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-autossh
	SECTION:=LuCI
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=LuCI luci-app-autossh
	DEPENDS:=+autossh
	PKGARCH:=all
endef

define Package/luci-app-autossh/description
	This package contains LuCI configuration pages for autossh.
endef

define Build/Compile
endef

define Package/luci-app-autossh/install
	$(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,luci-app-autossh))
