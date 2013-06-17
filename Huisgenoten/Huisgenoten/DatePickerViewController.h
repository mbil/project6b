//
//  DatePickerViewController.h
//  Huisgenoten
//
//  Created by Miguel Pruijssers on 17-06-13.
//
//

#import <UIKit/UIKit.h>

@class DatePickerViewController;

@protocol DatePickerViewControllerDelegate <NSObject>

- (void)datePickerDidCancel:(DatePickerViewController *)picker;
- (void)datePicker:(DatePickerViewController *)picker didPickDate:(NSDate *)date;

@end

@interface DatePickerViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, weak) id <DatePickerViewControllerDelegate> delegate;
@property (nonatomic, strong) NSDate *date;

- (IBAction)cancel;
- (IBAction)done;
- (IBAction)dateChanged;

@end
