//
//  EzineAccountViewController.h
//  Ezine
//
//  Created by MAC on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AFKPageFlipper.h"
#import "SignInViewcontroller.h"
#import "NewEzineAccountViewController.h"
#import "UIViewController+MJPopupViewController.h"

@protocol EzineAccountViewControllerDelegate <NSObject>
-(void)LoginSuccess;
@end

@interface EzineAccountViewController : UIViewController<SignInViewcontrollerDelegate,NewEzineAccountViewControllerDelegate>{
    id <EzineAccountViewControllerDelegate> delegate;
    
}
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, assign) id delegate;
-(void)changedLandScape;
- (IBAction)btnDetailClick:(id)sender;
- (IBAction)btnCreateAccountClick:(id)sender;
- (IBAction)btnSignInClick:(id)sender;

- (void)showActivityIndicator;
- (void)hideActivityIndicator;
@end
