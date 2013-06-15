//
//  AddAlarmViewController.m
//  Huisgenoten
//
//  Created by Miguel Pruijssers on 15-06-13.
//
//

#import "AddAlarmViewController.h"
#import "AlarmItem.h"

@interface AddAlarmViewController ()

@end

@implementation AddAlarmViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.textField becomeFirstResponder];
}

- (IBAction)cancel
{
    [self.delegate addAlarmViewControllerDidCancel:self];
}

- (IBAction)done
{
    AlarmItem *item = [[AlarmItem alloc] init];
    item.text = self.textField.text;
    item.checked = NO;
    
    [self.delegate addAlarmViewController:self didFinishAddingItem:item];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newText = [theTextField.text stringByReplacingCharactersInRange:range withString:string];
    self.doneBarButton.enabled = ([newText length] > 0);
    
    return YES;
}

@end
