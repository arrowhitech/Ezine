//
//  CoverViewController.m
//  Ezine
//
//  Created by PDG2 on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CoverViewController.h"
#import "CoverObject.h"
#include <QuartzCore/QuartzCore.h>
#import "NSString+HTML.h"
#import "MessageUI/MessageUI.h"
#import "SHK.h"
#import "SHKItem.h"
#import "SHKSharer.h"
#import "SHKTwitter.h"
#import "SHKReadItLater.h"
#import "GooglePlusShare.h"
#import "EzineAppdelegate.h"
#import "ListArticleViewController.h"
//#import "ReadBaseOnWeb.h"

@interface TopsiteCoverObject : NSObject{
    int         _siteID;
    NSString    *_name;
}
@property  (nonatomic, retain)  NSString    *_name;
@property                       int         _siteID;
@end

@implementation TopsiteCoverObject
@synthesize _name,_siteID;

@end

@implementation CoverViewController

@synthesize logoSourceArticle,sourceArticle1,sourceArticle2,sourceArticle3,
sourceArticle4,sourceArticle5,tilte,nameSourceArticle;
@synthesize coverImageView;
@synthesize flipButton;
@synthesize imageLoadingOperation;
@synthesize activityIndicator;
@synthesize delegate;

@synthesize share;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"initWithNibName");
        _arraySite = [[NSMutableArray alloc]init];
        _arraySiteLandScape=[[NSMutableArray alloc] init];
        _arrayCoverImage = [[NSMutableArray alloc] init];
        _arrayCoverImageLandScape=[[NSMutableArray alloc] init];
        _arraySiteLabel=[[NSMutableArray alloc] init];
        _currentOrientation=[[UIApplication sharedApplication] statusBarOrientation];
    
        
        self.toolbarItems = [NSArray arrayWithObjects:
                             [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease],
							 [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share)] autorelease],
                             [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease],
                             nil
                             ];
        
          }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

//+(id)shareinstance{
//    static CoverViewController *cover =nil;
//    if (nil==cover) {
//        cover =[[[self class]alloc]init];
//    }
//    return cover;
//}

