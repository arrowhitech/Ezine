//
//  MyLauncherViewController.m
//  Ezine
//
//  Created by PDG2 on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyLauncherViewController.h"
#import "HeaderView.h"
#import "MyLauncherFooter.h"
#import "UIViewController+MJPopupViewController.h"
#import "RatingInformationController.h"
#import "ListArticleViewController.h"
#import "EzineAppDelegate.h"
#import "IASKSpecifier.h"
#import "IASKSettingsReader.h"
#import "SettingDeleteDataView.h"
#import "DownloadDataOfflineViewController.h"

static const float GAP = 10;
static const int colsInPortrait = 3;
static const int colsInLandscape = 4;
static const float animationDuration = 0.5;
static const int spaceHeder = 75;
static const int spaceBottom = 50;

@interface MyLauncherViewController(Private)
-(void) initalizeHeader;
-(void) goListArticles;
@end

@implementation MyLauncherViewController(Private)
-(void)initalizeHeader{
    MyLauncherHeader* headerView = [[MyLauncherHeader alloc] initWithFrame:CGRectMake(0,0,screenBounds.size.width, 75)];
    headerView.delegate=self;
    headerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [headerView setWallTitleText:@"My Tweet"];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:headerView];
    
}
-(void)goListArticles{
    ListArticleViewController *vc=[[ListArticleViewController alloc] initWithNibName:@"ListArticleViewController" bundle:nil];
    EzineAppDelegate *appDelegate=(EzineAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:vc animated:YES];
}

@end


@implementation MyLauncherViewController
@synthesize appSettingController;
@synthesize _currentPage;
@synthesize launcherView;
@synthesize delegate;
@synthesize popovercontroller;

#pragma mark - View LifeCycle

