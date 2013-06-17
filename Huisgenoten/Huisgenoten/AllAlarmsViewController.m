//
//  AllAlarmsViewController.m
//  Huisgenoten
//
//  Created by Miguel Pruijssers on 16-06-13.
//
//

#import "AllAlarmsViewController.h"
#import "Alarm.h"
#import "alarmsViewController.h"
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

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.navigationController.delegate = self;
    
    int index = [self.dataModel indexOfSelectedAlarm];
    if (index >= 0 && index < [self.dataModel.lists count]) {
        Alarm *alarm = [self.dataModel.lists objectAtIndex:index];
        [self performSegueWithIdentifier:@"ShowAlarm" sender:alarm];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dataModel.lists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Alarm *alarm = [self.dataModel.lists objectAtIndex:indexPath.row];
    
    cell.textLabel.text = alarm.name;
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d Resterend", [alarm countUncheckedItems]];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.dataModel setIndexOfSelectedAlarm:indexPath.row];
    
    Alarm *alarm = [self.dataModel.lists objectAtIndex:indexPath.row];
    
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
        alarmsViewController *controller = segue.destinationViewController;
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

- (void)listDetailViewController:(ListDetailViewController *)controller didFinishAddingAlarm:(Alarm *)alarm
{
    int newRowIndex = [self.dataModel.lists count];
    [self.dataModel.lists addObject:alarm];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.dataModel saveAlarms];

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)listDetailViewController:(ListDetailViewController *)controller didFinishEditingAlarm:(Alarm *)alarm
{
    int index = [self.dataModel.lists indexOfObject:alarm];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.text = alarm.name;
    [self.dataModel saveAlarms];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.dataModel.lists removeObjectAtIndex:indexPath.row];

    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (IBAction)backAction:(id)sender {
    [self.dataModel saveAlarms];

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self) {
        [self.dataModel setIndexOfSelectedAlarm:-1];
    }
}
@end
