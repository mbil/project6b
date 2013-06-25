//
//  financesViewController.h
//  Huisgenoten
//
//  Created by Myrthe Bil on 6/20/13.
//
//

#import <UIKit/UIKit.h>
#import "Finances.h"

@interface financesViewController : UITableViewController

@property (strong) NSMutableArray *purchases;
@property (weak, nonatomic) IBOutlet UILabel *moneySpendLabel;
@property (nonatomic, readwrite, strong) Finances *finances;
@property (nonatomic, copy) NSString* selectedCellText;
@property (assign, nonatomic, readwrite) float price;

- (IBAction)resetSpendings:(id)sender;

- (IBAction)editButtonPressed:(id)sender;
- (IBAction)backAction:(id)sender;


@end
