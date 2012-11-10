
//
//  ListNewsViewController.m
//  Ezine
//
//  Created by Admin on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListArticleViewController.h"
#import "ArticleModel.h"
#import "LayoutArticle1.h"
#import "LayoutArticle2.h"
#import "LayoutArticle3.h"
#import "LayoutArticle4.h"
#import "LayoutArticle5.h"
#import "LayoutArticle6.h"
#import "LayoutArticle7.h"

#import "FullScreenView.h"
#import "AFKPageFlipper.h"
#import "EzineAppDelegate.h"
#import "CategoriesController.h"
#import "UIViewExtention.h"
#import "LastestOfSource.h"
#import "RatingInformationController.h"
#import "NSString+HTML.h"

#import "CTView.h"
#import "MarkupParser.h"
#import "ReadBaseOnWeb.h"

@interface ListArticleViewController (private)
-(void)ToPreviousController;
@end

@implementation ListArticleViewController(private)

-(void)ToPreviousController{
    XAppDelegate._isgotoListArticle=NO;
    EzineAppDelegate *appDelegate=(EzineAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController popViewControllerAnimated:YES];
}
@end

@implementation ListArticleViewController
@synthesize flipViewController;
@synthesize wallTitle,gestureRecognizer;
@synthesize popovercontroller;
@synthesize imageLoadingOperation,siteId,chanelId;
@synthesize activityIndicator;
@synthesize observerAdded;
@synthesize cachedDataAllArticle;

//
@synthesize siteNameforArticle,urlLOGoforArticle;
#pragma mark - View LifeCycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    if ( self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self.view setBackgroundColor:[UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:0.9]];
		isInFullScreenMode = FALSE;
        arrayPage = [[NSMutableArray alloc] init];
        arrayData = [[NSMutableArray alloc] init];
        cachedDataAllArticle=[[NSMutableArray alloc] init];
		_isUpdateArticle=NO;
        
        
        
    }
    return self;
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[arrayData release];
    [arrayPage release];
	[gestureRecognizer release];
    [popovercontroller release];
    [wallTitle release];
    
   // [flipViewController release];
    [super dealloc];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    _isgotoDetailArticle=NO;
    chanelId=0;
    // add activityIndicator
       activityIndicator = [[UIActivityIndicatorView alloc] init];
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [self.view addSubview:activityIndicator];
    /*
     Init FlipViewController
     */
    
    
    self.flipViewController = [[MPFlipViewController alloc] initWithOrientation:[self flipViewController:nil orientationForInterfaceOrientation:[UIApplication sharedApplication].statusBarOrientation]];
    self.flipViewController.delegate = self;
    self.flipViewController.dataSource = self;
    CGRect pageViewRect = self.view.bounds;
    NSLog(@"x=== %f  y===%f   w===%f  h===%f",pageViewRect.origin.x,pageViewRect.origin.y,pageViewRect.size.width,pageViewRect.size.height);
    self.flipViewController.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    self.flipViewController.view.frame = pageViewRect;
    
    imgFakeGifAnimation=[[UIImageView alloc] initWithFrame:self.view.frame];
    imgFakeGifAnimation.animationDuration = 1;
    imgFakeGifAnimation.animationRepeatCount = 0;
    
    if (self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        self.flipViewController.view.frame=CGRectMake(0, 0, 768,1004);
        [activityIndicator setFrame:CGRectMake(768/2.0-40, 748/3, 100, 100)];
        
        imgFakeGifAnimation.animationImages=[NSArray arrayWithObjects:[UIImage imageNamed:@"Ezine-loading-H1.png"],[UIImage imageNamed:@"Ezine-loading-H2.png"],[UIImage imageNamed:@"Ezine-loading-H3.png"],[UIImage imageNamed:@"Ezine-loading-H4.png"],[UIImage imageNamed:@"Ezine-loading-H5.png"],[UIImage imageNamed:@"Ezine-loading-H1.png"],nil];
        [imgFakeGifAnimation setFrame:CGRectMake(0, 0, 768, 1004)];
        [imgFakeGifAnimation startAnimating];


    }else if (self.interfaceOrientation==UIInterfaceOrientationLandscapeLeft||self.interfaceOrientation==UIInterfaceOrientationLandscapeRight){
        self.flipViewController.view.frame =CGRectMake(0,0, 1024,748);
        [activityIndicator setFrame:CGRectMake(1024/2.0-40, 1004/3, 100, 100)];
        
        imgFakeGifAnimation.animationImages=[NSArray arrayWithObjects:[UIImage imageNamed:@"Ezine-loading-V1.png"],[UIImage imageNamed:@"Ezine-loading-V2.png"],[UIImage imageNamed:@"Ezine-loading-V3.png"],[UIImage imageNamed:@"Ezine-loading-V4.png"],[UIImage imageNamed:@"Ezine-loading-V5.png"],[UIImage imageNamed:@"Ezine-loading-V6.png"],nil];
        [imgFakeGifAnimation setFrame:CGRectMake(0, 0, 1024, 748)];
        [imgFakeGifAnimation startAnimating];


    }
    activeIndex=0;
    //addImageView
    

    [self addChildViewController:self.flipViewController];
    [self.view addSubview:self.flipViewController.view];
    [self.flipViewController didMoveToParentViewController:self];
    self.view.gestureRecognizers = self.flipViewController.gestureRecognizers;
    
   
    [self.view addSubview:imgFakeGifAnimation];
    
    
