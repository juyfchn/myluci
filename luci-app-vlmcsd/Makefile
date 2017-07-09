include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-vlmcsd
PKG_VERSION=svn1111
PKG_RELEASE:=1


PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-vlmcsd
	TITLE:=LuCI support for vlmcsd
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	URL:=http://forums.mydigitallife.info/threads/50234
	DEPENDS:=+libc +libpthread
endef

define Package/luci-app-vlmcsd/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	( . /etc/uci-defaults/luci-app-vlmcsd ) && rm -f /etc/uci-defaults/luci-app-vlmcsd
	rm -f /tmp/luci-indexcache
fi
exit 0
endef



define Package/luci-app-vlmcsd/postrm
#!/bin/sh
	if [ -f /etc/dnsmasq.conf ]; then
		sed -i '/^srv-host=_vlmcs\._tcp/d' /etc/dnsmasq.conf
	fi
	if [ -n "$(awk '/vlmcsd\.log/{print $0}' /etc/crontabs/root)" ];then
		sed -i '/vlmcsd\.log/d' /etc/crontabs/root >/dev/null 2>&1
	fi
	rm -rf /var/log/vlmcsd.log 2>/dev/null
	if pidof vlmcsd >/dev/null; then
	killall vlmcsd
	fi
exit 0
endef



define Package/luci-app-vlmcsd/description
	vlmcsd is a KMS Emulator in C.
endef





define Package/luci-app-vlmcsd/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/vlmcsd $(1)/usr/sbin/vlmcsd
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/vlmcs $(1)/usr/sbin/vlmcs

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/vlmcsd.init $(1)/etc/init.d/vlmcsd

	$(CP) ./root/* $(1)/

endef

$(eval $(call BuildPackage,luci-app-vlmcsd))
