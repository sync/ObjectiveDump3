//
//  MobclixAdvertisingViewController.m
//  MobclixDemo
//
//  Copyright 2010 Mobclix. All rights reserved.
//

#import "MobclixAdvertisingViewController.h"

@implementation MobclixAdvertisingViewController
@synthesize adUnit1, adUnit2, adUnit3, adUnit4, scrollView;

- (id)init {
#ifdef __IPHONE_3_2
	NSString* platform = [UIDevice instancesRespondToSelector:@selector(userInterfaceIdiom)] && [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad ? @"ipad" : @"iphone";
#else
	NSString* platform = @"iphone";
#endif
	
	if((self = [super initWithNibName:[@"MobclixAdvertisingViewController-" stringByAppendingString:platform] bundle:nil])) {
		
	}
	
	return self;
}

- (void)viewDidLoad {
	self.title = @"Advertising";
	
	UIBarButtonItem* refreshAdsButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
																					  target:self 
																					  action:@selector(refreshAds)];
	[self.navigationItem setRightBarButtonItem:refreshAdsButton animated: NO];
	[refreshAdsButton release];
	
	self.adUnit1.delegate = self;
	self.adUnit2.delegate = self;
	self.adUnit3.delegate = self;
	self.adUnit4.delegate = self;
	
	if(self.scrollView) {
		[self.scrollView setContentSize:CGSizeMake(320.0, 406.0)];
	}
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

	/**
	 *	Resume ad refreshing
	 *	If this is the first time an ad is being loaded, getAd will be called right away
	 */
	[self.adUnit1 resumeAdAutoRefresh];
	[self.adUnit2 resumeAdAutoRefresh];
	[self.adUnit3 resumeAdAutoRefresh];
	[self.adUnit4 resumeAdAutoRefresh];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	
	/**
	 *	Pause ads to prevent them from reload offscreen
	 * This is very important and should not be left out
	 */
	[self.adUnit1 pauseAdAutoRefresh];
	[self.adUnit2 pauseAdAutoRefresh];
	[self.adUnit3 pauseAdAutoRefresh];
	[self.adUnit4 pauseAdAutoRefresh];
}

- (void)viewDidUnload {
	// Cancel ads
	[self.adUnit1 cancelAd];
	[self.adUnit2 cancelAd];
	[self.adUnit3 cancelAd];
	[self.adUnit4 cancelAd];
	
	/**
	 *	Disconnect delegate and release the ads
	 *
	 *	If you used a nib to connect your ads, they'll automatically reconnect when the view is loaded again
	 *	If not, you should set them up in viewDidLoad
	 */
	self.adUnit1.delegate = nil;
	self.adUnit1 = nil;
	
	self.adUnit2.delegate = nil;
	self.adUnit2 = nil;
	
	self.adUnit3.delegate = nil;
	self.adUnit3 = nil;
	
	self.adUnit4.delegate = nil;
	self.adUnit4 = nil;
	
	[super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation {
	return YES;
}

- (IBAction)refreshAds {
	// Manually request a new ad
	[self.adUnit1 getAd];
	[self.adUnit2 getAd];
	
	if(self.adUnit3) { // iPad
		[self.adUnit3 getAd];
		[self.adUnit4 getAd];
	}
}

#pragma mark -
#pragma mark MobclixAdViewDelegate Methods

- (void)adViewDidFinishLoad:(MobclixAdView*)adView {
	NSLog(@"Ad Loaded: %@.", NSStringFromCGSize(adView.frame.size));
}

- (void)adView:(MobclixAdView*)adView didFailLoadWithError:(NSError*)error {
	NSLog(@"Ad Failed: %@.", NSStringFromCGSize(adView.frame.size));
}

- (void)adViewWillTouchThrough:(MobclixAdView*)adView {
	NSLog(@"Ad Will Touch Through: %@.", NSStringFromCGSize(adView.frame.size));
}

- (void)adViewDidFinishTouchThrough:(MobclixAdView*)adView {
	NSLog(@"Ad Did Finish Touch Through: %@.", NSStringFromCGSize(adView.frame.size));
}

/*******************************************************************************
 MobclixAdViewDelegate Optional Targeting Parameters
 
 - (NSString*)keywords { }
 - (NSString*)query { }
 
 ******************************************************************************/

#pragma mark -

- (void)dealloc {
	/**
	 * All three of the following methods should be implemented
	 * to avoid crashing in your application.
	 */
	[self.adUnit1 cancelAd];
	[self.adUnit2 cancelAd];
	[self.adUnit3 cancelAd];
	[self.adUnit4 cancelAd];
	
	self.adUnit1.delegate = nil;
	self.adUnit2.delegate = nil;
	self.adUnit3.delegate = nil;
	self.adUnit4.delegate = nil;
	
	self.adUnit1 = nil;
	self.adUnit2 = nil;
	self.adUnit3 = nil;
	self.adUnit4 = nil;
	
	self.scrollView = nil;
	
	[super dealloc];
}

@end
