//
//  MobclixRatingViewController.h
//  Mobclix iOS SDK Demo
//
//  Copyright 2010 Mobclix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MobclixFeedback.h"

@interface MobclixRatingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MobclixFeedbackDelegate> {
@private
	MobclixFeedback* feedback;
	MCFeedbackRatings ratings;
}

- (void)showSendingView:(BOOL)shouldShow;

@property(nonatomic,retain) IBOutlet UITableView* tableView;
@property(nonatomic,retain) IBOutlet UIView* sendingView;
@end