//    if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeLeft||[[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeRight) {
//        
//        imgFakeGifAnimation.animationImages=[NSArray arrayWithObjects:[UIImage imageNamed:@"Ezine-loading-V1.png"],[UIImage imageNamed:@"Ezine-loading-V2.png"],[UIImage imageNamed:@"Ezine-loading-V3.png"],[UIImage imageNamed:@"Ezine-loading-V4.png"],[UIImage imageNamed:@"Ezine-loading-V5.png"],[UIImage imageNamed:@"Ezine-loading-V6.png"],nil];
//        [imgFakeGifAnimation setFrame:CGRectMake(0, 0, 1024, 748)];
//        [imgFakeGifAnimation startAnimating];
//         
//    }else if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortrait||[[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortraitUpsideDown){
//        
//        imgFakeGifAnimation.animationImages=[NSArray arrayWithObjects:[UIImage imageNamed:@"Ezine-loading-H1.png"],[UIImage imageNamed:@"Ezine-loading-H2.png"],[UIImage imageNamed:@"Ezine-loading-H3.png"],[UIImage imageNamed:@"Ezine-loading-H4.png"],[UIImage imageNamed:@"Ezine-loading-H5.png"],[UIImage imageNamed:@"Ezine-loading-H1.png"],nil];
//        [imgFakeGifAnimation setFrame:CGRectMake(0, 0, 768, 1004)];
//        [imgFakeGifAnimation startAnimating];
//
//        
//    }
}

-(void)loaddataFromSite{
    [self showActivityIndicator];
        
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSDate *now = [[NSDate alloc] init];
    
    NSString *dateString = [dateFormat stringFromDate:now];
    
    NSLog(@"datestring=== %@ ",dateString);
    
    if(![self connected])
    {
        // not connected
        NSLog(@"Not connected");
        [XAppDelegate.serviceEngine downloadDataOfflineSite:siteId reload:YES onCompletion:^(NSDictionary *data) {
            
            NSMutableArray *dataUpdate=[data objectForKey:@"ListPage"];
            if (dataUpdate&&[dataUpdate count]>0) {
                numberArticle=[data objectForKey:@"TotalArticle"];
                NSLog(@" total article search==== %@",numberArticle);
                timeArticle=[data objectForKey:@"FromTime"];
                _numberPage+=[dataUpdate count];
                [self fetchedData:dataUpdate];

                
            }else{
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"danh sach bai viet" message:@"khong co du lieu" delegate:self cancelButtonTitle:@"done" otherButtonTitles: nil];
                [alert show];
                [alert release];
                HeaderView* headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, self.flipViewController.view.frame.size.width,56)];
                headerView._idSite=self.siteId;
                headerView.delegate=self;
                headerView.nameSiteHeader =self.siteNameforArticle;
                headerView.logoURlforhear =self.urlLOGoforArticle;
                headerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
                [headerView setWallTitleText:@"0"];
                [headerView changeStyleHeader:10];
                NSLog(@"Page number ===%d",self.siteId);
                [headerView rotate:self.interfaceOrientation animation:NO];
                [self.view addSubview:headerView];
                [self hideActivityIndicator];
                
            }
            
        } onError:^(NSError* error) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"danh sach bai viet" message:@"khong co du lieu" delegate:self cancelButtonTitle:@"done" otherButtonTitles: nil];
            [alert show];
            [alert release];
            HeaderView* headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, self.flipViewController.view.frame.size.width,56)];
            headerView._idSite=self.siteId;
            headerView.delegate=self;
            
            headerView.nameSiteHeader =self.siteNameforArticle;
            headerView.logoURlforhear =self.urlLOGoforArticle;
            
            headerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            [headerView setWallTitleText:@"0"];
            [headerView changeStyleHeader:1];
            [headerView rotate:self.interfaceOrientation animation:NO];
            [self.view addSubview:headerView];
            
        }];
        
    } else
    {
        // connected, do some internet stuff
        
        NSLog(@"Connected");
        if (self.siteId==-2) {
            [XAppDelegate.serviceEngine getListBookmarkFromtime:dateString numberPage:10  onCompletion:^(NSDictionary* data) {
                NSMutableArray *dataUpdate=[data objectForKey:@"ListPage"];
                if (dataUpdate&&[dataUpdate count]>0) {
                    numberArticle=[data objectForKey:@"TotalArticle"];
                    NSLog(@" total article search==== %@",numberArticle);
                    timeArticle=[data objectForKey:@"FromTime"];
                    _numberPage+=[dataUpdate count];
                    [self fetchedData:dataUpdate];
                }
                
            } onError:^(NSError* error) {
            }];
            
        }else{
            [XAppDelegate.serviceEngine getListArticleInsite:siteId FromTime:dateString numberOffPage:10 onCompletion:^(NSDictionary* data) {
                
                NSMutableArray *dataUpdate=[data objectForKey:@"ListPage"];
                if (dataUpdate&&[dataUpdate count]>0) {
                    numberArticle=[data objectForKey:@"TotalArticle"];
                    NSLog(@" total article search==== %@",numberArticle);
                    timeArticle=[data objectForKey:@"FromTime"];
                    _numberPage+=[dataUpdate count];
                    [self fetchedData:dataUpdate];
                    
                }else{
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"danh sach bai viet" message:@"khong co du lieu" delegate:self cancelButtonTitle:@"done" otherButtonTitles: nil];
                    [alert show];
                    [alert release];
                    HeaderView* headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, self.flipViewController.view.frame.size.width,56)];
                    headerView._idSite=self.siteId;
                    headerView.delegate=self;
                    headerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
                    [headerView setWallTitleText:@"0"];
                    [headerView changeStyleHeader:self.siteId];
                    [headerView rotate:self.interfaceOrientation animation:NO];
                    [self.view addSubview:headerView];
                    [self hideActivityIndicator];
                    
                }
                
            } onError:^(NSError* error) {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"danh sach bai viet" message:@"khong co du lieu" delegate:self cancelButtonTitle:@"done" otherButtonTitles: nil];
                [alert show];
                [alert release];
                HeaderView* headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, self.flipViewController.view.frame.size.width,56)];
                headerView._idSite=self.siteId;
                headerView.delegate=self;
                headerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
                [headerView setWallTitleText:@"0"];
                [headerView changeStyleHeader:self.siteId];
                [headerView rotate:self.interfaceOrientation animation:NO];
                [self.view addSubview:headerView];
                
            }];
            //           [XAppDelegate.serviceEngine GetListArticleInSitePagingID:siteId onCompletion:^(NSMutableArray* data) {
            //              [self fetchedData:data];
            //
            //          } onError:^(NSError* error) {
            //            [self hideActivityIndicator];
            //               UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Can not connect to service" delegate:self cancelButtonTitle:@"done" otherButtonTitles: nil];
            //               [alert show];
            //                [alert release];
            //                [self ToPreviousController];
            //        
            //            }];
            
        }

    }
    
            
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


