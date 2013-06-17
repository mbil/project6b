//
//  ListDetailViewController.h
//  Huisgenoten
//
//  Created by Miguel Pruijssers on 16-06-13.
//
//

#import <UIKit/UIKit.h>
//#import "AlarmsDataModel.h"

@class ListDetailViewController;
@class Alarm;

@protocol ListDetailViewControllerDelegate <NSObject>
- (void)listDetailViewControllerDidCancel:(ListDetailViewController *)controller;
- (void)listDetailViewController:(ListDetailViewController *)controller didFinishAddingAlarm:(Alarm *)alarm;
- (void)listDetailViewController:(ListDetailViewController *)controller didFinishEditingAlarm:(Alarm *)alarm;
@end

@interface ListDetailViewController : UITableViewController <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITextField *textField;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *doneBarButton;
@property (nonatomic, weak) id <ListDetailViewControllerDelegate> delegate;
@property (nonatomic, strong) Alarm *listToEdit;
//@property (nonatomic, strong) AlarmsDataModel *dataModel;


- (IBAction)cancel;
- (IBAction)done;

@end