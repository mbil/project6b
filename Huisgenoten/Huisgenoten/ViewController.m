//
//  ViewController.m
//  Huisgenoten
//
//  Created by Myrthe Bil & Miguel Pruijssers on 6/11/13.
//
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize outcome;

-(void)viewWillAppear:(BOOL)animated
{
    //self.navigationItem.hidesBackButton = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//// dit is een test van een delegate, zo werkt het dus Deel#1
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"toAlerts"]) {
//        alarmsViewController *alertsVC =
//        (alarmsViewController *) segue.destinationViewController;
//        [alertsVC setDelegate:self];
//    }
//}

// test delegate Deel#2
- (void)userDidMakeChoice:(NSUInteger)choice
{
    switch (choice) {
        case 0:
            self.outcome.text = @"One chosen";
            break;
        case 1:
            self.outcome.text = @"Two chosen";
            break;
            
        default:
            break;
    }
}

//- (IBAction)logout:(id)sender {
//    [self.navigationController popViewControllerAnimated:YES];
//    //[self presentViewController: animated:<#(BOOL)#> completion:<#^(void)completion#>
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

@end
