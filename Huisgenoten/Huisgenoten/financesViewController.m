//
//  financesViewController.m
//  Huisgenoten
//
//  Created by Myrthe Bil on 6/20/13.
//
//

#import "financesViewController.h"
#import "AppDelegate.h"

@interface financesViewController ()

@end

@implementation financesViewController

@synthesize finances=_finances;
@synthesize purchases=_purchases;
@synthesize selectedCellText=_selectedCellText;
@synthesize price=_price;

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
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.finances = [[Finances alloc] init];
    [self show];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // Fetch the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Purchase"];
    self.purchases = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark Table View Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.purchases.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *boughtCellIdentifier = @"BoughtItemCell";
    
    // Fetch Item
    NSManagedObject *purchase = [self.purchases objectAtIndex:indexPath.row];
    
    NSString *cellIdentifier = boughtCellIdentifier;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // Configure Cell
    [cell.textLabel setText:[NSString stringWithFormat:@"%@", [purchase valueForKey:@"item"]]];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"€%.2f", [[purchase valueForKey:@"price"] floatValue]]];
    
    return cell;
}




#pragma mark Table View Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}


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
- (IBAction)resetSpendings:(id)sender {
    NSInteger myValue = 0; // This is your number
    NSString *key = @"sum"; // This is a string to identify your number
    [[NSUserDefaults standardUserDefaults] setInteger:myValue forKey:key];
    self.finances.balance = [[NSUserDefaults standardUserDefaults] integerForKey:key];
    [self show];
}

- (void)editButtonPressed:(id)sender {
    self.editing = !self.editing;
}

- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)show
{
    float moneySpend = self.finances.balance;
    self.moneySpendLabel.text = [NSString stringWithFormat:@"€ %.2f", (moneySpend / 100)];
}

@end
