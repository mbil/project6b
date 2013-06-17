//
//  facebookViewController.m
//  Huisgenoten
//
//  Created by Myrthe Bil & Miguel Pruijssers on 6/11/13.
//
//

#import "loginViewController.h"

@interface loginViewController ()

@end

@implementation loginViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
