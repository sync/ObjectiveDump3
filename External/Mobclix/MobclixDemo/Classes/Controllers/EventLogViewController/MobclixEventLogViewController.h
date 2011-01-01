@interface MobclixEventLogViewController : UIViewController <UIPickerViewDelegate> {
	IBOutlet UITextField *textProcessName;
	IBOutlet UITextField *textEventName;
	IBOutlet UITextField *textDescription;
	IBOutlet UISwitch *swStop;
	IBOutlet UIPickerView *pickerLog;
}

@end

