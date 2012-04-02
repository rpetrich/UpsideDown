TWEAK_NAME = UpsideDown
UpsideDown_FILES = Tweak.x
UpsideDown_FRAMEWORKS = Foundation UIKit QuartzCore

ADDITIONAL_CFLAGS = -std=c99
TARGET_IPHONEOS_DEPLOYMENT_VERSION = 4.0

include framework/makefiles/common.mk
include framework/makefiles/tweak.mk
