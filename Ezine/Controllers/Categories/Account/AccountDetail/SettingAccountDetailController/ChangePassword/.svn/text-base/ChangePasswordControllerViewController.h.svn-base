//
//  ChangePasswordControllerViewController.h
//  Ezine
//
//  Created by MAC on 9/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+I7ShakeAnimation.h"
@interface ChangePasswordControllerViewController : UIViewController<UITextFieldDelegate>{
    IBOutlet UITextField *nameChange;
    IBOutlet UITextField *newpassChange;
    IBOutlet UITextField *confirmpassChange;
    IBOutlet UITextField *presentpassChange;
}
-(IBAction)btnChangeButtonClick:(id)sender;
-(int) validateForm;


@property(nonatomic,retain)  IBOutlet UITextField *nameChange;
@property(nonatomic,retain)  IBOutlet UITextField *newpassChange;
@property(nonatomic,retain)  IBOutlet UITextField *confirmpassChange;
@property(nonatomic,retain)  IBOutlet UITextField *presentpassChange;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
- (void)showActivityIndicator;
- (void)hideActivityIndicator;

-(IBAction)btnCompleteButtonClick:(id)sender;

-(void)fetchedDataforChangePass:(NSDictionary*)data;

@end