#pragma mark - Handle Orientation change

-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeLeft||[[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeRight) {
        [self.flipViewController.view setFrame:CGRectMake(0, 0, 1024, 748 )];
        [activityIndicator setFrame:CGRectMake(1024/2.0-40, 748/3, 100, 100)];
        if (!imgFakeGifAnimation) {
            return;
        }
        [imgFakeGifAnimation stopAnimating];
        imgFakeGifAnimation.animationImages=[NSArray arrayWithObjects:[UIImage imageNamed:@"Ezine-loading-V1.png"],[UIImage imageNamed:@"Ezine-loading-V2.png"],[UIImage imageNamed:@"Ezine-loading-V3.png"],[UIImage imageNamed:@"Ezine-loading-V4.png"],[UIImage imageNamed:@"Ezine-loading-V5.png"],[UIImage imageNamed:@"Ezine-loading-V6.png"],nil];
        [imgFakeGifAnimation setFrame:CGRectMake(0, 0, 1024, 748)];
        [imgFakeGifAnimation startAnimating];
        
        [UIView commitAnimations];
        
    }else if([[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortrait||[[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortraitUpsideDown){
        [self.flipViewController.view setFrame:CGRectMake(0, 0,768, 1004)];
        [activityIndicator setFrame:CGRectMake(768/2.0-40, 1004/3, 100, 100)];
        if (!imgFakeGifAnimation) {
            return;
        }
        [imgFakeGifAnimation stopAnimating];
        
        imgFakeGifAnimation.animationImages=[NSArray arrayWithObjects:[UIImage imageNamed:@"Ezine-loading-H1.png"],[UIImage imageNamed:@"Ezine-loading-H2.png"],[UIImage imageNamed:@"Ezine-loading-H3.png"],[UIImage imageNamed:@"Ezine-loading-H4.png"],[UIImage imageNamed:@"Ezine-loading-H5.png"],[UIImage imageNamed:@"Ezine-loading-H1.png"],nil];
        [imgFakeGifAnimation setFrame:CGRectMake(0, 0, 768, 1004)];
        [imgFakeGifAnimation startAnimating];
        
        [UIView commitAnimations];

    }
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft||toInterfaceOrientation==UIInterfaceOrientationLandscapeRight||toInterfaceOrientation==UIInterfaceOrientationPortrait||toInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown);
    
}


#pragma mark - Init Layout for view after load service

#pragma mark-----
-(void)fetchedData:(NSMutableArray *)data{
    NSLog(@"cached Article");

    if ([data isEqualToArray:cachedDataAllArticle]) {
        NSLog(@"cached Article");
        return;
    }
    if (data ==nil||[data count]==0) {
        EzineAppDelegate *appDelegate=(EzineAppDelegate*)[[UIApplication sharedApplication] delegate];
        [appDelegate.navigationController popViewControllerAnimated:YES];
        NSLog(@"Datatatatata:Coming");
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Bài viết mới nhất" message:@"không có dữ liệu, chuyển sang đọc offline" delegate:self cancelButtonTitle:@"thoát" otherButtonTitles: nil];
        [alert show];
        [alert release];
        [self hideActivityIndicator];
        
        
    }
    if ((NSNull *)data!=[NSNull null] && [data count]>0) {
        if (cachedDataAllArticle) {
            [cachedDataAllArticle removeAllObjects];
            cachedDataAllArticle=nil;
        }
        cachedDataAllArticle=[[NSMutableArray alloc] initWithArray:data copyItems:YES];
        _numberPage=[data count];
        [self buildPages:data];
        activeIndex=0;
        if (!_isgotoDetailArticle) {
            [self.flipViewController setViewController:[arrayPage objectAtIndex:activeIndex] direction:MPFlipViewControllerDirectionForward animated:YES completion:nil];
            
        }
        
    }
    [self hideActivityIndicator];
}

-(NSMutableArray *)arrayArticleFromDic:(NSDictionary *)dic{
    NSMutableArray *arrReturn = [[NSMutableArray alloc] init];
    NSArray *arr=[dic objectForKey:@"ListArticle"];
    
    for (NSDictionary *article in arr) {
        ArticleModel* obj = [[ArticleModel alloc] initWithItemObject:article];
        obj._idLayout=[[dic objectForKey:@"LayoutID"] intValue];
        
        _LastArticleTime=[article objectForKey:@"PublishTime"];
        obj.DictForArticleDetail =[article objectForKey:@"ArticleDetail"];
        obj.nameSite =[article objectForKey:@"SiteName"];
        obj.icon =[article objectForKey:@"SiteLogoUrl"];
        
        siteNameforArticle =[article objectForKey:@"SiteName"];
        urlLOGoforArticle = [article objectForKey:@"SiteLogoUrl"];
        
        
        [arrReturn addObject:obj];
        [obj release];
    }
    [[NSUserDefaults standardUserDefaults] setObject:siteNameforArticle forKey:@"SiteNameOfLine"];
    [[NSUserDefaults standardUserDefaults] setObject:urlLOGoforArticle forKey:@"SiteLogoUrlofLine"];
    return arrReturn;
}

-(void)buildPages:(NSMutableArray*)messageArray  {
    if (arrayPage) {
        [self.flipViewController.left setEnabled:NO];
        [self.flipViewController.right setEnabled:NO];
       // [arrayPage removeAllObjects];
    }
    for (NSDictionary * page in messageArray) {
        LayoutViewExtention* layoutToReturn = nil;
        int idLayOut=[[page objectForKey:@"LayoutID"] integerValue];
        Class class =  NSClassFromString([NSString stringWithFormat:@"LayoutArticle%d",idLayOut]);
		id layoutObject = [[[class alloc] init] autorelease];
        
		
		if ([layoutObject isKindOfClass:[LayoutViewExtention class]] ) {
			
			layoutToReturn = (LayoutViewExtention*)layoutObject;
			layoutToReturn.delegate=self;
			[layoutToReturn initalizeViews:[self arrayArticleFromDic:page]];
			[layoutToReturn rotate:self.interfaceOrientation animation:NO];
            [layoutToReturn.view setFrame:self.flipViewController.view.frame];
			layoutToReturn.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
			
			HeaderView* headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, self.flipViewController.view.frame.size.width,56)];
            headerView._idSite=self.siteId;
            headerView.delegate=self;
			headerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
			[headerView setWallTitleText:numberArticle];
            [headerView changeStyleHeader:idLayOut];
			[headerView rotate:self.interfaceOrientation animation:NO];
			[layoutToReturn setHeaderView:headerView];
			[headerView release];
			
			FooterView* footerView = [[FooterView alloc] initWithFrame:CGRectMake(0, layoutToReturn.view.frame.size.height - 50, layoutToReturn.view.frame.size.width, 50)];
			[footerView setBackgroundColor:[UIColor whiteColor]];
            ///================================================
            footerView.deletegate=self;
            footerView._timeArticle=timeArticle;
            footerView._numberAllpage=_numberPage;
			[footerView setViewArray:arrayPage];
			
			if (self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
				[footerView setFrame:CGRectMake(0, 1004 - 50, 768, footerView.frame.size.height)];
			}else {
				[footerView setFrame:CGRectMake(0, 748 - 50, 1024, footerView.frame.size.height)];
			}
			[footerView rotate:self.interfaceOrientation animation:YES];
			
			[layoutToReturn setFooterView:footerView];
			[footerView release];
            [arrayPage addObject:layoutToReturn];
            layoutToReturn=nil;
        }
    }
    [self.flipViewController.left setEnabled:YES];
    [self.flipViewController.right setEnabled:YES];
    if (imgFakeGifAnimation) {
        [imgFakeGifAnimation removeFromSuperview];

    }
    
    NSLog(@"page=== %d",[arrayPage count]);
}

-(void)showViewInFullScreen:(UIView*)viewToShow withModel:(ArticleModel*)model{
    NSLog(@" showViewInFullScreen");
    if (model._idLayout==-10) {
        [self.popovercontroller dismissPopoverAnimated:YES];
    }
    _isgotoDetailArticle=YES;
    [self.flipViewController.left setEnabled:NO];
    [self.flipViewController.right setEnabled:NO];
	if (!isInFullScreenMode) {
		isInFullScreenMode = TRUE;
		
		CGRect bounds = [UIScreen mainScreen].bounds;
		if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
			CGFloat width = bounds.size.width;
			bounds.size.width = bounds.size.height;
			bounds.size.height = width;
		}
		
		
		fullScreenBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, bounds.size.height)];
		fullScreenBGView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		[fullScreenBGView setBackgroundColor:RGBACOLOR(0,0,0,0.6)];
		fullScreenBGView.alpha = 0;
		[self.view addSubview:fullScreenBGView];
		
		
		viewToShowInFullScreen = (UIViewExtention*)viewToShow;
		viewToShowInFullScreen.originalRect = viewToShowInFullScreen.frame;
		viewToShowInFullScreen.isFullScreen = TRUE;
		FullScreenView* fullView = [[FullScreenView alloc] initWithModel:model];
		fullView.frame = fullScreenBGView.frame;
        fullView.deletate =self;
        
        fullView.siteNameforFullScr =self.siteNameforArticle;
        fullView.urlLogoforFullSrc =self.urlLOGoforArticle;
        NSLog(@"fullView.siteNameforFullScr%@",fullView.siteNameforFullScr);
        
		fullView.viewToOverLap = viewToShowInFullScreen;
		fullView.fullScreenBG = fullScreenBGView;
		fullScreenView = fullView;
		[self.view addSubview:fullView];
		
		[self.view bringSubviewToFront:fullScreenBGView];
		[self.view bringSubviewToFront:fullView];
		
		[UIView beginAnimations:@"SHOWFULLSCREEN" context:NULL];
		[UIView setAnimationDuration:0.40];
		[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:nil cache:NO];
		fullScreenBGView.alpha = 1;
		if (self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
			[fullView setFrame:CGRectMake(0, 0, 768, 1004)];
		}else {
			[fullView setFrame:CGRectMake(0, 0, 1024, 746)];
		}
		[fullScreenView rotate:self.interfaceOrientation animation:YES];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(animationEnd:finished:context:)];
		[UIView commitAnimations];
		
	}
    
	
}

