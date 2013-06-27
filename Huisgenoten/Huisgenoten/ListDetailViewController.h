//
//  ListDetailViewController.h
//  Huisgenoten
//
//  Created by Miguel Pruijssers on 16-06-13.
//
//

#import <UIKit/UIKit.h>
#import "IconPickerViewController.h"

@class ListDetailViewController;
@class Alarm;

@protocol ListDetailViewControllerDelegate <NSObject>

- (void)listDetailViewControllerDidCancel:(ListDetailViewController *)controller;
- (void)listDetailViewController:(ListDetailViewController *)controller didFinishAddingAlarm:(Alarm *)alarm;
- (void)listDetailViewController:(ListDetailViewController *)controller didFinishEditingAlarm:(Alarm *)alarm;

@end

@interface ListDetailViewController : UITableViewController <UITextFieldDelegate, IconPickerViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *doneBarButton;
@property (nonatomic, weak) IBOutlet UIImageView *iconImageView;
@property (nonatomic, weak) id <ListDetailViewControllerDelegate> delegate;
@property (nonatomic, strong) Alarm *listToEdit;

- (IBAction)cancel;
- (IBAction)done;

@end