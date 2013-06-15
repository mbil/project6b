//
//  AlarmDetailViewController.h
//  Huisgenoten
//
//  Created by Miguel Pruijssers on 15-06-13.
//
//

#import <UIKit/UIKit.h>

@class AlarmDetailViewController;
@class AlarmItem;

@protocol AlarmDetailViewControllerDelegate <NSObject>

- (void)alarmDetailViewControllerDidCancel:(AlarmDetailViewController *)controller;
- (void)alarmDetailViewController:(AlarmDetailViewController *)controller didFinishAddingItem:(AlarmItem *)item;
- (void)alarmDetailViewController:(AlarmDetailViewController *)controller didFinishEditingItem:(AlarmItem *)item;

@end

@interface AlarmDetailViewController : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *doneBarButton;
@property (nonatomic, weak) id <AlarmDetailViewControllerDelegate> delegate;
@property (nonatomic, strong) AlarmItem *alarmToEdit;

- (IBAction)cancel;
- (IBAction)done;

@end
