//
//  AlarmDetailViewController.m
//  Huisgenoten
//
//  Created by Miguel Pruijssers on 15-06-13.
//
//

#import "AlarmDetailViewController.h"
#import "AlarmItem.h"

@interface AlarmDetailViewController ()

@end

@implementation AlarmDetailViewController

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

    if (self.alarmToEdit != nil) {
        self.title = @"Edit Alarm";
        self.textField.text = self.alarmToEdit.text;
        self.doneBarButton.enabled = YES;
    }
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
    [self.delegate alarmDetailViewControllerDidCancel:self];
}

- (IBAction)done
{
    if (self.alarmToEdit == nil) {
        AlarmItem *item = [[AlarmItem alloc] init];
        item.text = self.textField.text;
        item.checked = NO;
    
        [self.delegate alarmDetailViewController:self didFinishAddingItem:item];
    }
    else {
        self.alarmToEdit.text = self.textField.text;
        [self.delegate alarmDetailViewController:self didFinishEditingItem:self.alarmToEdit];
    }
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