-(void)closeFullScreen {
    NSLog(@"closeFullScreen");
    _isgotoDetailArticle=NO;
    
    [self.flipViewController.left setEnabled:YES];
    [self.flipViewController.right setEnabled:YES];
    
	if (fullScreenView != nil) {
		fullScreenBGView.alpha=0;
		[fullScreenBGView removeFromSuperview];
		[fullScreenBGView release];
		
		fullScreenView.alpha = 0;
		[fullScreenView removeFromSuperview];
		[fullScreenView release];
		fullScreenView = nil;
		isInFullScreenMode = FALSE;
	}
    NSLog(@"site id === %d",self.siteId);
    if (self.siteId==0) {
        [self ToPreviousController];
    }
    
}


#pragma mark - Handle Menu Click

-(void)ezineButtonClicked:(id)sender{
    NSLog(@"EzineClick");
    [self ToPreviousController];
}

-(void)themButtonClicked:(id)sender{
   
}

-(void)listButtonClicked:(UIButton *)sender{
    if (!lastestOfSourceController) {
        lastestOfSourceController =[[LastestOfSource alloc] init];
        lastestOfSourceController._siteId=sender.tag;
        [lastestOfSourceController getLastestSource];
    }
    NSLog(@"list source: %d",[sender tag]);
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:lastestOfSourceController];
    
    UIPopoverController* listPopover = [[UIPopoverController alloc]
                                        initWithContentViewController:navController];
    listPopover.delegate =self;
    [navController release];
    self.popovercontroller =listPopover;
    [listPopover release];
    [self.popovercontroller presentPopoverFromRect:sender.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}

