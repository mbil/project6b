//
//  ViewController.h
//  Huisgenoten
//
//  Created by Myrthe Bil & Miguel Pruijssers on 6/11/13.
//
//

#import <UIKit/UIKit.h>
#import "alertsViewController.h"

@interface ViewController : UIViewController
<AlertsControllerDelegate>

@property (nonatomic, weak) IBOutlet UILabel *outcome;

@end
