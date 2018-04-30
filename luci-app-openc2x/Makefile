include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-openc2x
PKG_VERSION:=1
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-openc2x
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=GUI for openc2x
	PKGARCH:=all
	DEPENDS:=+openc2x +luafilesystem
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/luci-app-openc2x/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/openc2x
	$(INSTALL_DIR) $(1)/www/luci-static/resources/openc2x
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(CP) ./luasrc/controller/openc2x.lua \
		$(1)/usr/lib/lua/luci/controller/
	$(CP) ./luasrc/model/cbi/* \
		$(1)/usr/lib/lua/luci/model/cbi/
	$(CP) ./luasrc/view/* \
		$(1)/usr/lib/lua/luci/view/
	$(CP) ./htdocs/luci-static/openc2x/* \
		$(1)/www/luci-static/resources/openc2x/
endef


$(eval $(call BuildPackage,luci-app-openc2x))
