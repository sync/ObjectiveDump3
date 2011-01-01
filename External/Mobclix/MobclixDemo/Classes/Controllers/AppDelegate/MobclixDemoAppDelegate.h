//
//  MobclixDemoAppDelegate.h
//  Mobclix iOS SDK
//
//  Copyright 2010 Mobclix. All rights reserved.
//

@interface MobclixDemoAppDelegate : NSObject <UIApplicationDelegate> {
	IBOutlet UIWindow *window;
	IBOutlet UINavigationController *navigationController;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UINavigationController *navigationController;

@end
