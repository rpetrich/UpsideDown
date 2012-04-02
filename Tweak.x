#import <objc/runtime.h>
#import <UIKit/UIKit.h>

%hook UIWindow

- (BOOL)_shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
		BOOL result = %orig;
		if (result)
			return result;
		interfaceOrientation = UIInterfaceOrientationPortrait;
	}
	return %orig;
}

%end

%hook UIDevice

- (void)setOrientation:(UIDeviceOrientation)orientation animated:(BOOL)animated
{
	switch (orientation) {
		case UIDeviceOrientationPortrait:
			orientation = UIDeviceOrientationPortraitUpsideDown;
			break;
		case UIDeviceOrientationPortraitUpsideDown:
			orientation = UIDeviceOrientationPortrait;
			break;
		case UIDeviceOrientationLandscapeLeft:
			orientation = UIDeviceOrientationLandscapeRight;
			break;
		case UIDeviceOrientationLandscapeRight:
			orientation = UIDeviceOrientationLandscapeLeft;
			break;
		default:
			break;
	}
	%orig;
}

%end

%ctor {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSString *bundleIdentifier = [NSBundle mainBundle].bundleIdentifier;
	if (bundleIdentifier && ![bundleIdentifier isEqualToString:@"com.apple.springboard"]) {
		%init;
	}
	[pool drain];
}
