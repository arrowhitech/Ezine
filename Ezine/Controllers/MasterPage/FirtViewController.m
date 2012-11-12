//
//  FirtViewController.m
//  Ezine
//
//  Created by MAC on 7/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FirtViewController.h"
#import "CoverViewController.h"
#include <QuartzCore/QuartzCore.h>
#import "UIViewController+MJPopupViewController.h"
#import "SourceModel.h"
#import "SignInViewcontroller.h"
#import "SettingsViewController.h"
#import "NewEzineAccountViewController.h"
#import "IASKAppSettingsViewController.h"
#import "SettingforDownloadController.h"
#import "MyLauncherItem.h"
#import "SiteObject.h"

@implementation FirtViewController
@synthesize flipViewController,result,cachedDataListAllsite;
#pragma mark - View LifeCycle

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
    _arrayMyLauncherViewController=[[NSMutableArray alloc] init];
    cachedDataListAllsite=[[NSDictionary alloc] init];
    cachedDataListAllsite=nil;
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector: @selector(didAddSite:) name:KDidAddSiteNotification object: nil];
    [center addObserver:self selector: @selector(didReloadSite:) name:KDidReloadSiteNotification object: nil];
    
    [XAppDelegate.serviceEngine listSiteMasterPage:YES OnCompletion:^(NSDictionary* images) {
        [self parseData:images];
    } onError:^(NSError* error) {
        [self loadDataWhenError];
    }];
    
    
    /*
     Init array for save list View and list Site
     */
    
    
    /*
     Init FlipviewController
     */
    activeIndex=-1;
    self.flipViewController = [[MPFlipViewController alloc] initWithOrientation:[self flipViewController:nil orientationForInterfaceOrientation:[UIApplication sharedApplication].statusBarOrientation]];
	self.flipViewController.delegate = self;
	self.flipViewController.dataSource = self;
	CGRect pageViewRect = self.view.bounds;
    self.flipViewController.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
	self.flipViewController.view.frame = pageViewRect;
	[self addChildViewController:self.flipViewController];
	[self.view addSubview:self.flipViewController.view];
    //ios 4.3 die there
	[self.flipViewController didMoveToParentViewController:self];
    ///Vai PHuoc' lol
    
    result=[[CoverViewController alloc] init];
    result.delegate=self;
	[self.flipViewController setViewController:result direction:MPFlipViewControllerDirectionForward animated:NO completion:nil];
	self.view.gestureRecognizers = self.flipViewController.gestureRecognizers;
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(enteredBackground:)
                                                 name: @"didEnterBackground"
                                               object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(WillEnterForeground:)
                                                 name: @"WillEnterForeground"
                                               object: nil];
    
    [[UIDevice currentDevice] orientation] ;
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector: @selector(didDeleteSite:) name:KDidDeleteSiteNotification object: nil];
    [center addObserver:self selector: @selector(didBeginEdittingSite:) name:KDidBeginEdittingSiteNotification object: nil];
    [center addObserver:self selector: @selector(didEndEdittingSite:) name:KDidEndEdittingSiteNotification object: nil];
    [center addObserver:self selector: @selector(didChangeOrderSite:) name:KDidChangeOrderSiteNotification object: nil];
    [center addObserver:self selector: @selector(nextPage:) name:KNeedNextPageNotification object: nil];
    [center addObserver:self selector: @selector(moveCell:) name:KDidMoveCell object: nil];
    [center addObserver:self selector: @selector(finishMoveCell:) name:KDidFifnishMovecell object: nil];

    [super viewDidAppear:YES];
}
-(void)viewDidDisappear:(BOOL)animated{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	[center removeObserver:self name:KDidDeleteSiteNotification object:nil];
    [center removeObserver:self name:KDidBeginEdittingSiteNotification object:nil];
    [center removeObserver:self name:KDidEndEdittingSiteNotification object:nil];
    [center removeObserver:self name:KDidChangeOrderSiteNotification object:nil];
    // [center removeObserver:self name:KDidAddSiteNotification object:nil];
    [center removeObserver:self name:KNeedNextPageNotification object:nil];
    //[center removeObserver:self name:KDidReloadSiteNotification object:nil];
    
    [super viewDidDisappear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

-(void)dealloc{
    
    //[flipViewController release];
    [super dealloc];
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
    if (_isTypeList) {
        activeIndex--;
        if (activeIndex>=0) {
            return pageViewController;
        }else{
            if (activeIndex>=-1) {
                return result;
            }else{
                activeIndex++;
                return nil;
            }
        }
        
    }else{
        activeIndex--;
        if (activeIndex>=0) {
            return [_arrayMyLauncherViewController objectAtIndex:activeIndex];
        }else{
            if (activeIndex>=-1) {
                return result;
            }else{
                activeIndex++;
                return nil;
            }
        }
        
    }
}

- (UIViewController *)flipViewController:(MPFlipViewController *)flipViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if (_isTypeList) {
        if (pageViewController) {
            activeIndex++;
            if (activeIndex<1) {
                return pageViewController;
            }else{
                activeIndex--;
                return nil;
            }
            
        }
        return nil;
    }else{
        if ([_arrayMyLauncherViewController count]>0) {
            activeIndex++;
            if (activeIndex<=[_arrayMyLauncherViewController count]-1) {
                return [_arrayMyLauncherViewController objectAtIndex:activeIndex];
            }else{
                activeIndex--;
                return nil;
            }
            
        }
        return nil;
        
    }
}


#pragma mark - Load Data and Build Page

-(void)loadDataWhenError{
    
}

- (void) parseData:(NSDictionary*)dict{
    NSLog(@"parseData");
    if (dict==NULL) {
        return;
    }
    
    if ([dict isEqualToDictionary:cachedDataListAllsite]) {
        NSLog(@"cachedData all site in source screen");
        return;
        
    }else{
        if (finishedBuildPage) {
            isBuildingPage=YES;
            cachedDataListAllsite =nil;
            cachedDataListAllsite=[[[NSDictionary alloc] initWithDictionary:dict copyItems:YES] retain];
            return;
        }
        finishedBuildPage=YES;
        cachedDataListAllsite =nil;
        cachedDataListAllsite=[[[NSDictionary alloc] initWithDictionary:dict copyItems:YES] retain];
        [XAppDelegate._arrayAllSite removeAllObjects];
        [XAppDelegate.arrayIdSite removeAllObjects];
        XAppDelegate.arrayIdSite=nil;
        
        
        NSDictionary *topDict=[dict objectForKey:@"SiteTop"];
        SourceModel *topSource=[[SourceModel alloc] initWithId:[[topDict objectForKey:@"SiteID"] intValue] image:[topDict objectForKey:@"ImageUrl"] title:@"" isAddButton:NO isTop:YES articleList:[topDict objectForKey:@"ArticleList"]];
        [XAppDelegate._arrayAllSite addObject:topSource];
        
        NSLog(@"all site === %@",XAppDelegate.arrayIdSite);
        
        NSArray *arraySiteOther = [dict objectForKey:@"SiteListOthers"];
        if (XAppDelegate.arrayIdSite==nil||[XAppDelegate.arrayIdSite count]<1) {
            XAppDelegate.arrayIdSite=[[NSMutableArray alloc] init];
            for (NSDictionary *dic in arraySiteOther) {
                SourceModel *otherSource = [[SourceModel alloc] initWithId:[[dic objectForKey:@"SiteID"]intValue] image:[dic objectForKey:@"ImageUrl"] title:[dic objectForKey:@"Name"] isAddButton:NO isTop:NO articleList:nil];
                
                [XAppDelegate.arrayIdSite addObject:[NSNumber numberWithInt:otherSource.sourceId]];
                [XAppDelegate._arrayAllSite addObject:otherSource];
                
            }
            
        }else{
            for (NSNumber * siteID in XAppDelegate.arrayIdSite) {
                for (NSDictionary *dic in arraySiteOther) {
                    SourceModel *otherSource = [[SourceModel alloc] initWithId:[[dic objectForKey:@"SiteID"]intValue] image:[dic objectForKey:@"ImageUrl"] title:[dic objectForKey:@"Name"] isAddButton:NO isTop:NO articleList:nil];
                    if ([siteID intValue]==otherSource.sourceId) {
                        [XAppDelegate._arrayAllSite addObject:otherSource];
                        NSLog(@"site id==%d",otherSource.sourceId);
                    }
                }
            }
            
        }
        
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:XAppDelegate.arrayIdSite];
        [defaults setObject:data forKey:@"IdAllSite"];
        [defaults synchronize];
        
        SourceModel *addButton = [[SourceModel alloc] initWithId:1000 image:@"" title:@"" isAddButton:YES isTop:NO articleList:nil];
        [XAppDelegate._arrayAllSite addObject:addButton];
        
        for (SourceModel *obj in XAppDelegate._arrayAllSite) {
            if ((NSNull *)obj.sourceId==[NSNull null]||(NSNull* )obj.image ==[NSNull null]) {
                obj.sourceId =0;
                obj.image =@"";
            }
            
        }
        
        XAppDelegate._typeshowSite=[[NSUserDefaults standardUserDefaults] objectForKey:@"typeListSite"];
        if (XAppDelegate._typeshowSite==Nil) {
            [[NSUserDefaults standardUserDefaults] setObject:@"magazine" forKey:@"typeListSite"];
            XAppDelegate._typeshowSite=@"magazine";
        }
        if ([XAppDelegate._typeshowSite isEqualToString:@"list"]) {
            _isTypeList=YES;
            [self LoadTypeList];
            
        }else{
            [self autoDividePages];
            _isTypeList=NO;
            
        }
        
    }
    
}

