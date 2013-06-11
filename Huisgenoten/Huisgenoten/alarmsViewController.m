//
//  alarmsViewController.m
//  Huisgenoten
//
//  Created by Myrthe Bil on 6/11/13.
//
//

#import "alarmsViewController.h"

@interface alarmsViewController ()

@end

@implementation alarmsViewController

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

- (IBAction)choiceMade:(UISegmentedControl *)sender {
    [self.delegate userDidMakeChoice:sender.selectedSegmentIndex];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