-(id)init
{
	if((self = [super init]))
	{
        
	}
	return self;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload{
    [super viewDidUnload];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)dealloc{
	[launcherView release];
    [super dealloc];
}

-(void)loadView
{
    
	[super loadView];
    screenBounds= [[UIScreen mainScreen] bounds];
	UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenBounds.size.width, screenBounds.size.height)];
    [view setBackgroundColor:[UIColor whiteColor]];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view = view;
    
    //init header and footer
    [self initalizeHeader];
    [[UIDevice currentDevice] orientation] ;
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged) name:UIDeviceOrientationDidChangeNotification object:nil];
    
}
#pragma mark - Orientation Changed
-(void)orientationChanged{
    NSLog(@"orientation change in mylauncher");
    if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeLeft||[[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeRight) {
        [self.view setFrame:CGRectMake(0, 0, 1024, 748)];
        [footer setFrame:CGRectMake(0,748-spaceBottom,1004, spaceBottom)];
        
    }else if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortrait||[[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortraitUpsideDown){
        [self.view setFrame:CGRectMake(0, 0, 768, 1004)];
        [footer setFrame:CGRectMake(0,1004-spaceBottom,768, spaceBottom)];
        
    }
    
    
}

-(void)rotate{
    [launcherView layoutLauncher];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
	return (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft||toInterfaceOrientation==UIInterfaceOrientationLandscapeRight||toInterfaceOrientation==UIInterfaceOrientationPortrait||toInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown);
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    NSLog(@"didRotateFromInterfaceOrientation");
	[launcherView layoutLauncher];
}


#pragma mark - Init View

-(void)initalizeViews{
    
    [self.view reloadInputViews];
    if (launcherView) {
        [launcherView removeFromSuperview];
        launcherView=nil;
    }
    launcherView = [[MyLauncherView alloc] initWithFrame:CGRectMake(GAP+5,spaceHeder,screenBounds.size.width-GAP*2,screenBounds.size.height-20-spaceHeder-spaceBottom)];
	[launcherView setBackgroundColor:[UIColor whiteColor]];
	[launcherView setDelegate:self];
    launcherView._currentPage=_currentPage;
    launcherView._numberPage=_numberpage;

    [self.view addSubview:launcherView];
    for (UIView *view in self.view.subviews) {
        for (UIView *view1 in view.subviews) {
            if (category.view==view1) {
                [self.view bringSubviewToFront:view];
                break;
            }
        }
    }
    
    [self initFooterView];
}

-(void)initFooterView{
    footer = [[MyLauncherFooter alloc] initWithFrame:CGRectMake(0,screenBounds.size.height-20-spaceBottom,screenBounds.size.width, spaceBottom)];
    footer.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    footer.delegate=self;
    [footer setWallTitleText:@"0"];
    [footer setBackgroundColor:[UIColor whiteColor]];
    [footer setPageNumber:_currentPage andTotalPage:[XAppDelegate._arrayAllSite count]/12+1];
    [self.view addSubview:footer];

}

-(void)reLoad{
    launcherView.itemsAdded=NO;
    for (UIView *view in self.launcherView.subviews) {
        [view removeFromSuperview];
    }
    
    // Get list site for this page
    NSArray *soucre;
    int rangeFrom = 0;
    
    if (_currentPage>1) {
        rangeFrom = (_currentPage - 1)*12-1;
    }
    
    int rangeTo  = 0;
    if (_currentPage==1) {
        if ([XAppDelegate._arrayAllSite count]>= 11) {
            rangeTo=11;
        }else rangeTo=[XAppDelegate._arrayAllSite count];
    }else{
        if (_currentPage*12-1<=[XAppDelegate._arrayAllSite count]) {
            rangeTo=12;
        }else rangeTo = [XAppDelegate._arrayAllSite count]-rangeFrom;
    }
    
    if (rangeFrom>[XAppDelegate._arrayAllSite count]-1) {
        [launcherView setPages:nil];
        return;
    }
    soucre = [XAppDelegate._arrayAllSite subarrayWithRange:NSMakeRange(rangeFrom, rangeTo)];
    
    
    
    NSMutableArray *array=[[NSMutableArray alloc] init];;
    for (int i=0 ;i <[soucre count];i++) {
        [array addObject:[[[MyLauncherItem alloc] initWithSourceModel:[soucre objectAtIndex:i]] autorelease]];
    }
    
    [launcherView setPages:[NSMutableArray arrayWithObjects:array,nil]];
    [array release];
    
    [footer setPageNumber:_currentPage andTotalPage:[XAppDelegate._arrayAllSite count]/12+1];
    [launcherView checkReloadAllsite];
}


#pragma mark -  MylaucherView delegate
-(void)itemInforClick:(id)item{
    RatingInformationController *vc=[[RatingInformationController alloc] initWithNibName:@"RatingInformationController" bundle:nil];
    vc._laucherItemSelect=item;
    [self presentPopupViewController:vc animationType:MJPopupViewAnimationSlideBottomBottom];
    
}

-(void)launcherViewItemSelected:(MyLauncherItem*)item
{
    NSLog(@"launcherViewItemSelected ");
    if (item.isAddButton) {
        [self plusButtonClick];
    }else
    {
        XAppDelegate._isgotoListArticle=YES;
        ListArticleViewController *vc=[[ListArticleViewController alloc] initWithNibName:@"ListArticleViewController" bundle:nil];
        [vc.view setFrame:self.view.frame]; 
        [vc setSiteId:item.siteID];
        [vc loaddataFromSite];
        [XAppDelegate.navigationController pushViewController:vc animated:YES];
        [vc release];
    }
}
   

#pragma mark - Header delegete
-(void)plusButtonClick{
    if (category) {
        [category release];
        category=nil;
    }
    
    category=[[CategoriesController alloc] initWithNibName:@"CategoriesController" bundle:nil];
    category.delegate=self;
    //[category orientationChanged];
    [self presentPopupViewController:category animationType:MJPopupViewAnimationSlideRightLeft];

}
#pragma mark--- categorydelegate
-(void)dismissCategories{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideLeftRight];

}
#pragma mark - Footer delegate
-(void)settingClick{
    NSLog(@"HOOHOHOHOHOHO1");
    appSettingController=[[IASKAppSettingsViewController alloc] init];
    appSettingController.delegate = self;
    _currentFontSize=[[[NSUserDefaults standardUserDefaults] objectForKey:@"AppfontSize"] integerValue];
    BOOL enabled = [[NSUserDefaults standardUserDefaults] boolForKey:@"AutoConnect"];
    appSettingController.hiddenKeys = enabled ? nil : [NSSet setWithObjects:@"AutoConnectLogin", @"AutoConnectPassword", nil];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:appSettingController];
    navController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    navController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:navController animated:YES completion:nil];
    [appSettingController release];
    
}

-(void)downloadClick{
    NSLog(@"downloadClickHieuPDG");
    
    if (arrForDownloadoff==nil||[arrForDownloadoff count]==0) {
        UIAlertView* alert =[[UIAlertView alloc]initWithTitle:@"" message:@"Bạn cần chọn mục để tải offline" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }else{
        
        DownloadDataOfflineViewController* downloadDataOfflineController =[[DownloadDataOfflineViewController alloc]initWithNibName:@"DownloadDataOfflineViewController" bundle:nil];
        downloadDataOfflineController.arrayListIDforDownload = [[NSMutableArray alloc]initWithArray:arrForDownloadoff];       [downloadDataOfflineController.tableviewDownload reloadData];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:downloadDataOfflineController];
        navController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        navController.modalPresentationStyle = UIModalPresentationFormSheet;
        
        //[self presentPopupViewController:navController animationType:MJPopupViewAnimationSlideBottomBottom];
        [self presentViewController:navController animated:YES completion:nil];
    }
    
}