-(void)showCategoryOfSource:(UIButton *)sender inRect:(CGRect)frame{
    if (!listCatelogiesController) {
        listCatelogiesController =[[ListCategoriesOfSource alloc] init];
        listCatelogiesController._idSite=[sender tag];
    }
    
    listCatelogiesController.delegate=self;
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:listCatelogiesController];
    UIPopoverController* listPopover = [[UIPopoverController alloc]
                                        initWithContentViewController:navController];
    listPopover.delegate =self;
    [navController release];
    self.popovercontroller =listPopover;
    [listPopover release];
    [self.popovercontroller presentPopoverFromRect:frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}


#pragma mark - MPFlipViewControllerDelegate protocol

- (void)flipViewController:(MPFlipViewController *)flipViewController didFinishAnimating:(BOOL)finished previousViewController:(UIViewController*)previousViewController transitionCompleted:(BOOL)completed{
	if (completed){
		
	}
}

- (MPFlipViewControllerOrientation)flipViewController:(MPFlipViewController *)flipViewController orientationForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
		return UIInterfaceOrientationIsPortrait(orientation)? MPFlipViewControllerOrientationVertical : MPFlipViewControllerOrientationHorizontal;
	else
		return MPFlipViewControllerOrientationHorizontal;
}

#pragma mark - MPFlipViewControllerDataSource protocol

- (UIViewController *)flipViewController:(MPFlipViewController *)flipViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    activeIndex--;
    if (activeIndex>=0) {
        LayoutViewExtention *layout=[arrayPage objectAtIndex:activeIndex];
        LayoutViewExtention *layout1=[arrayPage objectAtIndex:activeIndex+1];
        layout._interaceOrientation=layout1._interaceOrientation;
        
        [layout rotate:layout._interaceOrientation animation:YES];
        return layout;
    }else{
        activeIndex++;
        return nil;
    }
    
}

