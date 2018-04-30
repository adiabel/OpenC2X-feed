#
# Copyright (C) 2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=cppzmq
PKG_VERSION:=4.2.2
PKG_RELEASE:=1
PKG_MAINTAINER:=Dirk Chang <dirk@kooiot.com>
PKG_LICENSE:=MIT

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/zeromq/cppzmq/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=3ef50070ac5877c06c6bb25091028465020e181bbfd08f110294ed6bc419737d

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/cppzmq
  SUBMENU:=C++
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=C++ ZeroMQ binding
  URL:=https://github.com/zeromq/cppzmq/
  DEPENDS:= +stdzmq
endef

define Package/cppzmq/description
 cppzmq is a C++ binding to ZeroMQ.
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(INSTALL_DIR) $(1)/usr/share/cmake/cppzmq
	$(CP) $(PKG_INSTALL_DIR)/usr/include/* $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/share/cmake/cppzmq/* $(1)/usr/share/cmake/cppzmq
endef

define Package/cppzmq/install
	$(INSTALL_DIR) $(1)/usr/include
	$(INSTALL_DIR) $(1)/usr/share/cmake/cppzmq
	$(CP) $(PKG_INSTALL_DIR)/usr/include/* $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/share/cmake/cppzmq/* $(1)/usr/share/cmake/cppzmq
endef

$(eval $(call BuildPackage,cppzmq))
