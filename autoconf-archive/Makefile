include $(TOPDIR)/rules.mk

PKG_NAME:=autoconf-archive
PKG_VERSION:=2013.11.01
PKG_BUILD_DEPENDS:=autoconf-archive/host
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=@GNU/autoconf-archive
PKG_MD5SUM:=f01381c7d3570cf3fcf65093989e0d29
include $(INCLUDE_DIR)/package.mk

include $(INCLUDE_DIR)/host-build.mk

HOST_CONFIGURE_ARGS += \
	--datarootdir=$(STAGING_DIR_HOST)/share


define Package/autoconf-archive
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=GNU Autoconf Archive 
  URL:=http://www.gnu.org/software/autoconf-archive/
  MENU:=1
endef

define Package/autoconf-archive/description
A collection of freely re-usable Autoconf macros. 
endef

define Host/Compile
	export SHELL="$(BASH)"; $(MAKE) -C $(HOST_BUILD_DIR)
endef

define Host/Install
	export SHELL="$(BASH)"; $(MAKE) -C $(HOST_BUILD_DIR) install
endef

define Host/Clean
	-export SHELL="$(BASH)"; $(MAKE) -C $(HOST_BUILD_DIR) uninstall
	$(call Host/Clean/Default)
endef

$(eval $(call BuildPackage,autoconf-archive))
$(eval $(call HostBuild))