-(void)autoDividePages{
    NSLog(@"current page=== %d",activeIndex);
    if (_arrayMyLauncherViewController) {
        int totalAvailableSite = 0;
        
        for (MyLauncherViewController *page in _arrayMyLauncherViewController) {
            [page reLoad];
            totalAvailableSite += [[page.launcherView.pages objectAtIndex:0] count];
        }
        
        // if total Stite available < total Site then add new page
        int lastTotalPage = [_arrayMyLauncherViewController count];
        int totalSiteRemain = [XAppDelegate._arrayAllSite count] - totalAvailableSite;
        if (totalSiteRemain>0) {
            int newNumberPage = totalSiteRemain/12+1;
            for (int i=0; i<newNumberPage; i++) {
                MyLauncherViewController *vc=[[MyLauncherViewController alloc] init];
                vc.delegate =self;
                vc._currentPage=i+1 + lastTotalPage;
                [vc initalizeViews];
                [vc reLoad];
                [_arrayMyLauncherViewController addObject:vc];
                [vc release];
            }
            
        }
        
    }else{
        MyLauncherViewController *vc=nil;
        int newNumberPage = [XAppDelegate._arrayAllSite count]/12+1;
        for (int i=0; i<newNumberPage; i++) {
            vc=[[MyLauncherViewController alloc] init];
            vc.delegate=self;
            vc._currentPage=i+1;
            [vc initalizeViews];
            [vc reLoad];
            [_arrayMyLauncherViewController addObject:vc];
            [vc release];
        }
        if (activeIndex>-1&&!XAppDelegate._isgotoListArticle) {
            [self.flipViewController setViewController:[_arrayMyLauncherViewController objectAtIndex:activeIndex] direction:MPFlipViewControllerDirectionForward animated:NO completion:nil];
        }
        finishedBuildPage=NO;
        if (isBuildingPage) {
            [self updateMyLaucherView];
            isBuildingPage=NO;
        }
        
    }
    
}

