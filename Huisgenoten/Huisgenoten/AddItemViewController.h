//
//  addItemViewController.h
//  Huisgenoten
//
//  Created by Myrthe Bil on 6/18/13.
//
//

#import <UIKit/UIKit.h>

@class ShoppinglistViewController;

@interface AddItemViewController : UITableViewController <UITextFieldDelegate>

- (IBAction)cancelButtonPressed:(id)sender;
- (IBAction)doneButtonPressed:(id)sender;

@property (nonatomic, weak) IBOutlet UITextField *nameField;

@property (nonatomic, strong) ShoppinglistViewController *itemListViewController;

@end
