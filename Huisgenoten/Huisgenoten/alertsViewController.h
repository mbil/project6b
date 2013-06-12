//
//  alarmsViewController.h
//  Huisgenoten
//
//  Created by Myrthe Bil & Miguel Pruijssers on 6/11/13.
//
//

#import <UIKit/UIKit.h>

// protocol voor de delegate
@protocol AlertsControllerDelegate <NSObject>
- (void)userDidMakeChoice:(NSUInteger)choice;
@end

@interface alertsViewController : UIViewController
@property (nonatomic, assign) id <AlertsControllerDelegate> delegate;
-(IBAction)choiceMade:(UISegmentedControl *)sender;

@end