-(void) showSettingViewcontroller{
    IASKAppSettingsViewController *viewcontroller =[[SettingsViewController alloc]initWithNibName:@"SettingsViewController" bundle:nil andFrame:CGRectMake(0, 0, 548, 628)];
    [self presentPopupViewController:viewcontroller animationType:MJPopupViewAnimationFade];
    
}

#pragma mark - OrientationChanged

-(void)orientationChanged{
    if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeLeft||[[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeRight) {
        [self.flipViewController.view setFrame:CGRectMake(0, 0, 1024, 748 )];
        
        [pageViewController rejustLayout:UIInterfaceOrientationLandscapeLeft];
        
    }else if([[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortrait||[[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortraitUpsideDown){
        [self.flipViewController.view setFrame:CGRectMake(0, 0,768, 1004)];
        [pageViewController rejustLayout:UIInterfaceOrientationPortrait];
        
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft||toInterfaceOrientation==UIInterfaceOrientationLandscapeRight||toInterfaceOrientation==UIInterfaceOrientationPortrait||toInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown);
}

- (void)applicationWillTerminate:(UIApplication *)application{
    NSLog(@"applicationWillTerminate");
}
- (void)WillEnterForeground:(UIApplication *)application{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    //   [Database deleteAllSite:[Utils appDelegate].database];
    NSLog(@"applicationWillEnterForeground");
}

- (void)enteredBackground:(UIApplication *)application{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    //    NSMutableArray *arrayAllSite=[[NSMutableArray alloc] init];
    //    for (MyLauncherViewController *vc in _arrayMyLauncherViewController) {
    //        for (NSMutableArray *page in vc.launcherView.pages) {
    //            for (MyLauncherItem *item in page) {
    //                SiteObject *siteObject=[[SiteObject alloc] init];
    //                siteObject._siteID=item.siteID;
    //                siteObject._title=item.title;
    //                [arrayAllSite addObject:siteObject];
    //            }
    //        }
    //    }
    //    [arrayAllSite removeLastObject];
    //    [Database saveAllSiteToDataBase:arrayAllSite Indatabas:[Utils appDelegate].database];
    
}

#pragma mark - Notification

-(void)didAddSite:(NSNotification *)notification{
    int totalAvailableSite = 0;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"EzineAccountSessionId"]) {
        NSNumber *idSiteAdd=[XAppDelegate.arrayIdSite lastObject];
        
        [ XAppDelegate.serviceEngine userAddsiteToList:[idSiteAdd integerValue] onCompletion:^(NSDictionary* data) {
            NSLog(@"add site=== %@",data);
            NSString *listIdsiteUpdate=@"";
            
            for (NSNumber *idsite in XAppDelegate.arrayIdSite) {
                if ([listIdsiteUpdate isEqualToString:@""]) {
                    listIdsiteUpdate=[NSString stringWithFormat:@"%d",[idsite integerValue]];
                    
                }else{
                    listIdsiteUpdate=[NSString stringWithFormat:@"%@,%d",listIdsiteUpdate,[idsite integerValue]];
                    
                }
                
            }
            [XAppDelegate.serviceEngine updateListSiteUser:listIdsiteUpdate onCompletion:^(NSDictionary* data1) {
                
                NSLog(@"update list site=== %@",data1);
            } onError:^(NSError* error) {
            }];
            
        } onError:^(NSError* error) {
        }];
    }
    
    for (MyLauncherViewController *page in _arrayMyLauncherViewController) {
        [page reLoad];
        totalAvailableSite += [[page.launcherView.pages objectAtIndex:0] count];
    }
    
    // if total Stite available < total Site then add new page
    int lastTotalPage = [_arrayMyLauncherViewController count];
    int totalSiteRemain = [XAppDelegate._arrayAllSite count] - totalAvailableSite;
    if (totalSiteRemain>0) {
        int newNumberPage = totalSiteRemain/12+1;
        for (int i=0; i<newNumberPage; i++) {
            MyLauncherViewController *vc=[[MyLauncherViewController alloc] init];
            vc.delegate =self;
            vc._currentPage=i+1 + lastTotalPage;
            [vc initalizeViews];
            [vc reLoad];
            [_arrayMyLauncherViewController addObject:vc];
            [vc release];
        }
        
    }
    
}
-(void)didDeleteSite:(NSNotification *)notification{
    NSDictionary *infor=notification.userInfo;
    MyLauncherItem *item=[infor objectForKey:@"item"];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"EzineAccountName"]) {
        NSLog(@"deletesite:  %d",item._sourcemoder.sourceId);
        
        [ XAppDelegate.serviceEngine userremoveStie:item._sourcemoder.sourceId onCompletion:^(NSDictionary* data) {
            NSLog(@"remove=== %@",data);
            NSString *listIdsiteUpdate=@"";
            
            for (NSNumber *idsite in XAppDelegate.arrayIdSite) {
                if ([listIdsiteUpdate isEqualToString:@""]) {
                    listIdsiteUpdate=[NSString stringWithFormat:@"%d",[idsite integerValue]];
                    
                }else{
                    listIdsiteUpdate=[NSString stringWithFormat:@"%@,%d",listIdsiteUpdate,[idsite integerValue]];
                    
                }
            }
            [XAppDelegate.serviceEngine updateListSiteUser:listIdsiteUpdate onCompletion:^(NSDictionary* data1) {
                
                NSLog(@"update list site=== %@    \n %@",data1,listIdsiteUpdate);
            } onError:^(NSError* error) {
            }];
            
            
        } onError:^(NSError* error) {
        }];
    }
    NSLog(@"deletesite:  %d",item._sourcemoder.sourceId);
    
    for (SourceModel *souce in XAppDelegate._arrayAllSite) {
        if (souce.sourceId==item._sourcemoder.sourceId) {
            [XAppDelegate._arrayAllSite removeObject:souce];
            break;
        }
    }
    for (NSNumber *siteId in XAppDelegate.arrayIdSite) {
        if ([siteId intValue]==item._sourcemoder.sourceId) {
            [XAppDelegate.arrayIdSite removeObject:siteId];
            break;
        }
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:XAppDelegate.arrayIdSite];
    [defaults setObject:data forKey:@"IdAllSite"];
    [defaults synchronize];
    
    for (MyLauncherViewController *page in _arrayMyLauncherViewController) {
        [page reLoad];
        if (page.launcherView.pages==nil) {
            [_arrayMyLauncherViewController removeObject:page];
        }
    }
    
    
    
}

-(void)didBeginEdittingSite:(NSNotification *)notification{
    for (MyLauncherViewController *page in _arrayMyLauncherViewController) {
        [page.launcherView beginEditing];
    }
}

-(void)didEndEdittingSite:(NSNotification *)notification{
    for (MyLauncherViewController *page in _arrayMyLauncherViewController) {
        if (page.launcherView.editing) {
            [page.launcherView endEditing];
        }
    }
}

-(void)didChangeOrderSite:(NSNotification *)notification{
    NSDictionary *infor=notification.userInfo;
    NSInteger fromIndex=[[infor objectForKey:@"from"] intValue];
    NSInteger endIndex=[[infor objectForKey:@"to"] intValue];
    NSInteger pageChange=[[infor objectForKey:@"Page"] integerValue];
    NSInteger _placeformIndex=fromIndex-1+(pageChange-1)*12;
    NSInteger _placeEndIndex=endIndex-1+(pageChange-1)*12;
    if (pageChange>1) {
        _placeformIndex=fromIndex-2+(pageChange-1)*12;
        _placeEndIndex=endIndex-2+(pageChange-1)*12;
    }
    NSLog(@"change from %d to %d in page %d placeForm %d  placeEnd %d",fromIndex,endIndex,pageChange,_placeformIndex,_placeEndIndex);
    
    
    [XAppDelegate.arrayIdSite insertObject:[XAppDelegate.arrayIdSite objectAtIndex:_placeformIndex] atIndex:_placeEndIndex];
    [XAppDelegate.arrayIdSite removeObjectAtIndex:_placeformIndex+1];
    
    [XAppDelegate._arrayAllSite insertObject:[XAppDelegate._arrayAllSite objectAtIndex:_placeformIndex+1] atIndex:_placeEndIndex+1];
    [XAppDelegate._arrayAllSite removeObjectAtIndex:_placeformIndex+2];
    
    NSLog(@"site id====== %@",XAppDelegate.arrayIdSite);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:XAppDelegate.arrayIdSite];
    [defaults setObject:data forKey:@"IdAllSite"];
    [defaults synchronize];
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"EzineAccountName"]){
        NSString *listIdsiteUpdate=@"";
        
        for (NSNumber *idsite in XAppDelegate.arrayIdSite) {
            if ([listIdsiteUpdate isEqualToString:@""]) {
                listIdsiteUpdate=[NSString stringWithFormat:@"%d",[idsite integerValue]];
                
            }else{
                listIdsiteUpdate=[NSString stringWithFormat:@"%@,%d",listIdsiteUpdate,[idsite integerValue]];
                
            }
        
    }
        [XAppDelegate.serviceEngine updateListSiteUser:listIdsiteUpdate onCompletion:^(NSDictionary* data1) {
        
        NSLog(@"update list site=== %@",data1);
    } onError:^(NSError* error) {
    }];
    
    
}


}

