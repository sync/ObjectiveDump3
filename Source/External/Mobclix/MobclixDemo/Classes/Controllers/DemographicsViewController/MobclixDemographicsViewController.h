//
//  MobclixDemographicsViewController.h
//  MobclixDemo
//
//  Copyright 2010 Mobclix. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MobclixDemographicsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate> {
@private
	UITableView* _tableView;
	UIPickerView* _pickerView;
	UIDatePicker* _datePicker;
	UITextField* _integerTextField;
	UITextField* _stringTextField;
	NSArray* sections;
	NSArray* pickerComponents;
	BOOL dateSet;
	NSIndexPath* editingIndexPath;
}

@property(nonatomic,retain) IBOutlet UITableView* tableView;
@property(nonatomic,retain) IBOutlet UIPickerView* pickerView;
@property(nonatomic,retain) IBOutlet UIDatePicker* datePicker;
@property(nonatomic,retain) IBOutlet UITextField* integerTextField;
@property(nonatomic,retain) IBOutlet UITextField* stringTextField;

@property(nonatomic,retain) NSArray* pickerComponents;
@property(nonatomic,retain) NSIndexPath* editingIndexPath;
@end
