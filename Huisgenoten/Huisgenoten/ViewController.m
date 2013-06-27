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

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}

- (IBAction)infoButton:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Druk op:\n\n - de wekker om een alarm te zetten\n\n - de koelkast om een boodschappenlijstje samen te stellen\n\n - het spaarvarkentje om je uitgaven te checken." delegate:nil cancelButtonTitle:@"Okey" otherButtonTitles:nil, nil];
    [alert show];
}

@end