-(void)nextPage:(NSNotification *)notification{
    [self.flipViewController gotoNextPage];
}
-(void)didReloadSite:(NSNotification*)notification{
    NSLog(@"reload site");
    for (MyLauncherViewController *laucherViewcontroller in _arrayMyLauncherViewController) {
        [laucherViewcontroller.launcherView reloadAllsite];
    }
    cachedDataListAllsite=nil;
    finishedBuildPage=NO;

    [XAppDelegate.serviceEngine listSiteMasterPage:NO OnCompletion:^(NSDictionary* images) {
        //NSLog(@"image====%@",images);
        [self parseData:images];
        //do something to get arrallsiteobj
        
    } onError:^(NSError* error) {
        [self loadDataWhenError];
    }];
    
}
#pragma mark=======OK--------Delegate======MyLaucherViewcontroller

-(void)finishSettingClick:(BOOL)ischangetypeShow fontsize:(BOOL)ischangeFontSize{
    NSLog(@"Finishshshshshshsh");
    
    if (ischangeFontSize) {
        [result reloadFontSize];
        for (MyLauncherViewController *vc in _arrayMyLauncherViewController) {
            [vc reloadFontSize];
        }
        
    }
    if (ischangetypeShow) {
        activeIndex=0;
        if ([XAppDelegate._typeshowSite isEqualToString:@"magazine"]) {
            [self autoDividePages];
            _isTypeList=NO;
            [self.flipViewController setViewController:[_arrayMyLauncherViewController objectAtIndex:activeIndex] direction:MPFlipViewControllerDirectionForward animated:YES completion:nil];
        }else{
            _isTypeList=YES;
            if (pageViewController) {
                [pageViewController release];
            }
            pageViewController =[[MylauncherPageViewController alloc] init];
            [self.flipViewController setViewController:pageViewController direction:MPFlipViewControllerDirectionForward animated:YES completion:nil];
            pageViewController.delegate=self;
            [pageViewController.view setFrame:self.view.frame];
            [pageViewController.view setBackgroundColor:[UIColor whiteColor]];
            [pageViewController.view setFrame:self.view.frame];
            [pageViewController LoadDataSiteUser];
        }
        
    }
    
}

