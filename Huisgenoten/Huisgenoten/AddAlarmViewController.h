//
//  AddAlarmViewController.h
//  Huisgenoten
//
//  Created by Miguel Pruijssers on 15-06-13.
//
//

#import <UIKit/UIKit.h>

@class AddAlarmViewController;
@class AlarmItem;

@protocol AddAlarmViewControllerDelegate <NSObject>

- (void)addAlarmViewControllerDidCancel:(AddAlarmViewController *)controller;

- (void)addAlarmViewController:(AddAlarmViewController *)controller didFinishAddingItem:(AlarmItem *)item;

@end

@interface AddAlarmViewController : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *doneBarButton;
@property (nonatomic, weak) id <AddAlarmViewControllerDelegate> delegate;

- (IBAction)cancel;
- (IBAction)done;

@end
