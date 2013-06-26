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
{
    NSDate *dueDate;
}

- (void)updateDueDateLabel
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    self.dueDateLabel.text = [formatter stringFromDate:dueDate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (self.alarmToEdit != nil) {
        self.title = @"Wijzig Alarm";
        self.textField.text = self.alarmToEdit.text;
        self.doneBarButton.enabled = YES;
        self.switchControl.on = self.alarmToEdit.shouldRemind;
        dueDate = self.alarmToEdit.dueDate;
    } else {
        self.switchControl.on = NO;
        dueDate = [NSDate date];
    }
    
    [self updateDueDateLabel];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.textField becomeFirstResponder];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PickDate"]) {
        DatePickerViewController *controller = segue.destinationViewController;
        controller.delegate = self;
        controller.date = dueDate;
    }
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
        item.shouldRemind = self.switchControl.on;
        item.dueDate = dueDate;
        [item scheduleNotification];
    
        [self.delegate alarmDetailViewController:self didFinishAddingItem:item];
    } else {
        self.alarmToEdit.text = self.textField.text;
        self.alarmToEdit.shouldRemind = self.switchControl.on;
        self.alarmToEdit.dueDate = dueDate;
        [self.alarmToEdit scheduleNotification];
        
        [self.delegate alarmDetailViewController:self didFinishEditingItem:self.alarmToEdit];
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        return indexPath;
    } else {
        return nil;
    }
}

// Enable done button when text is entered
- (BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newText = [theTextField.text stringByReplacingCharactersInRange:range withString:string];
    self.doneBarButton.enabled = ([newText length] > 0);
    
    return YES;
}

- (void)datePickerDidCancel:(DatePickerViewController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)datePicker:(DatePickerViewController *)picker didPickDate:(NSDate *)date
{
    dueDate = date;
    [self updateDueDateLabel];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