#pragma mark----     load site type list
-(void)LoadTypeList{
    NSLog(@"load type List");
    if (pageViewController) {
        [pageViewController release];
        pageViewController=nil;
    }
    pageViewController =[[MylauncherPageViewController alloc] init];
    pageViewController.delegate=self;
    [pageViewController LoadDataSiteUser];
    [pageViewController.view setFrame:self.view.frame];
    [pageViewController.view setBackgroundColor:[UIColor whiteColor]];
    [pageViewController._tableviewSite setFrame:CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height-140)];
    finishedBuildPage=NO;
    
}
#pragma mark--- pageviewcontroller delegate
-(void)finishSettingClickInPageView:(BOOL)ischangetypeShow fontsize:(BOOL)ischangeFontSize{
    if (ischangeFontSize) {
        [result reloadFontSize];
        for (MyLauncherViewController *vc in _arrayMyLauncherViewController) {
            [vc reloadFontSize];
        }
        
    }
    if (ischangetypeShow) {
        activeIndex=0;
        if ([XAppDelegate._typeshowSite isEqualToString:@"magazine"]) {
            [self autoDividePages];
            _isTypeList=NO;
            //            [self.flipViewController setViewController:[_arrayMyLauncherViewController objectAtIndex:activeIndex] direction:MPFlipViewControllerDirectionForward animated:YES completion:nil];
        }else{
            _isTypeList=YES;
            if (pageViewController) {
                [pageViewController release];
            }
            pageViewController =[[MylauncherPageViewController alloc] init];
            [self.flipViewController setViewController:pageViewController direction:MPFlipViewControllerDirectionForward animated:NO completion:nil];

            pageViewController.delegate=self;
            [pageViewController.view setFrame:self.view.frame];
            [pageViewController.view setBackgroundColor:[UIColor whiteColor]];
            [pageViewController.view setFrame:self.view.frame];
            [pageViewController LoadDataSiteUser];
        }
    }
    
    
}

