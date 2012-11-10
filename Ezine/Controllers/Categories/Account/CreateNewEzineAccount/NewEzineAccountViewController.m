//
//  NewEzineAccountViewController.m
//  Ezine
//
//  Created by MAC on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NewEzineAccountViewController.h"
#import "UserEzineModel.h"

@interface NewEzineAccountViewController ()

@end

@implementation NewEzineAccountViewController

@synthesize tfEzinePassword;
@synthesize tfEzineUsername;
@synthesize tfEzineEmailregister;
@synthesize tfEzineUserFullname;
@synthesize naviBar;
@synthesize activityIndicator;
@synthesize delegate;
@synthesize btnChooseImage;

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
    
    self.tfEzineUsername.delegate =self;
    [self.tfEzineUsername setReturnKeyType:UIReturnKeyDone];
    
    self.tfEzineUserFullname.delegate =self;
    [self.tfEzineUserFullname setReturnKeyType:UIReturnKeyDone];
    
    [self.tfEzinePassword setDelegate:self];
    [self.tfEzinePassword setSecureTextEntry:YES];
    [self.tfEzinePassword setReturnKeyType:UIReturnKeyDone];
    
    [self.tfEzineEmailregister setDelegate:self];
    [self.tfEzineEmailregister setReturnKeyType:UIReturnKeyDone];
    _avatarBase64Code=nil;
    _createNew=[[CreateUserEngine alloc] initWithHostName:@"api.ezine.vn" customHeaderFields:nil];
    int xPosition = (self.view.bounds.size.width / 2.0) - 50;
    int yPosition = (self.view.bounds.size.height / 2.0) - 150.0;
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(xPosition, yPosition, 100, 100)];
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [self.view addSubview:activityIndicator];
    

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
//    [btCancel setBackgroundColor:[UIColor redColor]];
    
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft||toInterfaceOrientation==UIInterfaceOrientationLandscapeRight||toInterfaceOrientation==UIInterfaceOrientationPortrait||toInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown);
}
#pragma mark------- action handle
- (IBAction)btnFinishedClick:(id)sender {
    
    if ([tfEzineEmailregister.text isEqualToString:@""] || [tfEzinePassword.text isEqualToString:@""]||[tfEzineUserFullname.text isEqualToString:@""]||[tfEzineUsername.text isEqualToString:@""]) {
        if ([tfEzineUsername.text isEqualToString:@""]) {
            [tfEzineUsername shakeX];  
        }else{
            if ([tfEzinePassword.text isEqualToString:@""]) {
                [tfEzinePassword shakeX];
            }else {
                if ([tfEzineEmailregister.text isEqualToString:@""]) {
                    [tfEzineEmailregister shakeX];
                }else {
                    [tfEzineUserFullname shakeX];
                }
            }
            
        }
    }
    [self showActivityIndicator];
    UserEzineModel *userInfo =[[UserEzineModel alloc]initWithUsernameEzin:self.tfEzineUsername.text passWordEzin:self.tfEzinePassword.text emailEzineRegister:self.tfEzineEmailregister.text fullNameEzine:self.tfEzineUserFullname.text andImageAvatar:nil ];
    NSLog(@"Info:%@",userInfo);
    NSLog(@"thong tin:%@%@%@%@",tfEzineUsername.text,tfEzinePassword.text,tfEzineEmailregister.text,tfEzineUserFullname.text);
     
    [_createNew CreateUserWithUSerName:tfEzineUsername.text Password:tfEzinePassword.text FullName:tfEzineUserFullname.text Email:tfEzineEmailregister.text AvatarFileName:@"image.jpg" AvatarBase64Code:_avatarBase64Code onCompletion:^(NSDictionary* images) {
        NSLog(@"result=====  %@",images);
        [self fetchedDataCreateUSer:images];
    } onError:^(NSError* error) {
        
    }];


}

- (IBAction)btnExitClick:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction)btnChooseImgAvatar:(id)sender{
   

    UIImagePickerController* pickerController = [[[UIImagePickerController alloc] init] autorelease];
	pickerController.delegate = self;
    pickerController.navigationBarHidden = YES;
    pickerController.toolbarHidden = YES;
    pickerController.wantsFullScreenLayout=YES;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
		pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        if (m_popoverController) {
            [m_popoverController release];
        }
			m_popoverController = [[UIPopoverController alloc] initWithContentViewController:pickerController] ;
			m_popoverController.delegate = self;
			[m_popoverController presentPopoverFromRect:CGRectMake(0, 0, 200, 800)
												 inView:self.view
							   permittedArrowDirections:UIPopoverArrowDirectionAny
											   animated:YES];
    
    
    }
}

#pragma mark == handle touch anyobject hiden virtual keyboard

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
   // NSLog(@"touch");
    UITouch *touch = [[event allTouches] anyObject];
    if (touch.phase==UITouchPhaseBegan) {
        [tfEzineEmailregister resignFirstResponder];
        [tfEzinePassword resignFirstResponder];
        [tfEzineUserFullname resignFirstResponder];
        [tfEzineUsername resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}


#pragma mark======UITextFieldDelegate======OK============
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.tfEzineUsername       resignFirstResponder];
    [self.tfEzineUserFullname   resignFirstResponder];
    [self.tfEzinePassword       resignFirstResponder];
    [self.tfEzineEmailregister   resignFirstResponder];
    return  YES;
}

#pragma mark---
-(NSString *)getStringFromImage:(UIImage *)image{
	if(image){
		NSData *dataObj = UIImagePNGRepresentation(image);
		return [dataObj base64EncodedString];
	} else {
		return @"";
	}
}
#pragma mark---- 
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	
		if(m_popoverController != nil)
        {
			[m_popoverController dismissPopoverAnimated:YES];
			m_popoverController = nil;
		}
    [NSTimer scheduledTimerWithTimeInterval: 0.5f
                                     target: self
                                   selector: @selector(goManagerImageAfterPick:)
                                   userInfo: info
                                    repeats: NO];

       // [self dismissModalViewControllerAnimated:YES];
	
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
        if(m_popoverController != nil) {
        [m_popoverController dismissPopoverAnimated:YES];
        m_popoverController = nil;
		}
}

-(void)goManagerImageAfterPick:(NSTimer*)timer {
    NSDictionary *info = timer.userInfo;
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:@"public.image"]) {
        UIImage *original = [info objectForKey:UIImagePickerControllerOriginalImage];
        [btnChooseImage setImage:original forState:UIControlStateNormal];
        _avatarBase64Code =[self getStringFromImage:original];
    }
    
}
#pragma mark--- fetchedDataCreateUSer
-(void)fetchedDataCreateUSer:(NSDictionary*)data{
    [self hideActivityIndicator];
    int userID=[[data objectForKey:@"UserID"] intValue];
    NSLog(@"userid: %d",userID);
    if (userID>0) {
        [[NSUserDefaults standardUserDefaults] setInteger:userID forKey:@"userID"];
        NSString *username=[data objectForKey:@"UserName"];
        NSString  *avatar=[data objectForKey:@"Avatar"];
        
        NSLog(@"username: %@ \n Avatar: %@",username,avatar);
        [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"EzineAccountName"];
        [[NSUserDefaults standardUserDefaults] setObject:avatar forKey:@"EzineAccountAvatar"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:userID] forKey:@"EzineAccountID"];
        [[self delegate] registerSuccess];
        [self dismissModalViewControllerAnimated:YES];
    }else{
        NSString *message=[data objectForKey:@"Message"];
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Can not register" message:message delegate:self cancelButtonTitle:@"done" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
}
#pragma mark---ActivityIndicator

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
