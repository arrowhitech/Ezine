//
//  SignInViewcontroller.m
//  Ezine
//
//  Created by MAC on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SignInViewcontroller.h"
#import "UserEzineModel.h"
#import "IASKSpecifier.h"
#import "IASKSettingsReader.h"
#import "MyLauncherView.h"

@interface SignInViewcontroller ()

@end

@implementation SignInViewcontroller

@synthesize naviBar;
@synthesize tfPasswdSingin;
@synthesize tfUsernameSingin;
@synthesize delegate;

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
    
    [self.tfPasswdSingin    setDelegate:self];
    [self.tfPasswdSingin     setSecureTextEntry:YES];
    [self.tfPasswdSingin    setReturnKeyType:UIReturnKeyDone];
    
    [self.tfUsernameSingin  setDelegate:self];
    [self.tfUsernameSingin  setReturnKeyType:UIReturnKeyDone];
    
    _signIn=[[SignInEzineEngine alloc] initWithHostName:@"api.ezine.vn" customHeaderFields:nil];

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft||toInterfaceOrientation==UIInterfaceOrientationLandscapeRight||toInterfaceOrientation==UIInterfaceOrientationPortrait||toInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown);
}
#pragma mark--- action handle=====Ok=========

- (IBAction)btnExitClick:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)btnSignInClick:(id)sender {
    
    if ([tfUsernameSingin.text isEqualToString:@""]||[tfPasswdSingin.text isEqualToString:@""]) {
        if ([tfUsernameSingin.text isEqualToString:@""]) {
            [tfUsernameSingin shakeX];
        }else {
            [tfPasswdSingin shakeX];
        }
        
    }else{
        [self.tfUsernameSingin resignFirstResponder];
        [_signIn SignInEzineUSerName:tfUsernameSingin.text Password:tfPasswdSingin.text onCompletion:^(NSDictionary* images) {
            NSLog(@"result=====  %@",images);
            [self fetchedDataSignIn:images];
        } onError:^(NSError* error) {
            
        }];

    }
    
}

-(IBAction)btnHelpMe:(id)sender{
    
    
    
}

#pragma mark == handle touch anyobject hiden virtual keyboard

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    // NSLog(@"touch");
    UITouch *touch = [[event allTouches] anyObject];
    if (touch.phase==UITouchPhaseBegan) {
        [tfUsernameSingin resignFirstResponder];
        [tfUsernameSingin resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}


#pragma mark======UITextFieldDelegate======OK============
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.tfUsernameSingin       resignFirstResponder];
    [self.tfPasswdSingin         resignFirstResponder];
    
    return  YES;
}
#pragma mark------
-(void)fetchedDataSignIn:(NSDictionary*)data{
    int userID=[[data objectForKey:@"UserID"] intValue];
    if (userID>0) {
        [[NSUserDefaults standardUserDefaults] setInteger:userID forKey:@"userID"];
        NSString *userName=[data objectForKey:@"UserName"];
        NSString *avatar=[data objectForKey:@"Avatar"];
        NSString *sessionID=[data objectForKey:@"SessionId"];
        [[NSUserDefaults standardUserDefaults] setObject:sessionID forKey:@"EzineAccountSessionId"];
        [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"EzineAccountName"];
        [[NSUserDefaults standardUserDefaults] setObject:avatar forKey:@"EzineAccountAvatar"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:userID] forKey:@"EzineAccountID"];
        
        NSDictionary *header=[[NSDictionary alloc] initWithObjectsAndKeys:sessionID,@"ASP.NET_SessionId", nil];
        [XAppDelegate.serviceEngine release];
        XAppDelegate.serviceEngine =Nil;
        XAppDelegate.serviceEngine = [[ServiceEngine alloc] initWithHostName:@"api.ezine.vn" customHeaderFields:header];
        [XAppDelegate.serviceEngine useCache];
        
        NSLog(@"user name: %@ \n avatar: %@",userName,avatar);
//        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"signIn Success" message:[NSString stringWithFormat:@"username: %@\n userID: %d \n AvatarURL: %@",userName,userID,avatar] delegate:self cancelButtonTitle:@"done" otherButtonTitles: nil];
//        [alert show];
//        [alert release];
       // [self dismissModalViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:KDidLoginEzineNotification object:self userInfo:nil];
            

            [[NSNotificationCenter defaultCenter] postNotificationName:KDidReloadSiteNotification object:self userInfo:nil];

            if (self.delegate) {
                [self.delegate Login];
            }
        }];
    
    }else{
        NSString *message=[data objectForKey:@"Message"];
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"SignIn error" message:message delegate:self cancelButtonTitle:@"done" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
}
@end
