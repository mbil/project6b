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

- (NSString *)documentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

- (NSString *)dataFilePath
{
    return [[self documentsDirectory] stringByAppendingPathComponent:@"Alarms.plist"];
}

- (void)saveAlarmItems
{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:alarms forKey:@"AlarmItems"];
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
}

- (void)loadAlarmItems
{
    NSString *path = [self dataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        alarms = [unarchiver decodeObjectForKey:@"AlarmItems"];
        [unarchiver finishDecoding];
    }
    else
    {
        alarms = [[NSMutableArray alloc] initWithCapacity:20];
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        [self loadAlarmItems];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AlarmItem"];
    
    AlarmItem *item = [alarms objectAtIndex:indexPath.row];
        
    [self configureTextForCell:cell withAlarmItem:item];
    [self configureCheckmarkForCell:cell withAlarmItem:item];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    AlarmItem *item = [alarms objectAtIndex:indexPath.row];
    [item toggleChecked];
    
    [self configureCheckmarkForCell:cell withAlarmItem:item];
    
    [self saveAlarmItems];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [alarms removeObjectAtIndex:indexPath.row];
    
    [self saveAlarmItems];
    
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    AlarmItem *item = [alarms objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"EditAlarm" sender:item];
}

- (void)alarmDetailViewControllerDidCancel:(AlarmDetailViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)alarmDetailViewController:(AlarmDetailViewController *)controller didFinishAddingItem:(AlarmItem *)item
{
    int newRowIndex = [alarms count];
    [alarms addObject:item];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self saveAlarmItems];
    
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
    int index = [alarms indexOfObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [self configureTextForCell:cell withAlarmItem:item];
    
    [self saveAlarmItems];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
