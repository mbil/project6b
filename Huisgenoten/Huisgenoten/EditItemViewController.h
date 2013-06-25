//
//  EditItemViewController.h
//  Huisgenoten
//
//  Created by Myrthe Bil on 6/19/13.
//
//

#import <UIKit/UIKit.h>
#import "Finances.h"
@class Shoppinglist;

@interface EditItemViewController : UITableViewController <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *nameField;
@property (nonatomic, weak) IBOutlet UITextField *priceField;
@property (nonatomic, weak) IBOutlet UISwitch *boughtSwitch;
@property (strong) NSManagedObject *item;
@property (strong) NSManagedObject *purchase;
@property (nonatomic, readwrite, strong) Finances *finances;
@property (assign, nonatomic, readwrite) float price;

- (IBAction)itemDataChanged:(id)sender;
- (IBAction)itemBought:(id)sender;
- (IBAction)addToFinances:(id)sender;

@end
