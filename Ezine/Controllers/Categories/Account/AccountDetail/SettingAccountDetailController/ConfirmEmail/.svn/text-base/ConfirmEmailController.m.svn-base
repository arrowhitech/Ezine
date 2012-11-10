//
//  ConfirmEmailController.m
//  Ezine
//
//  Created by MAC on 9/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ConfirmEmailController.h"

@interface ConfirmEmailController ()

@end

@implementation ConfirmEmailController

@synthesize tsnameConfirmEmail,tspasswordConfirmEmail;
@synthesize activityIndicator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=NO;
    self.title=@"Cài đặt tài khoản";
    [self.tspasswordConfirmEmail    setDelegate:self];
    [self.tspasswordConfirmEmail    setReturnKeyType:UIReturnKeyDone];
    [self.tspasswordConfirmEmail     setSecureTextEntry:YES];
    
    [self.tsnameConfirmEmail  setDelegate:self];
    [self.tsnameConfirmEmail  setReturnKeyType:UIReturnKeyDone];
    
        
    int xPosition = (self.view.bounds.size.width / 2.0) - 50;
    int yPosition = (self.view.bounds.size.height / 2.0) - 150.0;
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(xPosition, yPosition, 100, 100)];
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [self.view addSubview:activityIndicator];

    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden=YES;
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}
#pragma mark--- action handle=====Ok=========

- (IBAction)btnCompleteButtonClick:(id)sender {
    
    
    
}
#pragma mark == handle touch anyobject hiden virtual keyboard

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    // NSLog(@"touch");
    UITouch *touch = [[event allTouches] anyObject];
    if (touch.phase==UITouchPhaseBegan) {
        [tspasswordConfirmEmail resignFirstResponder];
        [tsnameConfirmEmail resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}


#pragma mark======UITextFieldDelegate======OK============
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.tsnameConfirmEmail       resignFirstResponder];
    [self.tspasswordConfirmEmail         resignFirstResponder];
    
    return  YES;
}


/*
 * This method shows the activity indicator and
 * deactivates the table to avoid user input.
 */
- (void)showActivityIndicator {
    if (![activityIndicator isAnimating]) {
        [activityIndicator startAnimating];
    }
}

/*
 * This method hides the activity indicator
 * and enables user interaction once more.
 */
- (void)hideActivityIndicator {
    
    if ([activityIndicator isAnimating]) {
        [activityIndicator stopAnimating];
    }
    
}




@end