-(void)searchSiteClick:(id)sender{
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
#pragma mark--- delete data viewcontroller
-(void) showDeleteData:(id)sender{
    SettingDeleteDataView *settingDownload=[[SettingDeleteDataView alloc] initWithNibName:@"SettingDeleteDataView" bundle:nil];
    [self.appSettingController.navigationController pushViewController:settingDownload animated:YES];
    
}
#pragma mark - IASettingDelegate

- (void)settingsViewController:(IASKAppSettingsViewController*)sender buttonTappedForSpecifier:(IASKSpecifier*)specifier {
    
	if ([specifier.key isEqualToString:@"btnFacebook"]) {
        
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Demo Action 1 called" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
		[alert show];
    }
    if ([specifier.key isEqualToString:@"btnThietlaptainguontin"]){
        [self showSettingforDownload:nil];
        
    }
    if ([specifier.key isEqualToString:@"btnGioithieu"]) {
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Gioi thieu" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
		[alert show];
    }
    if ([specifier.key isEqualToString:@"btnxoadulieutrave"]){
        [self showDeleteData:nil];
        
    }

}

- (void)settingsViewControllerDidEnd:(IASKAppSettingsViewController*)sender {
    int fontsize=[[[NSUserDefaults standardUserDefaults] objectForKey:@"AppfontSize"] integerValue];
    NSString *typeListSite=[[NSUserDefaults standardUserDefaults] objectForKey:@"typeListSite"];
    NSLog(@"Hoan thanh  %d  %@",fontsize,typeListSite);
    [self dismissModalViewControllerAnimated:YES];

    if (self.delegate&&fontsize!=_currentFontSize&&[XAppDelegate._typeshowSite isEqualToString:typeListSite]) {
        [self.delegate finishSettingClick:NO fontsize:YES];
        
        NSLog(@"aAAAAAAAAAAAA");
    }else if (self.delegate&&fontsize==_currentFontSize&&![XAppDelegate._typeshowSite isEqualToString:typeListSite]){
        XAppDelegate._typeshowSite=typeListSite;
        [self.delegate finishSettingClick:YES fontsize:NO];

    }else if (self.delegate&&fontsize!=_currentFontSize&&![XAppDelegate._typeshowSite isEqualToString:typeListSite]){
        XAppDelegate._typeshowSite=typeListSite;
        [self.delegate finishSettingClick:YES fontsize:YES];
    }
    else{
        NSLog(@"not exits");
    }
    
}

//-(UITableViewCell *)tableView:(UITableView *)tableView cellForSpecifier:(IASKSpecifier *)specifier{
//    
//    
//    [specifier.key isEqualToString:@"customViewCell"];
//    
//    
//}

-(IBAction) showSettingforDownload:(id)sender{
    SettingforDownloadController *settingDownload=[[SettingforDownloadController alloc] initWithNibName:@"SettingforDownloadController" bundle:nil];
    settingDownload.delegate =self;
    [self.appSettingController.navigationController pushViewController:settingDownload animated:YES];
    
}

#pragma mark----- reload font size

-(void) reloadFontSize{
    [launcherView reloadFontSize];
}
#pragma mark--- search keyword delegate
-(void)searchKeywordClick:(NSString*)keyword{
    [self.popovercontroller dismissPopoverAnimated:YES];
    ListArticleViewController *vc=[[ListArticleViewController alloc] initWithNibName:@"ListArticleViewController" bundle:nil];
    [vc setSiteId:-1];
    [vc loaddataFromSearchKeyWord:keyword];
    EzineAppDelegate *appDelegate=(EzineAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:vc animated:YES];

}

#pragma mark--- bookmark click
-(void)bookmarkClick{
    XAppDelegate._isgotoListArticle=YES;
    ListArticleViewController *vc=[[ListArticleViewController alloc] initWithNibName:@"ListArticleViewController" bundle:nil];
    [vc.view setFrame:self.view.frame];
    [vc setSiteId:-2];
    [vc loaddataFromSite];
    EzineAppDelegate *appDelegate=(EzineAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:vc animated:YES];
    [vc release];

}

#pragma mark===delegate for setting==========

-(void)chooseDataforDownload:(SettingforDownloadController *)controller{
    
    arrForDownloadoff =controller.arrayIdSiteDownload;
    // NSLog(@"Arrr======%@",arrForDownloadoff);
}


@end
