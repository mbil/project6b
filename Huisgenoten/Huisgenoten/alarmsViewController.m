//
//  alarmsViewController.m
//  Huisgenoten
//
//  Created by Miguel Pruijssers on 14-06-13.
//
//

#import "alarmsViewController.h"
#import "AlarmItem.h"
#import "Alarm.h"

@interface alarmsViewController ()

@end

@implementation alarmsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title  =self.alarm.name;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.alarm.items count];
}

- (void)configureCheckmarkForCell:(UITableViewCell *)cell withAlarmItem:(AlarmItem *)item
{
    UILabel *label = (UILabel *)[cell viewWithTag:1001];
    
    if (item.checked) {
        label.text = @"√";
    }
    else {
        label.text = @"";
    }
}

- (void)configureTextForCell:(UITableViewCell *)cell withAlarmItem:(AlarmItem *)item
{
    UILabel *label = (UILabel *)[cell viewWithTag:1000];
    label.text = item.text;
}

- (void)configureDueDateForCell:(UITableViewCell *)cell withAlarmItem:(AlarmItem *)item
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *date = [dateFormatter stringFromDate:item.dueDate];
    
    UILabel *label = (UILabel *)[cell viewWithTag:1002];
    label.text = [NSString stringWithFormat:@"%@", date];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AlarmItem"];
    
    AlarmItem *item = [self.alarm.items objectAtIndex:indexPath.row];

    [self configureTextForCell:cell withAlarmItem:item];
    [self configureCheckmarkForCell:cell withAlarmItem:item];
    if (item.shouldRemind == YES) {
        [self configureDueDateForCell:cell withAlarmItem:item];
    }
    //[self configureDueDateForCell:cell withAlarmItem:item];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    AlarmItem *item = [self.alarm.items objectAtIndex:indexPath.row];
    [item toggleChecked];
    
    [self configureCheckmarkForCell:cell withAlarmItem:item];
        
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.alarm.items removeObjectAtIndex:indexPath.row];
        
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    AlarmItem *item = [self.alarm.items objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"EditAlarm" sender:item];
}

- (void)alarmDetailViewControllerDidCancel:(AlarmDetailViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)alarmDetailViewController:(AlarmDetailViewController *)controller didFinishAddingItem:(AlarmItem *)item
{
    int newRowIndex = [self.alarm.items count];
    [self.alarm.items addObject:item];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self.tableView reloadData];

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AddAlarm"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        AlarmDetailViewController *controller = (AlarmDetailViewController *)navigationController.topViewController;
        controller.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"EditAlarm"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        AlarmDetailViewController *controller = (AlarmDetailViewController *)navigationController.topViewController;
        controller.delegate = self;
        controller.alarmToEdit = sender;
    }
}

- (void)alarmDetailViewController:(AlarmDetailViewController *)controller didFinishEditingItem:(AlarmItem *)item
{
    int index = [self.alarm.items indexOfObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [self configureTextForCell:cell withAlarmItem:item];
    
    [self.tableView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
