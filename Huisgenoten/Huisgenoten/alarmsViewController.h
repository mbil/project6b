//
//  alarmsViewController.h
//  Huisgenoten
//
//  Created by Myrthe Bil on 6/11/13.
//
//

#import <UIKit/UIKit.h>

@protocol AlarmsControllerDelegate <NSObject>
- (void)userDidMakeChoice:(NSUInteger)choice;
@end

@interface alarmsViewController : UIViewController
@property (nonatomic, assign) id <AlarmsControllerDelegate> delegate;
-(IBAction)choiceMade:(UISegmentedControl *)sender;

@end
