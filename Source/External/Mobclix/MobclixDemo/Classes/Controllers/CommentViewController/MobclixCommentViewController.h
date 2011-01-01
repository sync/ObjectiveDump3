//
//  MobclixCommentViewController.h
//  Mobclix iOS SDK Demo
//
//  Copyright 2010 Mobclix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MobclixFeedback.h"

@interface MobclixCommentViewController : UIViewController<UITextViewDelegate,MobclixFeedbackDelegate> {
@private
	UITextView* textView;
	UIView* sendingView;
	MobclixFeedback* feedback;
}

- (void)showSendingView:(BOOL)shouldShow;

@property(nonatomic,retain) IBOutlet UITextView* textView;
@property(nonatomic,retain) IBOutlet UIView* sendingView;
@end
