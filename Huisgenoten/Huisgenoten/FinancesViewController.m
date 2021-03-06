//
//  FinancesViewController.m
//  Huisgenoten
//
//  Created by Myrthe Bil on 6/20/13.
//
//

#import "FinancesViewController.h"
#import "AppDelegate.h"

@interface FinancesViewController ()

@end

@implementation FinancesViewController

//@synthesize finances=_finances;
//@synthesize purchases=_purchases;
//@synthesize selectedCellText=_selectedCellText;
//@synthesize price=_price;
//@synthesize moneySpendLabel=_moneySpendLabel;

//#pragma mark -
#pragma mark Initialization
//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    
//    if (self) {
//        
//    }
//    
//    return self;
//}


- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    
    return context;
}

#pragma mark View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.tableHeaderView = [[UIView alloc] init];
    self.finances = [[Finances alloc] init];
    [self show];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1];

    // Fetch the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Purchase"];
    self.purchases = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    [self.tableView reloadData];
}

#pragma mark Table View Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.purchases.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *boughtCellIdentifier = @"BoughtItemCell";
    
    // Fetch Item
    NSManagedObject *purchase = [self.purchases objectAtIndex:indexPath.row];
    
    NSString *cellIdentifier = boughtCellIdentifier;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    
    // Configure Cell
    if ([purchase valueForKey:@"item"] != NULL) {
        [cell.textLabel setText:[NSString stringWithFormat:@"%@", [purchase valueForKey:@"item"]]];
    } else {
        [cell.textLabel setText:@""];
    }
    
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"€%.2f", [[purchase valueForKey:@"price"] floatValue]]];
    
    return cell;
}

#pragma mark Table View Delegate Methods
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return NO;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // make sure the price is abstracted from total balance
    NSManagedObject *purchase = [self.purchases objectAtIndex:indexPath.row];
    self.price = [[purchase valueForKey:@"price"] floatValue];
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [context deleteObject:[self.purchases objectAtIndex:indexPath.row]];
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
    }
    
    // money spended minus price of deleted object
    NSInteger myValue = self.finances.balance - (self.price * 100); // This is your number
    NSString *key = @"sum"; // This is a string to identify your number
    [[NSUserDefaults standardUserDefaults] setInteger:myValue forKey:key];
    self.finances.balance = [[NSUserDefaults standardUserDefaults] integerForKey:key];
    [self show];
    
    // remove object
    [self.purchases removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - IBActions
- (IBAction)resetSpendings:(id)sender
{
    NSInteger myValue = 0; // This is your number
    NSString *key = @"sum"; // This is a string to identify your number
    [[NSUserDefaults standardUserDefaults] setInteger:myValue forKey:key];
    self.finances.balance = [[NSUserDefaults standardUserDefaults] integerForKey:key];

    
    NSFetchRequest *allPurchases = [[NSFetchRequest alloc] init];
    NSFetchRequest *allItems = [[NSFetchRequest alloc] init];
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    [allPurchases setEntity:[NSEntityDescription entityForName:@"Purchase" inManagedObjectContext:managedObjectContext]];
    [allPurchases setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    [allItems setEntity:[NSEntityDescription entityForName:@"Item" inManagedObjectContext:managedObjectContext]];
    [allItems setIncludesPropertyValues:YES];
    
    NSError *error = nil;
    NSArray *items = [managedObjectContext executeFetchRequest:allItems error:&error];
    for (NSManagedObject *item in items) {
        bool bought = [item valueForKey:@"bought"];
        if (bought == YES)
        {
            [item setValue:NO forKey:@"bought"];
        }
    [UIView transitionWithView:self.tableView
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^(void) {
                        [self.tableView reloadData];
                    } completion:NULL];
        
    }
    
    
    NSArray *purchases = [managedObjectContext executeFetchRequest:allPurchases error:&error];
    //error handling goes here
    for (NSManagedObject *purchase in purchases) {
        [managedObjectContext deleteObject:purchase];
    }
    NSError *saveError = nil;
    [managedObjectContext save:&saveError];
    
    [self.tableView reloadData];
    
    [self show];
}

- (void)editButtonPressed:(id)sender
{
    self.editing = !self.editing;
}

- (IBAction)backAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)show
{
    float moneySpend = self.finances.balance;
    self.moneySpendLabel.text = [NSString stringWithFormat:@"€ %.2f", (moneySpend / 100)];
}

@end
