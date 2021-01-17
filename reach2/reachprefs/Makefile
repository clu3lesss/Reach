TARGET := iphone:clang:13.5:13.0

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = reachprefs

reachprefs_FILES = RPFRootListController.m
reachprefs_FRAMEWORKS = UIKit
reachprefs_PRIVATE_FRAMEWORKS = Preferences
reachprefs_INSTALL_PATH = /Library/PreferenceBundles
reachprefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
