//
//  shoppinglistViewController.m
//  Huisgenoten
//
//  Created by Myrthe Bil on 6/18/13.
//
//

#import "ShoppinglistViewController.h"
#import "AddItemViewController.h"
#import "editItemViewController.h"
#import "AppDelegate.h"

@interface ShoppinglistViewController ()

@end

@implementation ShoppinglistViewController

@synthesize items = _items;

#pragma mark -
#pragma mark Initialization
- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    
    if (self) {
    
    }
    
    return self;
}

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

#pragma mark -
#pragma mark View Life Cycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1];
    
    // Fetch the items from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Item"];
    self.items = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark Table View Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    
    // Check if item is bought and assign cell identifier
    static NSString *notBoughtCellIdentifier = @"NotBoughtItemCell";
    static NSString *boughtCellIdentifier = @"BoughtItemCell";
    
    NSManagedObject *item = [self.items objectAtIndex:indexPath.row];
    bool bought = [item valueForKey:@"bought"];
    NSString *cellIdentifier = bought ? boughtCellIdentifier : notBoughtCellIdentifier;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // Configure the cell...
    [cell.textLabel setText:[NSString stringWithFormat:@"%@", [item valueForKey:@"item"]]];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"€ %.2f", [[item valueForKey:@"price"] floatValue]]];
    
    return cell;
    
}


#pragma mark Table View Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark Actions
// Prepare for segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AddItemSegue"]) {
        // Initialize Add Item View Controller
        UINavigationController *navCon = segue.destinationViewController;
        AddItemViewController *addItemViewController = [navCon.viewControllers objectAtIndex:0];
        addItemViewController.itemListViewController = self;
    } else if ([[segue identifier] isEqualToString:@"EditNotBoughtItemSegue"] || [[segue identifier] isEqualToString:@"EditBoughtItemSegue"]) {
        // Initialize Edit Item View Controller
        NSManagedObject *selectedItem = [self.items objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        EditItemViewController *editItemViewController = segue.destinationViewController;
        editItemViewController.item = selectedItem;
    }
    
}

// Rearranging the table view
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSManagedObject *movedItem = [self.items objectAtIndex:fromIndexPath.row];
    [self.items removeObjectAtIndex:fromIndexPath.row];
    [self.items insertObject:movedItem atIndex:toIndexPath.row];
}

// Conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The item is re-orderable.
    return YES;
}

// Editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [context deleteObject:[self.items objectAtIndex:indexPath.row]];
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
    }
    [self.items removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - IBActions
- (void)editButtonPressed:(id)sender {
    self.editing = !self.editing;
}

- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
