//
//  alarmsViewController.m
//  Huisgenoten
//
//  Created by Myrthe Bil & Miguel Pruijssers on 6/11/13.
//
//

#import "alertsViewController.h"

@interface alertsViewController ()

@end

@implementation alertsViewController

@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// zorg dat de method wordt toegepast
- (IBAction)choiceMade:(UISegmentedControl *)sender {
    [self.delegate userDidMakeChoice:sender.selectedSegmentIndex];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
