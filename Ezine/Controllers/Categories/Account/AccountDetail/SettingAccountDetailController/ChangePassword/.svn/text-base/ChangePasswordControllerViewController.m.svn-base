//
//  ChangePasswordControllerViewController.m
//  Ezine
//
//  Created by MAC on 9/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ChangePasswordControllerViewController.h"

@interface ChangePasswordControllerViewController ()

@end

@implementation ChangePasswordControllerViewController
@synthesize nameChange,newpassChange,confirmpassChange,presentpassChange;

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
    [self.presentpassChange    setDelegate:self];
    [self.presentpassChange     setSecureTextEntry:YES];
    [self.presentpassChange    setReturnKeyType:UIReturnKeyDone];
    [self.newpassChange    setDelegate:self];
    [self.newpassChange     setSecureTextEntry:YES];
    [self.newpassChange    setReturnKeyType:UIReturnKeyDone];
    [self.confirmpassChange    setDelegate:self];
    [self.confirmpassChange     setSecureTextEntry:YES];
    [self.confirmpassChange    setReturnKeyType:UIReturnKeyDone];
    
    [self.nameChange  setDelegate:self];
    [self.nameChange  setReturnKeyType:UIReturnKeyDone];
   

    int xPosition = (self.view.bounds.size.width / 2.0) - 50;
    int yPosition = (self.view.bounds.size.height / 2.0) - 150.0;
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(xPosition, yPosition, 100, 100)];
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [self.view addSubview:activityIndicator];

    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden=YES;
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}
-(IBAction)btnChangeButtonClick:(id)sender{
    if ([self validateForm] == 2) {
        UIAlertView *allert = [[UIAlertView alloc] initWithTitle:@"Notice" message:@"Xác nhận mật khẩu không trùng nhau!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [allert show];
        [allert release];
    }else{
        if ([self validateForm]==1) {
            NSLog(@"Vao khong day nhi");
            [self showActivityIndicator];
            NSLog(@"Vao CMNR");
            
            int UserID=[[NSUserDefaults standardUserDefaults] integerForKey:@"userID"];
            NSString *strID = [NSString stringWithFormat:@"%d",UserID];
            NSDictionary *infor = [NSDictionary dictionaryWithObjectsAndKeys:strID,@"UserID",presentpassChange.text,@"CurPassword",newpassChange.text,@"NewPassword", nil];
            
            
            
            [XAppDelegate.serviceEngine changePass:infor onCompletion:^(NSDictionary *responseDict) {
                NSLog(@"%@",responseDict);
                [self fetchedDataforChangePass:responseDict];
            } onError:^(NSError *error) {
                
            }];

        }
    }
}
#pragma mark == handle touch anyobject hiden virtual keyboard

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    // NSLog(@"touch");
    UITouch *touch = [[event allTouches] anyObject];
    if (touch.phase==UITouchPhaseBegan) {
        [nameChange resignFirstResponder];
        [presentpassChange resignFirstResponder];
        [newpassChange resignFirstResponder];
        [confirmpassChange resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}


#pragma mark======UITextFieldDelegate======OK============
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.nameChange       resignFirstResponder];
    [self.presentpassChange         resignFirstResponder];
    [self.newpassChange       resignFirstResponder];
    [self.confirmpassChange       resignFirstResponder];
    
    return  YES;
}


-(int)validateForm{
    if ([nameChange.text isEqualToString:@""]) {
        [nameChange shakeX];
   
        return 0;
    }
    if ([presentpassChange.text isEqualToString:@""]) {
        [presentpassChange shakeX];
        
        return 0;
    }

    if ([newpassChange.text isEqualToString:@""]) {
        [newpassChange shakeX];
        
        return 0;
    }

    if ([confirmpassChange.text isEqualToString:@""]) {
        [confirmpassChange shakeX];
        
        return 0;
    }
    
    if (![newpassChange.text isEqualToString:confirmpassChange.text]) {
        
        return 2;
    }
    return 1;
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

/////FetchedData

-(void)fetchedDataforChangePass:(NSDictionary*)data{
    
    [self hideActivityIndicator];
    BOOL success=[[data objectForKey:@"Success"] boolValue];
    NSLog(@"SUCCCCCCCCCCC: %d",success);
    if (success==true) {
    
       // [self dismissModalViewControllerAnimated:YES];
        
        return;
    }else{
        NSString *message=[data objectForKey:@"Message"];
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Không thành công" message:message delegate:self cancelButtonTitle:@"done" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }

    
    
}
-(IBAction)btnCompleteButtonClick:(id)sender{

}
@end
