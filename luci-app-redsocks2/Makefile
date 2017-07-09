#
# Copyright (C) 2014 OpenWrt-dist
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk


PKG_NAME:=luci-app-redsocks2
PKG_VERSION:=0.66
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)/$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-redsocks2
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=Redirect any TCP connection to a SOCKS or HTTPS proxy server
	URL:=https://github.com/semigodking/redsocks
	DEPENDS:=+libevent2 +libopenssl +kmod-ipt-ipopt +iptables-mod-ipopt +ipset +ip +iptables-mod-tproxy +kmod-ipt-tproxy +iptables-mod-nat-extra
endef

define Package/luci-app-redsocks2/description
This is a modified version of original redsocks. \
The name is changed to be REDSOCKS2 since this release to distinguish with original redsocks. \
This variant is useful for anti-GFW (Great Fire Wall).
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
rm -rf /tmp/luci*
endef

define Package/luci-app-redsocks2/conffiles
/etc/config/redsocks2
endef

define Package/luci-app-redsocks2/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/redsocks2 $(1)/usr/sbin
	$(INSTALL_DIR) $(1)/etc/redsocks2
	$(INSTALL_DATA) ./files/redsocks2.template $(1)/etc/redsocks2/config.template
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./redsocks2.init $(1)/etc/init.d/redsocks2
	$(CP) ./luci/* $(1)/
endef

$(eval $(call BuildPackage,luci-app-redsocks2))
