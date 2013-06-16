//
//  ListDetailViewController.h
//  Huisgenoten
//
//  Created by Miguel Pruijssers on 16-06-13.
//
//

#import <UIKit/UIKit.h>

@class ListDetailViewController;
@class Alarm;

@protocol ListDetailViewControllerDelegate <NSObject>
- (void)listDetailViewControllerDidCancel:(ListDetailViewController *)controller;
- (void)listDetailViewController:(ListDetailViewController *)controller didFinishAddingChecklist:(Alarm *)alarm;
- (void)listDetailViewController:(ListDetailViewController *)controller didFinishEditingChecklist:(Alarm *)alarm;
@end

@interface ListDetailViewController : UITableViewController <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITextField *textField;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *doneBarButton;
@property (nonatomic, weak) id <ListDetailViewControllerDelegate> delegate;
@property (nonatomic, strong) Alarm *listToEdit;

- (IBAction)cancel;
- (IBAction)done;

@end