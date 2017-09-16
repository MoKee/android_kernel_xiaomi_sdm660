#Android makefile to build kernel as a part of Android Build

ifeq ($(TARGET_PREBUILT_KERNEL),)

LOCAL_PRIVATE_PATH := kernel/xiaomi/sdm660

KERNEL_ARCH := arm64

KERNEL_OUT := $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ
KERNEL_HEADERS_INSTALL := $(KERNEL_OUT)/usr
KERNEL_MODULES_OUT := $(TARGET_OUT)/lib/modules

TARGET_PREBUILT_INT_KERNEL := $(KERNEL_OUT)/arch/$(KERNEL_ARCH)/boot/Image.gz-dtb

TARGET_PREBUILT_KERNEL := $(TARGET_PREBUILT_INT_KERNEL)

define cp-modules
cp -r $(LOCAL_PRIVATE_PATH)/modules/* $(KERNEL_MODULES_OUT)/
endef

$(KERNEL_OUT):
	mkdir -p $(KERNEL_OUT)

$(TARGET_PREBUILT_INT_KERNEL): $(KERNEL_OUT) $(KERNEL_HEADERS_INSTALL)
	rm -rf $(KERNEL_MODULES_OUT)
	mkdir -p $(KERNEL_MODULES_OUT)
	$(cp-modules)
	ln -sf /system/lib/modules/qca_cld3/qca_cld3_wlan.ko $(TARGET_OUT)/lib/modules/wlan.ko

$(KERNEL_HEADERS_INSTALL): $(KERNEL_OUT)
	cp -r $(LOCAL_PRIVATE_PATH)/user/* $(KERNEL_OUT)/

endif
