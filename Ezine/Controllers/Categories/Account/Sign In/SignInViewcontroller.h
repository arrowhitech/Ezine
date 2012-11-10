//
//  SignInViewcontroller.h
//  Ezine
//
//  Created by MAC on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFKPageFlipper.h"
#import "UIView+I7ShakeAnimation.h"
#import "IASKAppSettingsViewController.h"
#import "SignInEzineEngine.h"
@protocol SignInViewcontrollerDelegate <NSObject>
-(void)Login;
@end

@interface SignInViewcontroller : UIViewController <UITextFieldDelegate>{
    id<SignInViewcontrollerDelegate>delegate;
    IBOutlet UINavigationBar*   naviBar;
    
    IBOutlet UITextField*       tfUsernameSingin;
    IBOutlet UITextField*       tfPasswdSingin;
    
    SignInEzineEngine   *_signIn;
}


- (IBAction)btnExitClick:(id)sender;
- (IBAction)btnSignInClick:(id)sender;
-(IBAction)btnHelpMe:(id)sender;
@property(nonatomic,assign) id delegate;
@property(nonatomic,retain) UINavigationBar *naviBar;

@property(nonatomic,retain) IBOutlet   UITextField*       tfUsernameSingin;
@property(nonatomic,retain) IBOutlet   UITextField*       tfPasswdSingin;

-(void)fetchedDataSignIn:(NSDictionary*)data;

@end