- (UIViewController *)flipViewController:(MPFlipViewController *)flipViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    activeIndex++;
    if (activeIndex>=[arrayPage count]-5&&_isUpdateArticle==NO&&[arrayPage count]>=10) {
        _isUpdateArticle=YES;
        NSLog(@"activeIndex==%d  page==%d  time=== %@",activeIndex,[arrayPage count],_LastArticleTime);
        [self updateListArticle];
    }
    if (activeIndex<=[arrayPage count]-1) {
        LayoutViewExtention *layout=[arrayPage objectAtIndex:activeIndex];
        LayoutViewExtention *layout1=[arrayPage objectAtIndex:activeIndex-1];
        layout._interaceOrientation=layout1._interaceOrientation;
        [layout rotate:layout._interaceOrientation animation:YES];
        return layout;
    }else{
        activeIndex--;
        return nil;
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

#pragma mark---
-(void)RotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    NSLog(@"RotateToInterfaceOrientation");
    for (LayoutViewExtention *layout in arrayPage) {
        [layout rotate:toInterfaceOrientation animation:YES];
    }
}

#pragma mark--- update article
- (void) updateListArticle{
    NSLog(@"update time=== %@",_LastArticleTime);
    if (_isSearchAllSite) {
        NSString *keyWord=[[NSUserDefaults standardUserDefaults] objectForKey:@"KEYWORDSEARCHALLSITE"];
        [XAppDelegate.serviceEngine getListArticleSearchInAllsite:keyWord FromTime:_LastArticleTime numberOffPage:20 onCompletion:^(NSDictionary* data) {
            
            NSMutableArray *dataUpdate=[data objectForKey:@"ListPage"];
            if (dataUpdate&&[dataUpdate count]>0) {
                NSLog(@" data search==== %d",dataUpdate.count);

                timeArticle=[data objectForKey:@"FromTime"];
                _numberPage+=[dataUpdate count];
                [self buildPages:dataUpdate];
                _isUpdateArticle=NO;

            }
            
        } onError:^(NSError* error) {
        }];
        
    }else if (_isSearchInSite){
        NSString *keyword=[[NSUserDefaults standardUserDefaults] objectForKey:@"KEYWORDSEARCHALLSITE"];

        [XAppDelegate.serviceEngine getListArticleSearchInSite:siteId  inchanelID:chanelId KeyWold:keyword FromTime:_LastArticleTime numberOffPage:20 onCompletion:^(NSDictionary* data) {
            
            NSMutableArray *dataUpdate=[data objectForKey:@"ListPage"];
            if (dataUpdate&&[dataUpdate count]>0) {
                NSLog(@" data search==== %d",dataUpdate.count);
                timeArticle=[data objectForKey:@"FromTime"];
                _numberPage+=[dataUpdate count];
                [self buildPages:dataUpdate];
                _isUpdateArticle=NO;

            }
            
        } onError:^(NSError* error) {
        }];

    }else if (self.siteId==-2){
        [XAppDelegate.serviceEngine getListBookmarkFromtime:_LastArticleTime numberPage:20  onCompletion:^(NSDictionary* data) {
            NSMutableArray *dataUpdate=[data objectForKey:@"ListPage"];
            if (dataUpdate&&[dataUpdate count]>0) {
                NSLog(@" data search==== %d",dataUpdate.count);
                timeArticle=[data objectForKey:@"FromTime"];
                _numberPage+=[dataUpdate count];
                [self buildPages:dataUpdate];
                _isUpdateArticle=NO;

            }
            
        } onError:^(NSError* error) {
        }];

    } else{
        [XAppDelegate.serviceEngine getListArticleUpdateInSitePagingID:siteId inchanelID:chanelId FromTime:_LastArticleTime numberOffPage:20 onCompletion:^(NSDictionary* data) {
            NSMutableArray *dataUpdate=[data objectForKey:@"ListPage"];
            if (dataUpdate&&[dataUpdate count]>0) {
                timeArticle=[data objectForKey:@"FromTime"];
                NSLog(@" data update==== %d",dataUpdate.count);
                _numberPage+=[dataUpdate count];
                [self buildPages:dataUpdate];
                _isUpdateArticle=NO;
                
            }
            
        } onError:^(NSError* error) {
            
        }];
        

    }
    
        
}

-(void)shareEmail{
    
    NSLog(@"HHHahahahah");
    [self shareEmailPlease];
}

-(void)ReadBaseOnWeb:(NSString *)url{
    
    NSString *urlweb=url;
    ReadBaseOnWeb* readonWeb =[[ReadBaseOnWeb alloc]initWithNibName:@"ReadBaseOnWeb" bundle:nil];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:readonWeb];
    readonWeb.urlWeb=urlweb;
    navController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    navController.modalPresentationStyle = UIModalPresentationFormSheet;
    [readonWeb.view setFrame:CGRectMake(0, 20, 768, 1004)];
    CGRect menuFrame=readonWeb.view.frame;
    menuFrame.origin.y=20;
    
    [ self.navigationController pushViewController:readonWeb animated:YES];
    //[self presentModalViewController:readonWeb animated:YES];
    [readonWeb release];
    
}

