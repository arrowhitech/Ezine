//
//  EzineAccountViewController.m
//  Ezine
//
//  Created by MAC on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EzineAccountViewController.h"

@interface EzineAccountViewController ()

@end

@implementation EzineAccountViewController
@synthesize activityIndicator;
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
    // Do any additional setup after loading the view from its nib.
    [[UIDevice currentDevice] orientation] ;
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged) name:UIDeviceOrientationDidChangeNotification object:nil];
    int xPosition = (self.view.bounds.size.width / 2.0) - 50;
    int yPosition = (self.view.bounds.size.height / 2.0) - 150.0;
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(xPosition, yPosition, 100, 100)];
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [self.view addSubview:activityIndicator];

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

#pragma mark----

#pragma -------
#pragma mark---- orientationChanged
-(void)changedLandScape{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [self.view setFrame:CGRectMake(0, 20, 550, 768)];
    [UIView commitAnimations];
    
}

-(void)changePortrait{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [self.view setFrame:CGRectMake(0, 20, 550, 1004)];
    [UIView commitAnimations];
    
}

-(void)orientationChanged{
    NSLog(@"orientationChanged ezine Account");

    if ([UIApplication sharedApplication].statusBarOrientation==UIInterfaceOrientationLandscapeLeft||[UIApplication sharedApplication].statusBarOrientation==UIInterfaceOrientationLandscapeRight) {
        [self changedLandScape];
    }else if([UIApplication sharedApplication].statusBarOrientation==UIInterfaceOrientationPortrait||[UIApplication sharedApplication].statusBarOrientation==UIInterfaceOrientationPortraitUpsideDown){
        [self changePortrait];
        
        
    }
    
}
#pragma mark--- action handle
- (IBAction)btnDetailClick:(id)sender {
    CGRect menuFrame = self.view.frame;
    if([UIApplication sharedApplication].statusBarOrientation==UIInterfaceOrientationPortrait||[UIApplication sharedApplication].statusBarOrientation==UIInterfaceOrientationPortraitUpsideDown) {
        menuFrame.origin.x = 768;
        
    }else {
        menuFrame.origin.x = 1024;
        
    }
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options: UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.view.frame = menuFrame;
                     } 
                     completion:^(BOOL finished){
                         [self.view removeFromSuperview];
                     }];
    
}

- (IBAction)btnCreateAccountClick:(id)sender {
	NewEzineAccountViewController *newAcount=[[NewEzineAccountViewController alloc] initWithNibName:@"NewEzineAccountViewController" bundle:nil];
    newAcount.delegate=self;
    newAcount.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:newAcount animated:YES completion:nil];
    [newAcount release];



}

- (IBAction)btnSignInClick:(id)sender {
    NSLog(@"dang nhap");
    SignInViewcontroller *signIn=[[SignInViewcontroller alloc] initWithNibName:@"SignInViewcontroller" bundle:nil];
    signIn.delegate=self;
    signIn.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:signIn animated:YES completion:nil];
    [signIn release];

}
- (void)dealloc {
    [super dealloc];
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

#pragma mark-- signin
-(void)Login{
    [[self delegate] LoginSuccess];
    [self.view removeFromSuperview];

}
#pragma mark-- register success
-(void)registerSuccess{
    [[self delegate] LoginSuccess];
    [self.view removeFromSuperview];

}
@end
