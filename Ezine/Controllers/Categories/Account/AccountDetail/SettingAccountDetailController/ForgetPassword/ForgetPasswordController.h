//
//  ForgetPasswordController.h
//  Ezine
//
//  Created by Hieu  on 9/5/12.
//
//

#import <UIKit/UIKit.h>
#import "UIView+I7ShakeAnimation.h"

@interface ForgetPasswordController : UIViewController<UITextFieldDelegate>{
    IBOutlet UITextField *forgetpass;
}


@property(nonatomic,retain) IBOutlet UITextField *forgetpass;
-(IBAction)btnSendButtonCLick:(id)sender;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

- (void)showActivityIndicator;
- (void)hideActivityIndicator;


@end
