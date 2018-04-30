#
# Copyright (C) 2006-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=asn1c
PKG_VERSION:=0.9.27
PKG_RELEASE:=1
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:= https://github.com/vlm/asn1c/releases/download/v$(PKG_VERSION)/
PKG_MD5SUM:=e59fb7c79ed69a3a04e02e26b4006355

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=asn1c/host autoconf-archive

PKG_MAINTAINER:=Hal Martin 
PKG_LICENSE:=GPL-2
PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk
define Package/asn1c
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=asn1c compiler
  URL:=https://github.com/vlm/asn1c
  MENU:=1
endef

define Package/asn1c/description
ASN.1 to C compiler takes the ASN.1 module files (example) and generates the C++ compatible C source code. That code can be used to serialize the native C structures into compact and unambiguous BER/OER/PER/XER-based data files, and deserialize the files back.
endef

define Build/Prepare
	$(call Build/Prepare/Default)
endef

define Build/Install
	$(call Build/Install/Default,install)
endef

define Build/InstallDev 
	$(INSTALL_DIR) $(1)/usr/share/asn1c
	$(CP) $(PKG_INSTALL_DIR)/usr/share/asn1c/* $(1)/usr/share/asn1c/
endef
 
define Host/Prepare
	$(call Host/Prepare/Default)
endef

define Host/Install
	$(INSTALL_DIR) $(STAGING_DIR_HOSTPKG)/bin
	$(INSTALL_DIR) $(STAGING_DIR_HOSTPKG)/share/asn1c
	$(INSTALL_DIR) $(STAGING_DIR_HOSTPKG)/share/asn1c/standard-modules
	$(INSTALL_BIN) $(HOST_BUILD_DIR)/asn1c/asn1c $(STAGING_DIR_HOSTPKG)/bin/
	$(INSTALL_BIN) $(HOST_BUILD_DIR)/asn1c/enber $(STAGING_DIR_HOSTPKG)/bin/
	$(INSTALL_BIN) $(HOST_BUILD_DIR)/asn1c/unber $(STAGING_DIR_HOSTPKG)/bin/
	$(CP) $(HOST_BUILD_DIR)/skeletons/*.c $(STAGING_DIR_HOSTPKG)/share/asn1c/
	$(CP) $(HOST_BUILD_DIR)/skeletons/*.h $(STAGING_DIR_HOSTPKG)/share/asn1c/
	$(CP) $(HOST_BUILD_DIR)/skeletons/file-dependencies $(STAGING_DIR_HOSTPKG)/share/asn1c/
	$(CP) $(HOST_BUILD_DIR)/skeletons/standard-modules/*.asn1 $(STAGING_DIR_HOSTPKG)/share/asn1c/standard-modules/
endef


define Package/asn1c/install
endef


$(eval $(call BuildPackage,asn1c))
$(eval $(call HostBuild))
