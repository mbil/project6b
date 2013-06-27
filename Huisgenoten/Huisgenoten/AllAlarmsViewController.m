//
//  AllAlarmsViewController.m
//  Huisgenoten
//
//  Created by Miguel Pruijssers on 16-06-13.
//
//

#import "AllAlarmsViewController.h"
#import "Alarm.h"
#import "AlarmsViewController.h"
#import "AlarmItem.h"
#import "AlarmsDataModel.h"

@interface AllAlarmsViewController ()

@end

@implementation AllAlarmsViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        self.dataModel = [[AlarmsDataModel alloc] init];
    }
        
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1];

    self.tableView.tableFooterView = [[UIView alloc] init];

    [self.dataModel saveAlarms];
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.navigationController.delegate = self;
    
    // Directly make new alarm, when none are present
    int index = [self.dataModel indexOfSelectedAlarm];
    if (index >= 0 && index < [self.dataModel.lists count]) {
        AlarmsDataModel *alarm = [self.dataModel.lists objectAtIndex:index];
        [self performSegueWithIdentifier:@"ShowAlarm" sender:alarm];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataModel.lists count];
}

// Cell layout
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    Alarm *alarm = [self.dataModel.lists objectAtIndex:indexPath.row];
    
    cell.textLabel.text = alarm.name;
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    int count = [alarm countUncheckedItems];
    if ([alarm.items count] == 0) {
        cell.detailTextLabel.text = @"(Geen Items)";
    } else if (count == 0) {
        cell.detailTextLabel.text = @"Allemaal voltooid!";
    } else {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d Resterend", count];
    }
    
    cell.imageView.image = [UIImage imageNamed:alarm.iconName];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.dataModel setIndexOfSelectedAlarm:indexPath.row];
    
    AlarmsDataModel *alarm = [self.dataModel.lists objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"ShowAlarm" sender:alarm];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"ListNavigationController"];
    
    ListDetailViewController *controller = (ListDetailViewController *)navigationController.topViewController;
    controller.delegate = self;
    
    Alarm *alarm = [self.dataModel.lists objectAtIndex:indexPath.row];
    controller.listToEdit = alarm;
    
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowAlarm"]) {
        AlarmsViewController *controller = segue.destinationViewController;
        controller.alarm = sender;
    }
    else if ([segue.identifier isEqualToString:@"AddList"])
    {
        UINavigationController *navigationController = segue.destinationViewController;
        ListDetailViewController *controller = (ListDetailViewController *)navigationController.topViewController;
        controller.delegate = self;
        controller.listToEdit = nil;
    }
}

- (void)listDetailViewControllerDidCancel:(ListDetailViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Add alarm group
- (void)listDetailViewController:(ListDetailViewController *)controller didFinishAddingAlarm:(Alarm *)alarm
{
    [self.dataModel.lists addObject:alarm];
    [self.dataModel sortAlarms];
    [self.tableView reloadData];
    [self.dataModel saveAlarms];

    [self dismissViewControllerAnimated:YES completion:nil];
}

// Edit alarm group
- (void)listDetailViewController:(ListDetailViewController *)controller didFinishEditingAlarm:(Alarm *)alarm
{
    [self.dataModel sortAlarms];
    [self.tableView reloadData];
    [self.dataModel saveAlarms];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Remove alarm group
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.dataModel.lists removeObjectAtIndex:indexPath.row];

    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self) {
        [self.dataModel setIndexOfSelectedAlarm:-1];
    }
}

@end
