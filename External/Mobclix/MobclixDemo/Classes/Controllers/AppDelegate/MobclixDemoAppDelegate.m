//
//  MobclixDemoAppDelegate.m
//  Mobclix iOS SDK
//
//  Copyright 2010 Mobclix. All rights reserved.
//

#import "MobclixDemoAppDelegate.h"

#import "Mobclix.h"

@implementation MobclixDemoAppDelegate
@synthesize window, navigationController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	// This is where Mobclix should be called.
	[Mobclix startWithApplicationId:@"insert-your-application-key"];

    [window addSubview:[navigationController view]];
	[window makeKeyAndVisible];
}

- (void)dealloc {
	[window release];
	[navigationController release];
	[super dealloc];
}

@end
