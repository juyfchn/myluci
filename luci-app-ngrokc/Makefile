include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-ngrokc
PKG_VERSION:=1.37
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-ngrokc
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=LuCI support for ngrokc
	URL:=https://github.com/dosgo/ngrok-c
	DEPENDS:=+libc +libpthread +libopenssl +libstdcpp
endef


define Package/luci-app-ngrokc/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	( . /etc/uci-defaults/luci-app-ngrokc ) && rm -f /etc/uci-defaults/luci-app-ngrokc
	rm -f /tmp/luci-indexcache
fi
exit 0
endef



define Build/Prepare
	$(foreach po,$(wildcard ${CURDIR}/i18n/zh-cn/*.po), \
		po2lmo $(po) $(PKG_BUILD_DIR)/$(patsubst %.po,%.lmo,$(notdir $(po)));)
	$(call Build/Prepare/Default,)
	$(CP) $(PKG_BUILD_DIR)/Makefile.openssl $(PKG_BUILD_DIR)/Makefile
endef

define Package/luci-app-ngrokc/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/*.*.lmo $(1)/usr/lib/lua/luci/i18n/
	$(CP) ./files/* $(1)/
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/ngrokc $(1)/usr/bin
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./ngrokc.init $(1)/etc/init.d/ngrokc
endef


$(eval $(call BuildPackage,luci-app-ngrokc))