- (void)loadView
{
    NSLog(@"LoadView=====================================");
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
	UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenBounds.size.width, screenBounds.size.height)];
    [view setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.view = view;
    _coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 768, 1004)];
    [_coverImageView setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];
    [self.view addSubview:_coverImageView];
    
    
    _ezineLogo = [[UIImageView alloc] initWithFrame:CGRectMake(65/2, 65/2, 120, 168)];
    [_ezineLogo setImage:[UIImage imageNamed:@"Ezine_logo_n.png"]];
    [self.view addSubview:_ezineLogo];
    
    _logoSite=[[UIImageView alloc] initWithFrame:CGRectMake(40, 950, 40, 40)];
    [self.view addSubview:_logoSite];
    _logoSite.contentMode=UIViewContentModeScaleAspectFit;
    
    
    optionButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [optionButton setFrame:CGRectMake(768-45, 1004-65/2-25, 30, 25)];
    [optionButton setImage:[UIImage imageNamed:@"btn_OptionCoverPage_hlight.png"] forState:UIControlStateNormal];
    [optionButton setShowsTouchWhenHighlighted:YES];
    [optionButton addTarget:self action:@selector(btnShowAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:optionButton];
    
    flipButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [flipButton setFrame:CGRectMake(768-62, 1004/2, 65, 65)];
    [flipButton setImage:[UIImage imageNamed:@"flip_button.png"] forState:UIControlStateNormal];
    [flipButton addTarget:self action:@selector(flipButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:flipButton];
    
    // add activityIndicator
    int xPosition = (self.view.bounds.size.width / 2.0) - 50;
    int yPosition = (self.view.bounds.size.height / 2.0) - 150.0;
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(xPosition, yPosition, 100, 100)];
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [self.view addSubview:activityIndicator];
    
    // add loading gif
    _loadingGif=[[UIImageView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_loadingGif];
    _loadingGif.animationDuration = 1;
    _loadingGif.animationRepeatCount = 0;
    
    _sourceArticle1=[[UILabel alloc] init];
    _sourceArticle2=[[UILabel alloc] init];
    _sourceArticle3=[[UILabel alloc] init];
    _sourceArticle4=[[UILabel alloc] init];
    _sourceArticle5=[[UILabel alloc] init];
    _sourceArticle6=[[UILabel alloc] init];
    _tilte=         [[UILabel alloc] init];
    _nameSourceArticle=[[UILabel alloc] init];
    _coverStatic=[[UILabel alloc] init];
    
    [_sourceArticle1 setBackgroundColor:[UIColor clearColor]];
    [_sourceArticle2 setBackgroundColor:[UIColor clearColor]];
    [_sourceArticle3 setBackgroundColor:[UIColor clearColor]];
    [_sourceArticle4 setBackgroundColor:[UIColor clearColor]];
    [_sourceArticle5 setBackgroundColor:[UIColor clearColor]];
    [_sourceArticle6 setBackgroundColor:[UIColor clearColor]];
    [_tilte setBackgroundColor:[UIColor clearColor]];
    [_nameSourceArticle setBackgroundColor:[UIColor clearColor]];
    [_coverStatic setBackgroundColor:[UIColor clearColor]];
    
    
    [_sourceArticle1 setTextColor:[UIColor whiteColor]];
    [_sourceArticle2 setTextColor:[UIColor whiteColor]];
    [_sourceArticle3 setTextColor:[UIColor whiteColor]];
    [_sourceArticle4 setTextColor:[UIColor whiteColor]];
    [_sourceArticle5 setTextColor:[UIColor whiteColor]];
    [_sourceArticle6 setTextColor:[UIColor whiteColor]];
    [_tilte setTextColor:[UIColor whiteColor]];
    [_nameSourceArticle setTextColor:[UIColor whiteColor]];
    [_coverStatic setTextColor:[UIColor whiteColor]];
    
    
    [_sourceArticle1 setFont:[UIFont fontWithName:@"UVNHongHaHep" size:30+XAppDelegate.appFontSize]];
    [_sourceArticle2 setFont:[UIFont fontWithName:@"UVNHongHaHep" size:30+XAppDelegate.appFontSize]];
    [_sourceArticle3 setFont:[UIFont fontWithName:@"UVNHongHaHep" size:30+XAppDelegate.appFontSize]];
    [_sourceArticle4 setFont:[UIFont fontWithName:@"UVNHongHaHep" size:30+XAppDelegate.appFontSize]];
    [_sourceArticle5 setFont:[UIFont fontWithName:@"UVNHongHaHep" size:30+XAppDelegate.appFontSize]];
    [_sourceArticle6 setFont:[UIFont fontWithName:@"UVNHongHaHep" size:30+XAppDelegate.appFontSize]];
    [_tilte setFont:[UIFont fontWithName:@"UVNHongHaHepBold" size:45+XAppDelegate.appFontSize]];
    [_nameSourceArticle setFont:[UIFont fontWithName:@"UVNHongHaHep" size:20+XAppDelegate.appFontSize]];
    _tilte.font=[_tilte.font fontWithSize:40+XAppDelegate.appFontSize];
    _tilte.numberOfLines = 0;
    
    
    [_sourceArticle1 setTextAlignment:UITextAlignmentRight];
    [_sourceArticle2 setTextAlignment:UITextAlignmentRight];
    [_sourceArticle3 setTextAlignment:UITextAlignmentRight];
    [_sourceArticle4 setTextAlignment:UITextAlignmentRight];
    [_sourceArticle5 setTextAlignment:UITextAlignmentRight];
    [_sourceArticle6 setTextAlignment:UITextAlignmentRight];
    _sourceArticle1.shadowColor = [UIColor blackColor];
    _sourceArticle1.shadowOffset = CGSizeMake(0, 1);
    _sourceArticle2.shadowColor = [UIColor blackColor];
    _sourceArticle2.shadowOffset = CGSizeMake(0, 1);
    _sourceArticle3.shadowColor = [UIColor blackColor];
    _sourceArticle3.shadowOffset = CGSizeMake(0, 1);
    _sourceArticle4.shadowColor = [UIColor blackColor];
    _sourceArticle4.shadowOffset = CGSizeMake(0, 1);
    _sourceArticle5.shadowColor = [UIColor blackColor];
    _sourceArticle5.shadowOffset = CGSizeMake(0, 1);
    _sourceArticle6.shadowColor = [UIColor blackColor];
    _sourceArticle6.shadowOffset = CGSizeMake(0, 1);
    
    [_tilte setTextAlignment:UITextAlignmentLeft];
    [_nameSourceArticle setTextAlignment:UITextAlignmentLeft];
    [_coverStatic setTextAlignment:UITextAlignmentLeft];
    _tilte.shadowColor = [UIColor blackColor];
    _tilte.shadowOffset = CGSizeMake(0, 1);
    _nameSourceArticle.shadowColor = [UIColor blackColor];
    _nameSourceArticle.shadowOffset = CGSizeMake(0, 1);
    _coverStatic.shadowColor = [UIColor blackColor];
    _coverStatic.shadowOffset = CGSizeMake(0, 1);
    
    
    [_sourceArticle1 setFrame:CGRectMake(384, 20, 360, 45)];
    [_sourceArticle2 setFrame:CGRectMake(384, 60, 360, 45)];
    [_sourceArticle3 setFrame:CGRectMake(384, 100, 360, 45)];
    [_sourceArticle4 setFrame:CGRectMake(384, 140, 360, 45)];
    [_sourceArticle5 setFrame:CGRectMake(384, 180, 360, 45)];
    [_sourceArticle6 setFrame:CGRectMake(384, 220, 360, 45)];
    [_tilte setFrame:CGRectMake(65/2, 700, 600, 150)];
    [_nameSourceArticle setFrame:CGRectMake(85, 917, 180, 70)];
    [_coverStatic setFrame:CGRectMake(65/2, 840, 180, 150)];
    [_logoSite setFrame:CGRectMake(65/2, 1004-65/2-40, 40, 40)];
    [optionButton setFrame:CGRectMake(768-60, 1004-65/2-25, 30, 25)];
    
    [_coverImageView setFrame:CGRectMake(0, 0, 768, 1004)];
    [activityIndicator setFrame:CGRectMake(322, 462, 100, 100)];
    
    _sourceArticle1.userInteractionEnabled=YES;
    _sourceArticle2.userInteractionEnabled=YES;
    _sourceArticle3.userInteractionEnabled=YES;
    _sourceArticle4.userInteractionEnabled=YES;
    _sourceArticle5.userInteractionEnabled=YES;
    _tilte.userInteractionEnabled=YES;
    _nameSourceArticle.userInteractionEnabled=YES;
    _logoSite.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *tapGesture1 = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap1:)] autorelease];
    UITapGestureRecognizer *tapGesture2 = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap2:)] autorelease];
    UITapGestureRecognizer *tapGesture3 = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap3:)] autorelease];
    UITapGestureRecognizer *tapGesture4 = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap4:)] autorelease];
    UITapGestureRecognizer *tapGesture5 = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap5:)] autorelease];
    
    UITapGestureRecognizer *tapGesture6 = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelArticleClick)] autorelease];
    
    UITapGestureRecognizer *tapGesture7 = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap:)] autorelease];
    UITapGestureRecognizer *tapGesture8 = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap:)] autorelease];

    [_sourceArticle1 addGestureRecognizer:tapGesture1];
    [_sourceArticle2 addGestureRecognizer:tapGesture2];
    [_sourceArticle3 addGestureRecognizer:tapGesture3];
    [_sourceArticle4 addGestureRecognizer:tapGesture4];
    [_sourceArticle5 addGestureRecognizer:tapGesture5];
    [_tilte addGestureRecognizer:tapGesture6];
    [_nameSourceArticle addGestureRecognizer:tapGesture7];
    [_logoSite addGestureRecognizer:tapGesture8];

    if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeLeft||[[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeRight) {
        _loadingGif.animationImages=[NSArray arrayWithObjects:[UIImage imageNamed:@"Ezine-loading-V1.png"],[UIImage imageNamed:@"Ezine-loading-V2.png"],[UIImage imageNamed:@"Ezine-loading-V3.png"],[UIImage imageNamed:@"Ezine-loading-V4.png"],[UIImage imageNamed:@"Ezine-loading-V5.png"],[UIImage imageNamed:@"Ezine-loading-V6.png"],nil];
        [_loadingGif startAnimating];
        

        [_sourceArticle1 setFrame:CGRectMake(620, 20, 360, 45)];
        [_sourceArticle2 setFrame:CGRectMake(620, 60, 360, 45)];
        [_sourceArticle3 setFrame:CGRectMake(620, 100, 360, 45)];
        [_sourceArticle4 setFrame:CGRectMake(620, 140, 360, 45)];
        [_sourceArticle5 setFrame:CGRectMake(620, 180,360, 45)];
        [_sourceArticle6 setFrame:CGRectMake(620, 220,360, 45)];
        [_tilte setFrame:CGRectMake(65/2, 450, 600, 150)];
        [_nameSourceArticle setFrame:CGRectMake(85, 660, 180, 70)];
        [_coverStatic setFrame:CGRectMake(65/2, 580, 180, 150)];
        [_logoSite setFrame:CGRectMake(65/2, 748-40-65/2, 40, 40)];
        [optionButton setFrame:CGRectMake(1004-60, 768-65/2-25, 30, 25)];
        _showActionButton=CGRectMake(1004-45, 768-60, 30, 25);
        [activityIndicator setFrame:CGRectMake(462, 322, 100, 100)];
        
    }else if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortrait||[[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortraitUpsideDown){
        _loadingGif.animationImages=[NSArray arrayWithObjects:[UIImage imageNamed:@"Ezine-loading-H1.png"],[UIImage imageNamed:@"Ezine-loading-H2.png"],[UIImage imageNamed:@"Ezine-loading-H3.png"],[UIImage imageNamed:@"Ezine-loading-H4.png"],[UIImage imageNamed:@"Ezine-loading-H5.png"],[UIImage imageNamed:@"Ezine-loading-H1.png"],nil];
        [_loadingGif startAnimating];
        


        [_sourceArticle1 setFrame:CGRectMake(384, 20, 360, 45)];
        [_sourceArticle2 setFrame:CGRectMake(384, 60, 360, 45)];
        [_sourceArticle3 setFrame:CGRectMake(384, 100, 360, 45)];
        [_sourceArticle4 setFrame:CGRectMake(384, 140, 360, 45)];
        [_sourceArticle5 setFrame:CGRectMake(384, 180, 360, 45)];
        [_sourceArticle6 setFrame:CGRectMake(384, 220, 360, 45)];
        [_tilte setFrame:CGRectMake(65/2, 700, 600, 150)];
        [_nameSourceArticle setFrame:CGRectMake(85, 917, 180, 70)];
        [_coverStatic setFrame:CGRectMake(65/2, 840, 180, 150)];
        [_logoSite setFrame:CGRectMake(65/2, 1004-40-65/2, 40, 40)];
        [optionButton setFrame:CGRectMake(768-45, 1004-65/2-25, 30, 25)];
        _showActionButton=CGRectMake(1004-60, 768-60, 30, 25);
        [activityIndicator setFrame:CGRectMake(322, 462, 100, 100)];
        
        
    }
    [self.view addSubview:_sourceArticle1];
    [self.view addSubview:_sourceArticle2];
    [self.view addSubview:_sourceArticle3];
    [self.view addSubview:_sourceArticle4];
    [self.view addSubview:_sourceArticle5];
    //[self.view addSubview:_sourceArticle6];
    [self.view addSubview:_tilte];
    [self.view addSubview:_nameSourceArticle];
    [self.view addSubview:_coverStatic];
    [_coverStatic setFont:[UIFont fontWithName:@"UVNHongHaHepBold" size:20+XAppDelegate.appFontSize]];
    _coverStatic.text=@"TRANG TIN NỔI BẬT";
    [[UIDevice currentDevice] orientation] ;
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged) name:UIDeviceOrientationDidChangeNotification object:nil];
    [self showActivityIndicator];
    
}


