//
//  ViewController.h
//  Huisgenoten
//
//  Created by Myrthe Bil & Miguel Pruijssers on 6/11/13.
//
//

#import <UIKit/UIKit.h>
#import "alarmsViewController.h"

@interface ViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *outcome;

-(IBAction)logout:(id)sender;

@end
