//
//  SubclassConfigViewController.h
//  Huisgenoten
//
//  Created by Miguel Pruijssers on 19-06-13.
//
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SubclassConfigViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@property (nonatomic, strong) IBOutlet UILabel *welcomeLabel;

- (IBAction)logOutButtonTapAction:(id)sender;
- (IBAction)cancel:(id)sender;

@end
