//
//  shoppinglistViewController.h
//  Huisgenoten
//
//  Created by Myrthe Bil on 6/18/13.
//
//

#import <UIKit/UIKit.h>
#import "AddItemViewController.h"

@interface ShoppinglistViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *items;

- (IBAction)backAction:(id)sender;

@end
