//
//  MobclixDemoViewController.h
//  MobclixDemo
//
//  Copyright 2010 Mobclix. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MobclixDemoViewController : UIViewController<UITableViewDelegate,UITableViewDataSource> {
@private
	UITableView* _tableView;
}

@property(nonatomic,retain) IBOutlet UITableView* tableView;
@end