-(void) shareEmailPlease{
    
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

#pragma mark---load data search keyword allsite
- (void) loaddataFromSearchKeyWord:(NSString*)keyWord{
    [self showActivityIndicator];
    _isUpdateArticle=NO;
    
    [[NSUserDefaults standardUserDefaults]setObject:keyWord forKey:@"KEYWORDSEARCHALLSITE"];
    
    _isSearchAllSite=YES;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSDate *now = [[NSDate alloc] init];
    
    NSString *dateString = [dateFormat stringFromDate:now];
    
    NSLog(@"datestring=== %@ %@",dateString,keyWord);
    [XAppDelegate.serviceEngine getListArticleSearchInAllsite:keyWord FromTime:dateString numberOffPage:10 onCompletion:^(NSDictionary* data) {
        [self hideActivityIndicator];
        NSLog(@" data search==== %@",data);
        
        timeArticle=[data objectForKey:@"FromTime"];
        NSMutableArray *dataUpdate=[data objectForKey:@"ListPage"];
        if (dataUpdate&&[dataUpdate count]>0) {
            numberArticle=[data objectForKey:@"TotalArticle"];
            NSLog(@" total article search==== %@",numberArticle);
            _numberPage+=[dataUpdate count];
            [self fetchedData:dataUpdate];
            
        }else{
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"tim kiem keyword" message:@"khong co du lieu" delegate:self cancelButtonTitle:@"done" otherButtonTitles: nil];
            [alert show];
            [alert release];
            HeaderView* headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, self.flipViewController.view.frame.size.width,56)];
            headerView._idSite=self.siteId;
            headerView.delegate=self;
			headerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
			[headerView setWallTitleText:@"0"];
            [headerView changeStyleHeader:self.siteId];
			[headerView rotate:self.interfaceOrientation animation:NO];
            [self.view addSubview:headerView];

        }
        
    } onError:^(NSError* error) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"tim kiem keyword" message:@"khong co internet hoac server bi loi" delegate:self cancelButtonTitle:@"done" otherButtonTitles: nil];
        [alert show];
        [alert release];
        HeaderView* headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, self.flipViewController.view.frame.size.width,56)];
        headerView._idSite=self.siteId;
        headerView.delegate=self;
        headerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [headerView setWallTitleText:@"0"];
        [headerView changeStyleHeader:self.siteId];
        [headerView rotate:self.interfaceOrientation animation:NO];
        [self.view addSubview:headerView];

        [self hideActivityIndicator];

    }];
}
#pragma mark----load data search keyword current site


#pragma mark-- footer delegate
-(void)btnbockClick:(int)indext{
    NSLog(@"page=== %d   movepage===%d",activeIndex,indext);
    BOOL forward;
    if (indext-1>activeIndex%10) {
        forward=YES;
    }else{
        forward=NO;
    }
    LayoutViewExtention *layout1=[arrayPage objectAtIndex:activeIndex];
    activeIndex=((int)activeIndex/10)*10+indext-1;
    LayoutViewExtention *layout=[arrayPage objectAtIndex:activeIndex];
    layout._interaceOrientation=layout1._interaceOrientation;
    [layout rotate:layout._interaceOrientation animation:YES];

    if (forward) {
        [self.flipViewController setViewController:layout direction:MPFlipViewControllerDirectionForward animated:YES completion:nil];
    }else{
        [self.flipViewController setViewController:layout direction:MPFlipViewControllerDirectionReverse animated:YES completion:nil];
    }
    if (activeIndex>=[arrayPage count]-5&&_isUpdateArticle==NO&&[arrayPage count]>=10) {
        _isUpdateArticle=YES;
        NSLog(@"activeIndex==%d  page==%d  time=== %@",activeIndex,[arrayPage count],_LastArticleTime);
        [self updateListArticle];
    }
        
}

-(void)searchKeywork:(id)sender{
    UIButton *searchbutton=(UIButton*)sender;
    
    SearchKeyWordViewController *SearchkeyWord=[[SearchKeyWordViewController alloc] init];
    SearchkeyWord.delegate=self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:SearchkeyWord];
    
    UIPopoverController* listPopover = [[UIPopoverController alloc]
                                        initWithContentViewController:navController];
    listPopover.delegate =self;
    [navController release];
    self.popovercontroller =listPopover;
    [listPopover release];
    CGRect frame=searchbutton.frame;
    frame.origin.y=self.view.frame.size.height-frame.origin.y-40;
    [self.popovercontroller presentPopoverFromRect:frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}

