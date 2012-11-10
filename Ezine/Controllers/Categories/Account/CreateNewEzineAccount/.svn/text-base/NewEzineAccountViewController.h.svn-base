//
//  NewEzineAccountViewController.h
//  Ezine
//
//  Created by MAC on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "UIView+I7ShakeAnimation.h"
#import "UserEzineModel.h"
#import "CreateUserEngine.h"

@protocol NewEzineAccountViewControllerDelegate <NSObject>
-(void)registerSuccess;
@end

@interface NewEzineAccountViewController : UIViewController<UITextFieldDelegate,UINavigationBarDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPopoverControllerDelegate>{
    
    IBOutlet UIButton *btnChooseImage;
    
    IBOutlet UITextField *tfEzineUsername;
    IBOutlet UITextField *tfEzineEmailregister;
    IBOutlet UITextField *tfEzinePassword;
    IBOutlet UITextField *tfEzineUserFullname;
    
    IBOutlet UINavigationBar *naviBar;
     UIPopoverController*	m_popoverController;
    CreateUserEngine    *_createNew;
    NSString            *_avatarBase64Code;
    id <NewEzineAccountViewControllerDelegate>delegate;
}
#pragma mark =========OK=======Property
@property(nonatomic, assign)id delegate;
@property(nonatomic,retain) IBOutlet UIButton           *btnChooseImage;

@property(nonatomic,retain) IBOutlet UITextField        *tfEzineUsername;
@property(nonatomic,retain) IBOutlet UITextField        *tfEzineEmailregister;
@property(nonatomic,retain) IBOutlet UITextField        *tfEzinePassword;
@property(nonatomic,retain) IBOutlet UITextField        *tfEzineUserFullname;

@property(nonatomic,retain) IBOutlet UINavigationBar *naviBar;

#pragma mark===========OK======Button Click event=============

- (IBAction)btnFinishedClick:(id)sender;
- (IBAction)btnExitClick:(id)sender;
-(IBAction)btnChooseImgAvatar:(id)sender;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

- (void)showActivityIndicator;
- (void)hideActivityIndicator;

-(void)fetchedDataCreateUSer:(NSDictionary*)data;
@end
