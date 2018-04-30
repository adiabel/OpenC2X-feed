#
# Copyright (C) 2006-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=openc2x
PKG_VERSION:=1.2
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:= https://codeload.github.com/florianklingler/OpenC2X-standalone/tar.gz/v$(PKG_VERSION)?
PKG_MD5SUM:=fecfe43487f9c1b1cd79769840ac063f

PKG_BUILD_DIR:=$(BUILD_DIR)/OpenC2X-standalone-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=asn1c/host autoconf-archive


PKG_MAINTAINER:=Hal Martin 
PKG_LICENSE:=GPL-2
PKG_CONFIG_DEPENDS:=
PKG_USE_MIPS16:=0 

include $(INCLUDE_DIR)/uclibc++.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk



define Package/openc2x
  SECTION:=utils
  CATEGORY:=Utilities
  PKG_BUILD_DEPENDS := cppzmq asn1c
  DEPENDS:=+boost +boost-system +boost-thread +protobuf +libstdzmq +libnl-tiny +gpsd +libgps +libsqlite3 +libuci
  TITLE:=openc2x
  URL:=http://www.ccs-labs.org/software/openc2x/
  MENU:=1
endef

	
TARGET_CXXFLAGS += \
	-I$(STAGING_DIR)/usr/include/libnl-tiny \
	-I$(STAGING_DIR)/usr/include \


CMAKE_OPTIONS += \
	-DLIBNL_LIBS=-lnl-tiny \

define Package/openc2x/description
Vehicular networking is at the corner from early research to final deployment. This phase requires more field testing and real-world experimentation. Most Field Operational Tests (FOTs) are based on proprietary commercial hardware that only allows for marginal modifications of the protocol stack. Furthermore, the roll-out of updated implementations for new or changing protocol standards often takes a prohibitively long time.

We developed one of the first complete Open Source experimental and prototyping platform for vehicular networking solutions. Our system supports most of the ETSI ITS-G5 features and runs on standard Linux. New protocol features and updates could now easily be done by and shared with the vehicular networking R&D community. 
endef

define Build/Prepare
	$(call Build/Prepare/Default)
endef


define Package/openc2x/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/usr/share/openc2x/gpsdata
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/* $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/* $(1)/usr/bin/
	$(CP) $(PKG_INSTALL_DIR)/etc/config/* $(1)/etc/config/
	$(CP) files/etc/init.d/openc2x $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/etc/uci-defaults/uci-defaults-openc2x $(1)/etc/uci-defaults/openc2x
endef

$(eval $(call BuildPackage,openc2x))
