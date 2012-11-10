//
//  ConfirmEmailController.h
//  Ezine
//
//  Created by MAC on 9/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmEmailController : UIViewController<UITextFieldDelegate>{
    IBOutlet UITextField *tsnameConfirmEmail;
    IBOutlet UITextField *tspasswordConfirmEmail;
    
}

@property(nonatomic,retain) IBOutlet UITextField *tsnameConfirmEmail;
@property(nonatomic,retain) IBOutlet UITextField *tspasswordConfirmEmail;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

- (void)showActivityIndicator;
- (void)hideActivityIndicator;


-(IBAction)btnCompleteButtonClick:(id)sender;

@end