-(void) receivedRotate{
    
    if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeLeft||[[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeRight) {
        [self changedLandScape];
        NSLog(@"orientationChanged");
    }else if([[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortrait||[[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortraitUpsideDown){
        [self changePortrait];
        
        
    }
    
}

-(void)viewDidLoad{
    
    //  [SHK setRootViewController:self];
    // [[SHK currentHelper] setRootViewController:self];
    [super viewDidLoad];
    
    
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
#pragma mark--------
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    NSLog(@"view didAppear");
    [XAppDelegate.serviceEngine listTopCoveronCompletion:^(NSMutableArray* responseArr) {
        [self fetchedDataTopCover:responseArr];
    } onError:^(NSError* error) {
        
    }];
    
    [XAppDelegate.serviceEngine listTopSiteonCompletion:^(NSMutableArray* responseArr) {
        [self fetchedDataTopSite:responseArr];
    } onError:^(NSError* error) {
        
    }];
    
    
}
- (void)viewDidUnload{
    
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft||toInterfaceOrientation==UIInterfaceOrientationLandscapeRight||toInterfaceOrientation==UIInterfaceOrientationPortrait||toInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown);
}


-(void)dealloc{
    [coverImageView release];
    [ezineLogo release];
    [sourceArticle1 release];
    [sourceArticle2 release];
    [sourceArticle3 release];
    [sourceArticle4 release];
    [sourceArticle5 release];
    [logoSourceArticle release];
    [_arrayCoverImage release];
    [tilte release];
    [flipButton release];
    [optionButton release];
    [_arraySite release];
    [super dealloc];
}


#pragma mark==============OK===============Button handle========

-(IBAction)btnFlipCoverPageClicked:(id)sender{
    
    NSLog(@"btnFlipCoverPageClicked Okey");
    
}

#pragma mark========OK==========UIActionSheetDelagate==============
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    //int _currentCover=currentImage;
       SiteObject *siteObject=[[SiteObject alloc] init];
       if (_currentOrientation==UIInterfaceOrientationPortrait||_currentOrientation==UIInterfaceOrientationPortraitUpsideDown) {
           siteObject=[_arraySite objectAtIndex:currentImage];
        }else{
            siteObject=[_arraySiteLandScape objectAtIndex:currentImage];
    
        }
        urlweb=siteObject._urlWeb;
        switch (buttonIndex) {
            case 0:
                NSLog(@"Face");
                [self shareFacebook];
                break;
            case 1:
                NSLog(@"Chia se qua Gooogle +");
               // [self shareEmail];
                [self ShareViaGooglePlus];
                break;
            case 2:
                NSLog(@"Chia se qua Email");
               // [self ReadItLater];
                [self shareEmail];
                break;
            case 3:
                NSLog(@"tin nhan");
              //  [self ReadBaseOnWeb:_currentCover];
                
                [self shareMessage];
                break;
            case 4:
                NSLog(@"Danh dau yeu thich");
                break;
            case 5:
                NSLog(@"Trang noi bat");
                break;
            default:
                break;
        }
    
}

#pragma mark---- orientationChanged
-(void)changedLandScape{
   
        [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [_sourceArticle1 setFrame:CGRectMake(620, 20, 360, 45)];
    [_sourceArticle2 setFrame:CGRectMake(620, 60, 360, 45)];
    [_sourceArticle3 setFrame:CGRectMake(620, 100, 360, 45)];
    [_sourceArticle4 setFrame:CGRectMake(620, 140, 360, 45)];
    [_sourceArticle5 setFrame:CGRectMake(620, 180,360, 45)];
    [_sourceArticle6 setFrame:CGRectMake(620, 220,360, 45)];
    
    [flipButton setFrame:CGRectMake(1024-62, 748/2, 65, 65)];

    [_tilte setFrame:CGRectMake(65/2, 450, 600, 150)];
    [_nameSourceArticle setFrame:CGRectMake(85, 660, 180, 70)];
    [_coverStatic setFrame:CGRectMake(65/2, 580, 180, 150)];
    
    [_logoSite setFrame:CGRectMake(65/2, 748-40-65/2, 40, 40)];
    [optionButton setFrame:CGRectMake(1004-60, 768-65/2-25, 30, 25)];
    
    [_coverImageView setFrame:CGRectMake(0, 0, 1024, 768)];
    [activityIndicator setFrame:CGRectMake(462, 322, 100, 100)];
    [_loadingGif stopAnimating];

        _loadingGif.animationImages=[NSArray arrayWithObjects:[UIImage imageNamed:@"Ezine-loading-V1.png"],[UIImage imageNamed:@"Ezine-loading-V2.png"],[UIImage imageNamed:@"Ezine-loading-V3.png"],[UIImage imageNamed:@"Ezine-loading-V4.png"],[UIImage imageNamed:@"Ezine-loading-V5.png"],[UIImage imageNamed:@"Ezine-loading-V6.png"],nil];
        
        [_loadingGif setFrame:CGRectMake(0, 0, 1024, 768)];
        [_loadingGif startAnimating];
        
    

    [UIView commitAnimations];
    
}
-(void)changePortrait{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [_sourceArticle1 setFrame:CGRectMake(384, 20, 360, 45)];
    [_sourceArticle2 setFrame:CGRectMake(384, 60, 360, 45)];
    [_sourceArticle3 setFrame:CGRectMake(384, 100, 360, 45)];
    [_sourceArticle4 setFrame:CGRectMake(384, 140, 360, 45)];
    [_sourceArticle5 setFrame:CGRectMake(384, 180, 360, 45)];
    [_sourceArticle6 setFrame:CGRectMake(384, 220, 360, 45)];
    
    [flipButton setFrame:CGRectMake(768-62, 1004/2, 65, 65)];

    [_tilte setFrame:CGRectMake(65/2, 700, 600, 150)];
    [_nameSourceArticle setFrame:CGRectMake(85, 917, 180, 70)];
    [_coverStatic setFrame:CGRectMake(65/2, 840, 180, 150)];
    [_logoSite setFrame:CGRectMake(65/2, 1004-40-65/2, 40, 40)];
    [optionButton setFrame:CGRectMake(768-60, 1004-65/2-25, 30, 25)];
    
    [_coverImageView setFrame:CGRectMake(0, 0, 768, 1004)];
    [activityIndicator setFrame:CGRectMake(322, 462, 100, 100)];
        [_loadingGif stopAnimating];
        _loadingGif.animationImages=[NSArray arrayWithObjects:[UIImage imageNamed:@"Ezine-loading-H1.png"],[UIImage imageNamed:@"Ezine-loading-H2.png"],[UIImage imageNamed:@"Ezine-loading-H3.png"],[UIImage imageNamed:@"Ezine-loading-H4.png"],[UIImage imageNamed:@"Ezine-loading-H5.png"],[UIImage imageNamed:@"Ezine-loading-H1.png"],nil];
        [_loadingGif setFrame:CGRectMake(0, 0, 768, 1024)];
        [_loadingGif startAnimating];
        

    
    [UIView commitAnimations];
    
}

-(void)orientationChanged{
    if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeLeft||[[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeRight) {
        _showActionButton=CGRectMake(1004-45, 768-60, 30, 25);
        _currentOrientation=UIInterfaceOrientationLandscapeLeft;
        for (int i=0;i<[_arraySite count];i++) {
            SiteObject *sitePoitrait=[_arraySite objectAtIndex:i];
            for (int j=0;j<[_arraySiteLandScape count]; j++) {
                SiteObject *siteLandscape=[_arraySiteLandScape objectAtIndex:j];
                if ([sitePoitrait._title isEqualToString:siteLandscape._title]) {
                    UIImage *img = [_arrayCoverImageLandScape objectAtIndex:j];
                    [_coverImageView setImage:img];
                    [self showDataForSite:siteLandscape];
                    currentImage=j;
                }
            }
            
        }
        
        [self changedLandScape];
    }else if([[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortrait||[[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortraitUpsideDown){
        _showActionButton=CGRectMake(1004-45, 768-60, 30, 25);
        _currentOrientation=UIInterfaceOrientationPortrait;
        
        for (int i=0;i<[_arraySiteLandScape count];i++) {
            SiteObject *sitePoitrait=[_arraySiteLandScape objectAtIndex:i];
            for (int j=0;j<[_arraySite count]; j++) {
                SiteObject *siteLandscape=[_arraySite objectAtIndex:j];
                if ([sitePoitrait._title isEqualToString:siteLandscape._title]) {
                    UIImage *img = [_arrayCoverImage objectAtIndex:j];
                    [_coverImageView setImage:img];
                    [self showDataForSite:siteLandscape];
                    currentImage=j;
                }
            }
            
        }
        
        [self changePortrait];
        
    }
    
}

#pragma mark---
#pragma mark--- slide
bool isexpand=YES;
-(void)SlideAnnotation{
    //NSLog(@"image poitrait load== %d,  image landscape load=== %d",_arrayCoverImage.count,_arrayCoverImageLandScape.count);
    if (_currentOrientation==UIInterfaceOrientationPortrait||_currentOrientation==UIInterfaceOrientationPortraitUpsideDown) {
        if (_arrayCoverImage.count>1) {
            currentImage ++;
            if (currentImage>[_arrayCoverImage count]-1) {
                currentImage=0;
            }
            
            UIImage *img = [_arrayCoverImage objectAtIndex:currentImage];
            CABasicAnimation *crossFade = [CABasicAnimation animationWithKeyPath:@"contents"];
            crossFade.duration = 2.0;
            crossFade.fromValue = _coverImageView.image.CIImage;
            crossFade.toValue = img.CIImage;
            [_coverImageView.layer addAnimation:crossFade forKey:@"animateContents"];
            [_coverImageView setImage:img];
            
            
            SiteObject *site = [_arraySite objectAtIndex:currentImage];
            [self showDataForSite:site];
            
        }
        
    }else if (_currentOrientation==UIInterfaceOrientationLandscapeLeft||_currentOrientation==UIInterfaceOrientationLandscapeRight) {
        if (_arrayCoverImageLandScape.count>1) {
            currentImage ++;
            if (currentImage>[_arrayCoverImageLandScape count]-1) {
                currentImage=0;
            }
            
            UIImage *img = [_arrayCoverImageLandScape objectAtIndex:currentImage];
            CABasicAnimation *crossFade = [CABasicAnimation animationWithKeyPath:@"contents"];
            crossFade.duration = 2.0;
            crossFade.fromValue = _coverImageView.image.CIImage;
            crossFade.toValue = img.CIImage;
            [_coverImageView.layer addAnimation:crossFade forKey:@"animateContents"];
            [_coverImageView setImage:img];
            
            
            SiteObject *site = [_arraySiteLandScape objectAtIndex:currentImage];
            [self showDataForSite:site];
            
        }
        
    }
}
-(void) startSlideShow{
    [_loadingGif stopAnimating];
    [_loadingGif removeFromSuperview];
    
    isStartedSlideShow = TRUE;
    [self hideActivityIndicator];
    if (_currentOrientation==UIInterfaceOrientationPortrait||_currentOrientation==UIInterfaceOrientationPortraitUpsideDown){
        [_coverImageView setImage:[_arrayCoverImage objectAtIndex:0]];
        SiteObject *site = [_arraySite objectAtIndex:0];
        [self showDataForSite:site];
        
        
    }else if (_currentOrientation==UIInterfaceOrientationLandscapeLeft||_currentOrientation==UIInterfaceOrientationLandscapeRight){
        [_coverImageView setImage:[_arrayCoverImageLandScape objectAtIndex:0]];
        SiteObject *site = [_arraySiteLandScape objectAtIndex:0];
        [self showDataForSite:site];
        
    }
    
    [NSTimer scheduledTimerWithTimeInterval: 5.0f
                                     target: self
                                   selector: @selector(SlideAnnotation)
                                   userInfo: nil
                                    repeats: YES];
    
}

#pragma mark--- parster json
-(void) showDataForSite:(SiteObject*) site{
    [_tilte setText:site._title];
    [_nameSourceArticle setText:site._name];
    
    if ((NSNull *) site._logoUrl == [NSNull null]) {
        site._logoUrl =@"";
    }else{
        
        self.imageLoadingOperation = [XAppDelegate.serviceEngine imageAtURL:[NSURL URLWithString:site._logoUrl]
                                                               onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
                                                                   if([site._logoUrl isEqualToString:[url absoluteString]]) {
                                                                       _logoSite.image = fetchedImage;
                                                                   }
                                                               }];

        
    }
        
}
- (void)fetchedDataTopCover:(NSMutableArray*)arr{
    //parse out the json data
    if (!arr||[arr count]<1) {
        return;
    }
    for (int i=0; i<[arr count]; i++) {
        NSDictionary *dataCover=[arr objectAtIndex:i];
        CoverObject *coverObject=[[CoverObject alloc] init];
        coverObject._articleID=[[dataCover objectForKey:@"ArticleID"] intValue];
        coverObject._mainHeadImageUrl_L=[dataCover objectForKey:@"MainHeadImageUrl_L"];
        coverObject._mainHeadImageUrl_P=[dataCover objectForKey:@"MainHeadImageUrl_P"];
        coverObject._site=[dataCover objectForKey:@"Site"];
        coverObject._title=[dataCover objectForKey:@"Title"];
        coverObject._urlWeb=[dataCover objectForKey:@"UrlWeb"];
        
        SiteObject  *siteObject=[[SiteObject alloc] init];
        siteObject._siteID=[[coverObject._site objectForKey:@"SiteID"] integerValue];
        siteObject._name=[coverObject._site objectForKey:@"Name"];
        siteObject._logoUrl=[coverObject._site objectForKey:@"LogoUrl"];
        siteObject._urlWeb=[dataCover objectForKey:@"UrlWeb"];
        siteObject._articleID=coverObject._articleID;
        siteObject._title=[dataCover objectForKey:@"Title"];
        siteObject._title= [siteObject._title stringByEncodingHTMLEntities:YES];
        siteObject._title= [siteObject._title stringByConvertingHTMLToPlainText];
        
        if ((NSNull *) coverObject._mainHeadImageUrl_P == [NSNull null]) {
            coverObject._mainHeadImageUrl_P =@"";
        }
        self.imageLoadingOperation = [XAppDelegate.serviceEngine imageAtURL:[NSURL URLWithString:coverObject._mainHeadImageUrl_P]
                                                               onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
                                                                   if([coverObject._mainHeadImageUrl_P isEqualToString:[url absoluteString]]) {
                                                                       if (_arrayCoverImage.count == 5) {
                                                                           [_arrayCoverImage removeObjectAtIndex:0];
                                                                       }
                                                                       if (_arraySite.count==5) {
                                                                           [_arraySite removeObjectAtIndex:0];
                                                                       }
                                                                       [_arraySite addObject:siteObject];
                                                                       [_arrayCoverImage addObject:fetchedImage];
                                                                       if (_currentOrientation==UIInterfaceOrientationPortrait||_currentOrientation==UIInterfaceOrientationPortraitUpsideDown){
                                                                           if (!isStartedSlideShow) {
                                                                               [self startSlideShow];
                                                                           }
                                                                       }
                                                                       
                                                                   }
                                                               }];
        
        
        if ((NSNull *) coverObject._mainHeadImageUrl_L == [NSNull null]) {
            coverObject._mainHeadImageUrl_L =@"";
        }
        self.imageLoadingOperation = [XAppDelegate.serviceEngine imageAtURL:[NSURL URLWithString:coverObject._mainHeadImageUrl_L]
                                                               onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
                                                                   if([coverObject._mainHeadImageUrl_L isEqualToString:[url absoluteString]]) {
                                                                       if (_arrayCoverImageLandScape.count == 5) {
                                                                           [_arrayCoverImageLandScape removeObjectAtIndex:0];
                                                                       }
                                                                       if (_arraySiteLandScape.count==5) {
                                                                           [_arraySiteLandScape removeObjectAtIndex:0];
                                                                       }
                                                                       [_arraySiteLandScape addObject:siteObject];
                                                                       [_arrayCoverImageLandScape addObject:fetchedImage];
                                                                       if (_currentOrientation==UIInterfaceOrientationLandscapeLeft||_currentOrientation==UIInterfaceOrientationLandscapeRight){
                                                                           if (!isStartedSlideShow) {
                                                                               [self startSlideShow];
                                                                           }
                                                                           
                                                                       }
                                                                   }
                                                               }];
        
        
        coverObject=nil;
    }
}

- (void)fetchedDataTopSite:(NSMutableArray*)arr{
    //parse out the json data
    if (!arr||[arr count]<1) {
        return;
    }
    for (int i=0; i<arr.count; i++) {
        NSDictionary    *dataTopsite=[arr objectAtIndex:i];
        TopsiteCoverObject *topsiteObject=[[TopsiteCoverObject alloc] init];
        topsiteObject._siteID=[[dataTopsite objectForKey:@"SiteID"] intValue];
        topsiteObject._name=[dataTopsite objectForKey:@"Name"];
        [_arraySiteLabel addObject:topsiteObject];
        switch (i) {
            case 0:
                _sourceArticle1.text=topsiteObject._name;
                break;
            case 1:
                _sourceArticle2.text=topsiteObject._name;
                break;
            case 2:
                _sourceArticle3.text=topsiteObject._name;
                break;
            case 3:
                _sourceArticle4.text=topsiteObject._name;
                break;
            case 4:
                _sourceArticle5.text=topsiteObject._name;
                break;
            default:
                break;
        }
    }
    _sourceArticle6.text=@"& More";
    
}




#pragma mark---- action handle
-(void)btnShowAction:(id)sender{
    UIActionSheet* action=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Chia sẻ qua Facebook",@"Chia sẻ qua Google +",@"Chia sẻ qua Email",@"Chia sẻ qua tin nhắn",@"Đánh dấu yêu thích",@"Trang tin nổi bật", nil ];
    // actionsheet.tag=10;
    _showActionButton=CGRectMake(768-65, 1004-65/2-25, 30, 25);
    if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeLeft||[[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeRight) {
        _showActionButton=CGRectMake(1004-55, 768-65/2-25, 30, 25);
        NSLog(@"orientationChanged");
    }else if([[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortrait||[[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortraitUpsideDown){
        _showActionButton=CGRectMake(768-65, 1004-65/2-25, 30, 25);
    }
    
    [action showFromRect:_showActionButton inView:self.view animated:YES];
}

#pragma mark==============Okey===================

-(void)shareEmail{
    [self showActivityIndicator];
    
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        
        [mailer setSubject:@""];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:@"ezine@gmail.com",nil];
        [mailer setToRecipients:toRecipients];
        
        NSString *emailBody = @"http://api.ezine.vn/article/";
        [mailer setMessageBody:emailBody isHTML:NO];
        
        [self presentModalViewController:mailer animated:YES];
        
        [mailer release];
    }
    else
    {
        [self hideActivityIndicator];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    
    
}

//-(void)shareFacebookAndTwitter{
//
//    SHKItem *item1 =[SHKItem URL:[NSURL URLWithString: @"http://www.youtube.com/watch?v=uCg2BoKiuOM&feature=autoplay&list=AL94UKMTqg-9B0_SSFht95M4ZlQOt5JZdZ&playnext=6"]title:@"CO gi hot"];
//	SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item1];
//[actionSheet showInView:self.view];
//}

#pragma mark============MFmailDelegate=========
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    [self hideActivityIndicator];
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    
    // Remove the mail view
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark=====Share FaceBook Email G+ Tin Nhan==Danh dau yeu thich==Trang noi bat 

//Facebook=======================

-(void)shareFacebook{
    
    // [self showActivityIndicator];
    [[SHKActivityIndicator currentIndicator] displayActivity:@"Bắt đầu share facebook"];
    FBFeedPost *post = [[FBFeedPost alloc] initWithLinkPath:urlweb caption:@"Ipad apps"];
    [post publishPostWithDelegate:self];
    
}
//GooglePlus======================
-(void)ShareViaGooglePlus{
    
    share =[[[GooglePlusShare alloc] initWithClientID:kClientId] autorelease];
    share.delegate = self;
    
    [[[[share shareDialog]
       setURLToShare:[NSURL URLWithString:urlweb]]
      setPrefillText:@"Ezine"] open];
    
    // Or, without a URL or prefill text:
   // [[share shareDialog] open];
    
}
//Message==========================
-(void)shareMessage{
    
    
    
}
//-(void)shareTwitter{
//    
//	NSURL *url = [NSURL URLWithString:@"http://pdg-technologies.com"];
//	SHKItem *item = [SHKItem URL:url title:@"Follow Ezine to get the hotest news hahahahahahahahaha"];
//
//    [SHKTwitter shareItem:item];
//}

//-(void)ReadItLater{
//    
//    NSURL *url = [NSURL URLWithString:@"http://ezine.com.vm"];
//    SHKItem *item = [SHKItem URL:url title:@"Read it later"];
//    // Share the item
//    [SHKReadItLater shareItem:item];
//}

#pragma mark -
#pragma mark FBFeedPostDelegate

- (void) failedToPublishPost:(FBFeedPost*) _post {
    NSLog(@"failedToPublishPost failedToPublishPost failedToPublishPost");
    //[self hideActivityIndicator];
	[_post release];
    // type=kUploadNone;
}

- (void) finishedPublishingPost:(FBFeedPost*) _post {
    //[self showNotificationOn:self.view withText:@"Successfully posted to facebook!"];
	[_post release];
    
}
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    // [self hideActivityIndicator];
    
    [[SHKActivityIndicator currentIndicator]displayCompleted:@"Lỗi share lên facebook"];
    
	NSLog(@"ResponseFailed: %@", error);
	
}

- (void)request:(FBRequest *)request didLoad:(id)result{
    // [self hideActivityIndicator];
    [[SHKActivityIndicator currentIndicator]displayCompleted:@"Đã share lên facebook"];
    NSLog(@"finishedPublishingPost 22222 22222");
}
- (void)request:(FBRequest *)request didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    
}
#pragma mark facebook cancel
- (void)cancelFacebook{
    NSLog(@"cancel facebook");
    //[self hideActivityIndicator];
     [[SHKActivityIndicator currentIndicator]displayCompleted:@"Thoát"];
}
#pragma mark ================ Read on Web

//-(void)ReadBaseOnWeb:(int)numberCover{
//    SiteObject *siteObject=[[SiteObject alloc] init];
//    if (_currentOrientation==UIInterfaceOrientationPortrait||_currentOrientation==UIInterfaceOrientationPortraitUpsideDown) {
//        siteObject=[_arraySite objectAtIndex:currentImage];
//    }else{
//        siteObject=[_arraySiteLandScape objectAtIndex:currentImage];
//        
//    }
//    NSString *urlweb=siteObject._urlWeb;
//    ReadBaseOnWeb* readonWeb =[[ReadBaseOnWeb alloc]initWithNibName:@"ReadBaseOnWeb" bundle:nil];
//    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:readonWeb];
//    readonWeb.urlWeb=urlweb;
//    navController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//    navController.modalPresentationStyle = UIModalPresentationFormSheet;
//    [readonWeb.view setFrame:CGRectMake(0, 20, 768, 1004)];
//    CGRect menuFrame=readonWeb.view.frame;
//    menuFrame.origin.y=20;
//    
//    [ self.navigationController pushViewController:readonWeb animated:YES];
//    //[self presentModalViewController:readonWeb animated:YES];
//    [readonWeb release];
//    
//}
#pragma mark----- reload font size

-(void) reloadFontSize{
    
    [_sourceArticle1 setFont:[UIFont fontWithName:@"UVNHongHaHep" size:30+XAppDelegate.appFontSize]];
    [_sourceArticle2 setFont:[UIFont fontWithName:@"UVNHongHaHep" size:30+XAppDelegate.appFontSize]];
    [_sourceArticle3 setFont:[UIFont fontWithName:@"UVNHongHaHep" size:30+XAppDelegate.appFontSize]];
    [_sourceArticle4 setFont:[UIFont fontWithName:@"UVNHongHaHep" size:30+XAppDelegate.appFontSize]];
    [_sourceArticle5 setFont:[UIFont fontWithName:@"UVNHongHaHep" size:30+XAppDelegate.appFontSize]];
    [_sourceArticle6 setFont:[UIFont fontWithName:@"UVNHongHaHep" size:30+XAppDelegate.appFontSize]];
    [_tilte setFont:[UIFont fontWithName:@"UVNHongHaHepBold" size:45+XAppDelegate.appFontSize]];
    [_nameSourceArticle setFont:[UIFont fontWithName:@"UVNHongHaHep" size:20+XAppDelegate.appFontSize]];
    _tilte.font=[_tilte.font fontWithSize:40+XAppDelegate.appFontSize];

}

#pragma Google Plus Delegate===========Okey

- (void)finishedSharing: (BOOL)shared {
    // Display success message, or ignore.
    
    NSLog(@"done G+");
}
#pragma mark--- lable Click
-(void)labelTap1:(id)sender{
    
    NSLog(@"label click article== %d  %@",currentImage,sender);
    TopsiteCoverObject *siteObject=[_arraySiteLabel objectAtIndex:0];
    
    ListArticleViewController *vc=[[ListArticleViewController alloc] initWithNibName:@"ListArticleViewController" bundle:nil];
    [vc setSiteId:siteObject._siteID];
    [vc loaddataFromSite];
    EzineAppDelegate *appDelegate=(EzineAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:vc animated:YES];
    
}
-(void)labelTap2:(id)sender{
    
    NSLog(@"label click article== %d  %@",currentImage,sender);
    TopsiteCoverObject *siteObject=[_arraySiteLabel objectAtIndex:1];

    ListArticleViewController *vc=[[ListArticleViewController alloc] initWithNibName:@"ListArticleViewController" bundle:nil];
    [vc setSiteId:siteObject._siteID];
    [vc loaddataFromSite];
    EzineAppDelegate *appDelegate=(EzineAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:vc animated:YES];
    
}
-(void)labelTap3:(id)sender{
    
    NSLog(@"label click article== %d  %@",currentImage,sender);
    TopsiteCoverObject *siteObject=[_arraySiteLabel objectAtIndex:2];

    ListArticleViewController *vc=[[ListArticleViewController alloc] initWithNibName:@"ListArticleViewController" bundle:nil];
    [vc setSiteId:siteObject._siteID];
    [vc loaddataFromSite];
    EzineAppDelegate *appDelegate=(EzineAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:vc animated:YES];
    
}
-(void)labelTap4:(id)sender{
    
    TopsiteCoverObject *siteObject=[_arraySiteLabel objectAtIndex:3];

    ListArticleViewController *vc=[[ListArticleViewController alloc] initWithNibName:@"ListArticleViewController" bundle:nil];
    [vc setSiteId:siteObject._siteID];
    [vc loaddataFromSite];
    EzineAppDelegate *appDelegate=(EzineAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:vc animated:YES];
    
}
-(void)labelTap5:(id)sender{
    
    TopsiteCoverObject *siteObject=[_arraySiteLabel objectAtIndex:4];

    
    ListArticleViewController *vc=[[ListArticleViewController alloc] initWithNibName:@"ListArticleViewController" bundle:nil];
    [vc setSiteId:siteObject._siteID];
    [vc loaddataFromSite];
    EzineAppDelegate *appDelegate=(EzineAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:vc animated:YES];
    
}
-(void)labelTap:(id)sender{
    
    NSLog(@"label click article== %d  %@",currentImage,sender);
    SiteObject *siteObject=[[SiteObject alloc] init];

    if (_currentOrientation==UIInterfaceOrientationPortrait||_currentOrientation==UIInterfaceOrientationPortraitUpsideDown) {
        siteObject=[_arraySite objectAtIndex:currentImage];
    }else{
        siteObject=[_arraySiteLandScape objectAtIndex:currentImage];
        
    }
    ListArticleViewController *vc=[[ListArticleViewController alloc] initWithNibName:@"ListArticleViewController" bundle:nil];
    [vc setSiteId:siteObject._siteID];
    [vc loaddataFromSite];
    EzineAppDelegate *appDelegate=(EzineAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:vc animated:YES];
    
}
-(void)labelArticleClick{
    SiteObject *siteObject=[[SiteObject alloc] init];
    
    if (_currentOrientation==UIInterfaceOrientationPortrait||_currentOrientation==UIInterfaceOrientationPortraitUpsideDown) {
        siteObject=[_arraySite objectAtIndex:currentImage];
    }else{
        siteObject=[_arraySiteLandScape objectAtIndex:currentImage];
        
    }
    ArticleModel *model=[[ArticleModel alloc] init];
    model._ArticleID=siteObject._articleID;
    NSLog(@"lable article click  article== %d  ",siteObject._articleID);
    UIViewExtention *view=[[UIViewExtention alloc] initWithFrame:self.view.frame];
    [view setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:view];
    [[EzineAppDelegate instance] showViewInFullScreen:view withModel:model];
    
}
-(void)closeFullScreen{
    for (UIView *view in self.view.subviews) {
        if ([view isMemberOfClass:[UIViewExtention class]]) {
            NSLog(@"close full screen in cover");
            [view removeFromSuperview];
        }
    }
}

#pragma mark-- flipclick
-(void)flipButtonClick:(id)sender{
    if (self.delegate) {
        [self.delegate FlipbuttonClick];
    }
}
@end
