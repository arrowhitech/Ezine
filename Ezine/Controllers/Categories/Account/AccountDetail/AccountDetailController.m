//
//  AccountDetailController.m
//  Ezine
//
//  Created by MAC on 9/4/12.
//
//

#import "AccountDetailController.h"
#import "EzineAppDelegate.h"
#import "SettingAccountDetailController.h"

@interface AccountDetailController ()

@end

@implementation AccountDetailController
@synthesize _SuaTaiKhoan;
@synthesize _chiaSe1;
@synthesize _tatcasukien;
@synthesize _tatcaanh;
@synthesize _chiase2;
@synthesize _nameUser;
@synthesize _detailUser;
@synthesize _TrangBia;
@synthesize _avatar;
@synthesize activityIndicator;
@synthesize imageLoadingOperation;
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
    [_SuaTaiKhoan setFont:[UIFont fontWithName:@"UVNHongHaHep" size:14]];
    [_SuaTaiKhoan setBackgroundColor:[UIColor clearColor]];
    [_SuaTaiKhoan setTextColor:RGBCOLOR(101, 101, 101)];
    
    [_TrangBia setFont:[UIFont fontWithName:@"UVNHongHaHepBold" size:14]];
    [_TrangBia setBackgroundColor:[UIColor clearColor]];
   // [_TrangBia setTextColor:RGBCOLOR(101, 101, 101)];
    
    [_tatcasukien setFont:[UIFont fontWithName:@"UVNHongHaHepBold" size:14]];
    [_tatcasukien setBackgroundColor:[UIColor clearColor]];
    //[_tatcasukien setTextColor:RGBCOLOR(101, 101, 101)];

    [_chiaSe1 setFont:[UIFont fontWithName:@"UVNHongHaHep" size:14]];
    [_chiaSe1 setBackgroundColor:[UIColor clearColor]];
    [_chiaSe1 setTextColor:RGBCOLOR(101, 101, 101)];

    [_tatcaanh setFont:[UIFont fontWithName:@"UVNHongHaHepBold" size:14]];
    [_tatcaanh setBackgroundColor:[UIColor clearColor]];
    //[_tatcaanh setTextColor:RGBCOLOR(101, 101, 101)];

    [_chiase2 setFont:[UIFont fontWithName:@"UVNHongHaHep" size:14]];
    [_chiase2 setBackgroundColor:[UIColor clearColor]];
    [_chiase2 setTextColor:RGBCOLOR(101, 101, 101)];

    [_nameUser setFont:[UIFont fontWithName:@"UVNHongHaHepBold" size:17]];
    [_nameUser setBackgroundColor:[UIColor clearColor]];
    [_nameUser setTextColor:[UIColor blackColor]];
    
    [_detailUser setFont:[UIFont fontWithName:@"UVNHongHaHep" size:14]];
    [_detailUser setBackgroundColor:[UIColor clearColor]];
    [_detailUser setTextColor:RGBCOLOR(101, 101, 101)];
    NSString    *urlImage=[[NSUserDefaults standardUserDefaults]objectForKey:@"EzineAccountAvatar"];
    NSString    *name=[[NSUserDefaults standardUserDefaults]objectForKey:@"EzineAccountName"];
    
    [_nameUser setText:name];
    if ((NSNull *)urlImage!=[NSNull null]) {
        EzineAppDelegate *appdelegate=(EzineAppDelegate*)[[UIApplication sharedApplication]delegate];
        self.imageLoadingOperation = [appdelegate.serviceEngine imageAtURL:[NSURL URLWithString:urlImage]
                                                              onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
                                                                  if([urlImage isEqualToString:[url absoluteString]]) {
                                                                      
                                                                      if (isInCache) {
                                                                          self._avatar.image = fetchedImage;
                                                                      } else {
                                                                          UIImageView *loadedImageView = [[UIImageView alloc] initWithImage:fetchedImage];
                                                                          loadedImageView.frame = self._avatar.frame;
                                                                          loadedImageView.alpha = 0;
                                                                          [loadedImageView removeFromSuperview];
                                                                          
                                                                          self._avatar.image = fetchedImage;
                                                                         self._avatar.alpha= 1;
                                                                      }
                                                                  }
                                                              }];
        

    }
    
    int xPosition = (self.view.bounds.size.width / 2.0) - 50;
    int yPosition = (self.view.bounds.size.height / 2.0) - 150.0;
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(xPosition, yPosition, 100, 100)];
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [self.view addSubview:activityIndicator];
    [[UIDevice currentDevice] orientation] ;
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged) name:UIDeviceOrientationDidChangeNotification object:nil];

}

