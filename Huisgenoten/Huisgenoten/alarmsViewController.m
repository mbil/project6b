//
//  alarmsViewController.m
//  Huisgenoten
//
//  Created by Miguel Pruijssers on 14-06-13.
//
//

#import "alarmsViewController.h"
#import "AlarmItem.h"

@interface alarmsViewController ()

@end

@implementation alarmsViewController{
    NSMutableArray *alarms;
}

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

    alarms = [[NSMutableArray alloc] initWithCapacity:20];
    
    AlarmItem *item;
    
    item = [[AlarmItem alloc] init];
    item.text = @"Afval";
    item.checked = NO;
    [alarms addObject:item];
    
    item = [[AlarmItem alloc] init];
    item.text = @"Huur betalen";
    item.checked = YES;
    [alarms addObject:item];
    
    item = [[AlarmItem alloc] init];
    item.text = @"iOS leren";
    item.checked = YES;
    [alarms addObject:item];
    
    item = [[AlarmItem alloc] init];
    item.text = @"Boodschappen doen";
    item.checked = NO;
    [alarms addObject:item];
    
    item = [[AlarmItem alloc] init];
    item.text = @"Samen eten";
    item.checked = YES;
    [alarms addObject:item];
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [alarms count];
}

- (void)configureCheckmarkForCell:(UITableViewCell *)cell withAlarmItem:(AlarmItem *)item
{
    if (item.checked) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
}

- (void)configureTextForCell:(UITableViewCell *)cell withAlarmItem:(AlarmItem *)item
{
    UILabel *label = (UILabel *)[cell viewWithTag:1000];
    label.text = item.text;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"alarmItem"];
    
    AlarmItem *item = [alarms objectAtIndex:indexPath.row];
        
    [self configureTextForCell:cell withAlarmItem:item];
    [self configureCheckmarkForCell:cell withAlarmItem:item];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    AlarmItem *item = [alarms objectAtIndex:indexPath.row];
    [item toggleChecked];
    
    [self configureCheckmarkForCell:cell withAlarmItem:item];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)addAlarm
{
    int newRowIndex = [alarms count];
    
    AlarmItem *alarm = [[AlarmItem alloc] init];
    alarm.text = @"New row";
    alarm.checked = NO;
    [alarms addObject:alarm];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [alarms removeObjectAtIndex:indexPath.row];
    
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)addAlarmViewControllerDidCancel:(AddAlarmViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addAlarmViewController:(AddAlarmViewController *)controller didFinishAddingItem:(AlarmItem *)item
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AddAlarm"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        AddAlarmViewController *controller = (AddAlarmViewController *)navigationController.topViewController;
        controller.delegate = self;
    }
}

@end