#pragma mark---- coveviewcontrollerdelegate
-(void)FlipbuttonClick{
    if (_isTypeList) {
        if (pageViewController) {
            activeIndex=0;
            [self.flipViewController setViewController:pageViewController direction:MPFlipViewControllerDirectionForward animated:YES completion:nil];
        }
        
    }else{
        if (_arrayMyLauncherViewController.count>=1) {
            activeIndex=0;
            [self.flipViewController setViewController:[_arrayMyLauncherViewController objectAtIndex:activeIndex] direction:MPFlipViewControllerDirectionForward animated:YES completion:nil];
        }
        
        
    }
    
}

#pragma mark--- update mylaucherview
-(void)updateMyLaucherView{
    [XAppDelegate._arrayAllSite removeAllObjects];
    
    NSDictionary *topDict=[cachedDataListAllsite objectForKey:@"SiteTop"];
    SourceModel *topSource=[[SourceModel alloc] initWithId:[[topDict objectForKey:@"SiteID"] intValue] image:[topDict objectForKey:@"ImageUrl"] title:@"" isAddButton:NO isTop:YES articleList:[topDict objectForKey:@"ArticleList"]];
    [XAppDelegate._arrayAllSite addObject:topSource];
    
    NSLog(@"all site === %@",XAppDelegate.arrayIdSite);
    
    NSArray *arraySiteOther = [cachedDataListAllsite objectForKey:@"SiteListOthers"];
    if (XAppDelegate.arrayIdSite==nil||[XAppDelegate.arrayIdSite count]<1) {
        XAppDelegate.arrayIdSite=[[NSMutableArray alloc] init];
        for (NSDictionary *dic in arraySiteOther) {
            SourceModel *otherSource = [[SourceModel alloc] initWithId:[[dic objectForKey:@"SiteID"]intValue] image:[dic objectForKey:@"ImageUrl"] title:[dic objectForKey:@"Name"] isAddButton:NO isTop:NO articleList:nil];
            
            [XAppDelegate.arrayIdSite addObject:[NSNumber numberWithInt:otherSource.sourceId]];
            [XAppDelegate._arrayAllSite addObject:otherSource];
            
        }
        
    }else{
        for (NSNumber * siteID in XAppDelegate.arrayIdSite) {
            for (NSDictionary *dic in arraySiteOther) {
                SourceModel *otherSource = [[SourceModel alloc] initWithId:[[dic objectForKey:@"SiteID"]intValue] image:[dic objectForKey:@"ImageUrl"] title:[dic objectForKey:@"Name"] isAddButton:NO isTop:NO articleList:nil];
                if ([siteID intValue]==otherSource.sourceId) {
                    [XAppDelegate._arrayAllSite addObject:otherSource];
                    NSLog(@"site id==%d",otherSource.sourceId);
                }
            }
        }
        
    }
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:XAppDelegate.arrayIdSite];
    [defaults setObject:data forKey:@"IdAllSite"];
    [defaults synchronize];
    
    SourceModel *addButton = [[SourceModel alloc] initWithId:1000 image:@"" title:@"" isAddButton:YES isTop:NO articleList:nil];
    [XAppDelegate._arrayAllSite addObject:addButton];
    
    for (SourceModel *obj in XAppDelegate._arrayAllSite) {
        if ((NSNull *)obj.sourceId==[NSNull null]||(NSNull* )obj.image ==[NSNull null]) {
            obj.sourceId =0;
            obj.image =@"";
        }
        
    }
    // update image site
    
    for (int i=0;i<[_arrayMyLauncherViewController count];i++) {
        MyLauncherViewController *launcherView=[_arrayMyLauncherViewController objectAtIndex:i];
        for (int j=0; j<launcherView.launcherView.pages.count; j++) {
            NSLog(@"i===== %d  j====%d",i,j);
            // MyLauncherItem *lauhcherItem=[launcherView.launcherView.pages objectAtIndex:j];
        }
    }
}

#pragma mark--- did move cell
-(void)moveCell:(id)sender{
    NSLog(@"move cell");
    
    [self.flipViewController.right setEnabled:NO];
    [self.flipViewController.left setEnabled:NO];
}

///------- finish movecell
-(void)finishMoveCell:(id)sender{
    NSLog(@"finishMoveCell ");
    [self.flipViewController.right setEnabled:YES];
    [self.flipViewController.left setEnabled:YES];

}
@end