#pragma mark--SearchKeyWordViewControllerdelegate
-(void) loadDataFromSearchInSite:(NSString *)keyword{
    [self showActivityIndicator];
    _isSearchInSite=YES;
    _isSearchAllSite=NO;
    [[NSUserDefaults standardUserDefaults]setObject:keyword forKey:@"KEYWORDSEARCHALLSITE"];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSDate *now = [[NSDate alloc] init];
    
    NSString *dateString = [dateFormat stringFromDate:now];
    
    NSLog(@"datestring=== %@ %@ %d",dateString,keyword,siteId);
    [XAppDelegate.serviceEngine getListArticleSearchInSite:siteId inchanelID:chanelId KeyWold:keyword FromTime:dateString numberOffPage:10 onCompletion:^(NSDictionary* data) {
        [self hideActivityIndicator];
        timeArticle=[data objectForKey:@"FromTime"];
        NSMutableArray *dataUpdate=[data objectForKey:@"ListPage"];
        if (dataUpdate&&[dataUpdate count]>0) {
            numberArticle=[data objectForKey:@"TotalArticle"];
            NSLog(@" total article search==== %@",numberArticle);

            [self fetchedData:dataUpdate];
        }else{
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"tim kiem keyword" message:@"khong co du lieu" delegate:self cancelButtonTitle:@"done" otherButtonTitles: nil];
            [alert show];
            [alert release];
            HeaderView* headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, self.flipViewController.view.frame.size.width,56)];
            headerView._idSite=self.siteId;
            headerView.delegate=self;
			headerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
			[headerView setWallTitleText:@"0"];
            [headerView changeStyleHeader:self.siteId];
			[headerView rotate:self.interfaceOrientation animation:NO];
            [self.view addSubview:headerView];
        }
        
    } onError:^(NSError* error) {
        [self hideActivityIndicator];
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"tim kiem keyword" message:@"khong co internet hoac server bi loi" delegate:self cancelButtonTitle:@"done" otherButtonTitles: nil];
        [alert show];
        [alert release];
        HeaderView* headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, self.flipViewController.view.frame.size.width,56)];
        headerView._idSite=self.siteId;
        headerView.delegate=self;
        headerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [headerView setWallTitleText:@"0"];
        [headerView changeStyleHeader:self.siteId];
        [headerView rotate:self.interfaceOrientation animation:NO];
        [self.view addSubview:headerView];
        
        [self hideActivityIndicator];

    }];

}
-(void)searchKeywordClick:(NSString *)keyword{
    [self.popovercontroller dismissPopoverAnimated:YES];

    NSLog(@"keyworld==== %d  %@",siteId,keyword);
    if (cachedDataAllArticle) {
        [cachedDataAllArticle removeAllObjects];
        cachedDataAllArticle=nil;

    }
       //======
    ListArticleViewController *vc=[[ListArticleViewController alloc] initWithNibName:@"ListArticleViewController" bundle:nil];
    [vc setSiteId:siteId];
    [vc setChanelId:self.chanelId];
    [vc loadDataFromSearchInSite:keyword];
    EzineAppDelegate *appDelegate=(EzineAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:vc animated:YES];
    
    
}

#pragma mark---- list categorieOfSource delegate
- (void)categorySelectionChanged:(CategoryModel *)curSelection{
    NSLog(@"CategoryModel====   %@",curSelection.title);
    [self.popovercontroller dismissPopoverAnimated:YES];
    if (self.chanelId==curSelection.sourceId) {
        return;
    }

    if (cachedDataAllArticle) {
        [cachedDataAllArticle removeAllObjects];
        cachedDataAllArticle=nil;
        
    }
    //======
    ListArticleViewController *vc=[[ListArticleViewController alloc] initWithNibName:@"ListArticleViewController" bundle:nil];
    [vc setSiteId:siteId];
    [vc loadDataFromChanel:curSelection.sourceId];
    EzineAppDelegate *appDelegate=(EzineAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:vc animated:YES];

}

#pragma mark----- load Article in a chanel
- (void) loadDataFromChanel:(int)chanel{
    _isGetArticleInchanel=YES;
    [self showActivityIndicator];
        self.chanelId=chanel;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSDate *now = [[NSDate alloc] init];
    
    NSString *dateString = [dateFormat stringFromDate:now];
    [XAppDelegate.serviceEngine getListArticleChanelInsite:siteId chanelID:chanel FromTime:dateString numberOffPage:10 onCompletion:^(NSDictionary* data) {
        
        NSMutableArray *dataUpdate=[data objectForKey:@"ListPage"];
        if (dataUpdate&&[dataUpdate count]>0) {
            numberArticle=[data objectForKey:@"TotalArticle"];
            NSLog(@" total article search==== %@",numberArticle);
            timeArticle=[data objectForKey:@"FromTime"];
            _numberPage+=[dataUpdate count];
            [self fetchedData:dataUpdate];
            
        }else{
//            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"danh sach bai viet" message:@"khong co du lieu" delegate:self cancelButtonTitle:@"done" otherButtonTitles: nil];
//            [alert show];
//            [alert release];
//            HeaderView* headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, self.flipViewController.view.frame.size.width,56)];
//            headerView._idSite=self.siteId;
//            headerView.delegate=self;
//            headerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//            [headerView setWallTitleText:@"0"];
//            [headerView changeStyleHeader:self.siteId];
//            [headerView rotate:self.interfaceOrientation animation:NO];
//            [self.view addSubview:headerView];
            [self hideActivityIndicator];
            
        }
        
    } onError:^(NSError* error) {
//        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"danh sach bai viet" message:@"khong co du lieu" delegate:self cancelButtonTitle:@"done" otherButtonTitles: nil];
//        [alert show];
//        [alert release];
//        HeaderView* headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, self.flipViewController.view.frame.size.width,56)];
//        headerView._idSite=self.siteId;
//        headerView.delegate=self;
//        headerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//        [headerView setWallTitleText:@"0"];
//        [headerView changeStyleHeader:self.siteId];
//        [headerView rotate:self.interfaceOrientation animation:NO];
//        [self.view addSubview:headerView];
        
    }];

}

#pragma mark CHeck Internet Avalable=============
-(BOOL)connected{
   
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    
    return !(networkStatus == NotReachable);
     NSLog(@"Status==%d",!(networkStatus == NotReachable));
}


@end