- (void)viewDidUnload
{
    [self set_SuaTaiKhoan:nil];
    [self set_TrangBia:nil];
    [self set_chiaSe1:nil];
    [self set_tatcasukien:nil];
    [self set_tatcaanh:nil];
    [self set_chiase2:nil];
    [self set_nameUser:nil];
    [self set_detailUser:nil];
    [self set_avatar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (IBAction)btn_detailClick:(id)sender {
    if([UIApplication sharedApplication].statusBarOrientation==UIInterfaceOrientationLandscapeLeft||[UIApplication sharedApplication].statusBarOrientation==UIInterfaceOrientationLandscapeRight) {
        
        NSLog(@"Landscape");
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options: UIViewAnimationOptionTransitionNone
                         animations:^{
                             [self.view setFrame:CGRectMake(1024, 20, 550, 1004)];
                         }
                         completion:^(BOOL finished){
                             [self.view removeFromSuperview];
                             
                         }];
        
        
    }else {
        
        NSLog(@"portrait");
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options: UIViewAnimationOptionTransitionNone
                         animations:^{
                             [self.view setFrame:CGRectMake(768, 20, 550, 1004)];
                         }
                         completion:^(BOOL finished){
                             [self.view removeFromSuperview];
                             
                         }];
        
    }

}

- (IBAction)btn_exitClick:(id)sender {

    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"EzineAccountName"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"EzineAccountAvatar"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"EzineAccountID"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"EzineAccountSessionId"];
    XAppDelegate.serviceEngine =Nil;
    XAppDelegate.serviceEngine = [[ServiceEngine alloc] initWithHostName:@"api.ezine.vn" customHeaderFields:nil];
    [XAppDelegate.serviceEngine useCache];
    [[NSNotificationCenter defaultCenter] postNotificationName:KDidLogoutEzineNotification object:self userInfo:nil];
    
    if([UIApplication sharedApplication].statusBarOrientation==UIInterfaceOrientationLandscapeLeft||[UIApplication sharedApplication].statusBarOrientation==UIInterfaceOrientationLandscapeRight) {
        
        NSLog(@"Landscape");
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options: UIViewAnimationOptionTransitionNone
                         animations:^{
                             [self.view setFrame:CGRectMake(1024, 20, 550, 1004)];
                         }
                         completion:^(BOOL finished){
                             [self.view removeFromSuperview];
                             [[self delegate] logout];

                         }];

        
    }else {
        
        NSLog(@"portrait");
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options: UIViewAnimationOptionTransitionNone
                         animations:^{
                             [self.view setFrame:CGRectMake(768, 20, 550, 1004)];
                         }
                         completion:^(BOOL finished){
                             [self.view removeFromSuperview];
                             [[self delegate] logout];

                         }];

    }
    

}

- (IBAction)btnSettingClick:(id)sender {
    
    SettingAccountDetailController *settingdetail=[[SettingAccountDetailController alloc] initWithNibName:@"SettingAccountDetailController" bundle:nil];
  //  newAcount.delegate=self;
//    settingdetail.modalPresentationStyle = UIModalPresentationFormSheet;
//    [self presentViewController:newAcount animated:YES completion:nil];
//    [newAcount release];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:settingdetail];
    navController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    navController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:navController animated:YES completion:nil];
    [settingdetail release];
}
- (void)dealloc {
    [_SuaTaiKhoan release];
    [_TrangBia release];
    [_chiaSe1 release];
    [_tatcasukien release];
    [_tatcaanh release];
    [_chiase2 release];
    [_nameUser release];
    [_detailUser release];
    [_avatar release];
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
@end
