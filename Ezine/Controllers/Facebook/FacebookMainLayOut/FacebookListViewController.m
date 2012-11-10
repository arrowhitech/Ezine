//
//  FacebookListViewController.m
//  Ezine
//
//  Created by MAC on 10/15/12.
//
//

#import "FacebookListViewController.h"

@interface FacebookListViewController ()

@end

@implementation FacebookListViewController

@synthesize lastTimePostupdate,lastTimeStatusUpdate;
@synthesize flipViewController;

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
    _numberPage=0;
    activeIndex=0;
    _isUpdateArticle=NO;
    currentAPI=kAPIGraphUserPermissions;
    arrayDataNewFeed=[[NSMutableArray alloc] init];
    arrayDataNewFeedStatus=[[NSMutableArray alloc] init];
    arrayPage=[[NSMutableArray alloc] init];
    
    // Do any additional setup after loading the view from its nib.
    // get current tiem to get post
    lastTimePostupdate=[[NSDate date] timeIntervalSince1970];
    lastTimeStatusUpdate=lastTimePostupdate;
    FBFeedPost *post = [[FBFeedPost alloc] init];
    post.postType=currentAPI;
    post.lastTimePost=lastTimePostupdate;
    post.lastTimeStatus=lastTimePostupdate;
    
    [post publishPostWithDelegate:self];
    
    
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
    
    if (self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        self.flipViewController.view.frame=CGRectMake(0, 0, 768,1004);
        //[activityIndicator setFrame:CGRectMake(768/2.0-40, 748/3, 100, 100)];
        
    }else if (self.interfaceOrientation==UIInterfaceOrientationLandscapeLeft||self.interfaceOrientation==UIInterfaceOrientationLandscapeRight){
        self.flipViewController.view.frame =CGRectMake(0,0, 1024,748);
        //[activityIndicator setFrame:CGRectMake(1024/2.0-40, 1004/3, 100, 100)];
        
    }
    activeIndex=0;
    [flipViewController.right setEnabled:NO];
    [flipViewController.left setEnabled:NO];
    [self addChildViewController:self.flipViewController];
    [self.view addSubview:self.flipViewController.view];
    [self.flipViewController didMoveToParentViewController:self];
    self.view.gestureRecognizers = self.flipViewController.gestureRecognizers;
    
}


-(void)getApifeedFacebook:(int)ApiGet{
    switch (ApiGet) {
            
        case kAPIUSerNewFeedStatus:
            break;
        case kAPIUSerNewFeed:{
            
            NSString *queryKey=[[NSString alloc] initWithFormat:@"SELECT post_id FROM stream WHERE filter_key in (SELECT filter_key FROM stream_filter WHERE uid=me() AND type='newsfeed') AND is_hidden = 0 AND type= 80 LIMIT 40"];
            NSMutableDictionary *params1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                            queryKey, @"query",
                                            nil];
            
            [[[FBRequestWrapper defaultManager] facebook] requestWithMethodName:@"fql.query"
                                                                      andParams:params1
                                                                  andHttpMethod:@"POST"
                                                                    andDelegate:self];
            break;
        }
            
        case kAPIUserImageWall:{
            NSLog(@"kAPIUserImageWall");
            //            FBFeedPost *post = [[FBFeedPost alloc] initWithGetUserFeed:self withApi:ApiGet];
            //            [post publishPostWithDelegate:self];
            break;
        }
        case kAPIUserImage:{
            
            //            FBFeedPost *post = [[FBFeedPost alloc] initWithGetUserFeed:self withApi:ApiGet];
            //            [post publishPostWithDelegate:self];
            break;
        }
        case KAPINewImage:{
            NSString *queryKey=[[NSString alloc] initWithFormat:@"SELECT post_id FROM stream WHERE filter_key in (SELECT filter_key FROM stream_filter WHERE uid=me() AND type='newsfeed') AND is_hidden = 0 AND type= 247 LIMIT 40"];
            NSMutableDictionary *params1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                            queryKey, @"query",
                                            nil];
            
            [[[FBRequestWrapper defaultManager] facebook] requestWithMethodName:@"fql.query"
                                                                      andParams:params1
                                                                  andHttpMethod:@"POST"
                                                                    andDelegate:self];
            break;
        }
        case kAPINewLink:{
            NSString *queryKey=[[NSString alloc] initWithFormat:@"SELECT post_id FROM stream WHERE filter_key in (SELECT filter_key FROM stream_filter WHERE uid=me() AND type='newsfeed') AND is_hidden = 0 AND type= 80 LIMIT 40"];
            NSMutableDictionary *params1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                            queryKey, @"query",
                                            nil];
            
            [[[FBRequestWrapper defaultManager] facebook] requestWithMethodName:@"fql.query"
                                                                      andParams:params1
                                                                  andHttpMethod:@"POST"
                                                                    andDelegate:self];
            break;
        }
        case kAPIGroup:{
            
            
            break;
            ;
        }
        case kAPIPage:{
            
            break;
        }
        case kAPIUserFriendsList:{
            
            //            FBFeedPost *post = [[FBFeedPost alloc] initWithGetUserFeed:self withApi:ApiGet];
            //            [post publishPostWithDelegate:self];
            break;
        }
        case kAPIUserFriends:{
            
            break;
        }
        default:
            break;
    }
}
#pragma mark-------- FBFeedPostDelegate

- (void) failedToPublishPost:(FBFeedPost*) _post{
    
}
- (void) finishedPublishingPost:(FBFeedPost*) _post{
    
}
-(void)cancelFacebook{
    
}

#pragma mark---- FBRequestDelegate
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"ResponseFailed: %@", error);
    
}

/**
 * Called when a request returns and its response has been parsed into an object.
 *
 * The resulting object may be a dictionary, an array, a string, or a number, depending
 * on thee format of the API response.
 */
- (void)request:(FBRequest *)request didLoad:(id)result{
    NSLog(@"=== result===  %d",[result count]);
    [self pasteDataNewFeed:result];
    if (currentAPI==kAPIUSerNewFeed) {
        currentAPI=kAPIUSerNewFeedStatus;
        FBFeedPost *post = [[FBFeedPost alloc] init];
        post.postType=currentAPI;
        post.lastTimeStatus=lastTimeStatusUpdate;
        [post publishPostWithDelegate:self];
    }
    
    if (currentAPI==kAPIGraphUserPermissions) {
        if (!result) {
            return;
        }
        NSDictionary *dataUSer=[result objectAtIndex:0];
        NSString *urlImage=nil;
        urlImage=[[NSString alloc] initWithFormat:@"%@",[dataUSer objectForKey:@"pic"]];
        NSString    *name=[dataUSer objectForKey:@"name"];
        NSString *idUserFacebook=[dataUSer objectForKey:@"uid"];
        
        [[NSUserDefaults standardUserDefaults] setObject:urlImage forKey:@"urlProfile"];
        [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"nameProfile"];
        [[NSUserDefaults standardUserDefaults] setObject:idUserFacebook forKey:@"IdProfile"];
        currentAPI=kAPIUSerNewFeed;
        FBFeedPost *post = [[FBFeedPost alloc] init];
        post.postType=currentAPI;
        post.lastTimePost=lastTimePostupdate;
        [post publishPostWithDelegate:self];
        
    }
    
}


#pragma mark-------   paste Data NewFeed

-(void)pasteDataNewFeed:(id)result{
    NSLog(@"result===%d",currentAPI);
    switch (currentAPI) {
        case kAPIUSerNewFeed:
            if (result&&[result count]>=1) {
                // NSMutableArray *arrayTemdFeed=[[[NSMutableArray alloc] init] autorelease];
                for (int i=0; i<[result count]; i++) {
                    NSDictionary *dataFeed=[result objectAtIndex:i];
                    FBObjectModel *fbObjectModel=[[FBObjectModel alloc] init];
                    fbObjectModel.actor_id=[dataFeed objectForKey:@"actor_id"];
                    fbObjectModel.message=[dataFeed objectForKey:@"message"];
                    fbObjectModel.attachment=[dataFeed objectForKey:@"attachment"];
                    fbObjectModel.type=[[dataFeed objectForKey:@"type"] integerValue];
                    fbObjectModel.created_time=[[dataFeed objectForKey:@"created_time"] integerValue];
                    fbObjectModel.comments=[dataFeed objectForKey:@"comments"];
                    fbObjectModel.likes=[dataFeed objectForKey:@"likes"];
                    if (fbObjectModel.created_time<lastTimePostupdate) {
                        lastTimePostupdate=fbObjectModel.created_time;
                    }
                    [arrayDataNewFeed addObject:fbObjectModel];
                    if (i>13) {
                        break;
                    }
                    
                }
                //arrayDataNewFeed=[NSMutableArray arrayWithArray:arrayTemdFeed];
                NSLog(@"data new feed ==== %d",arrayDataNewFeed.count);
                
            }
            
            break;
        case kAPIUSerNewFeedStatus:
            if (result&&[result count]>=1) {
                // NSMutableArray *arrayTemdFeed=[[[NSMutableArray alloc] init] autorelease];
                for (int i=0; i<[result count]; i++) {
                    NSDictionary *dataFeed=[result objectAtIndex:i];
                    FBObjectModel *fbObjectModel=[[FBObjectModel alloc] init];
                    fbObjectModel.actor_id=[dataFeed objectForKey:@"actor_id"];
                    fbObjectModel.message=[dataFeed objectForKey:@"message"];
                    fbObjectModel.attachment=[dataFeed objectForKey:@"attachment"];
                    fbObjectModel.type=[[dataFeed objectForKey:@"type"] integerValue];
                    fbObjectModel.created_time=[[dataFeed objectForKey:@"created_time"] integerValue];
                    fbObjectModel.comments=[dataFeed objectForKey:@"comments"];
                    fbObjectModel.likes=[dataFeed objectForKey:@"likes"];
                    if (fbObjectModel.created_time<lastTimeStatusUpdate) {
                        lastTimeStatusUpdate=fbObjectModel.created_time;
                    }
                    [arrayDataNewFeedStatus addObject:fbObjectModel];
                    if (i>23) {
                        break;
                    }
                    
                }
                //arrayDataNewFeedStatus=[NSMutableArray arrayWithArray:arrayTemdFeed];
                NSLog(@"data new feed status==== %d",arrayDataNewFeedStatus.count);
                
                
            }
            [self builtPage];
            break;
        default:
            break;
    }
}


#pragma mark---- built page
-(void)layoutPage:(NSMutableArray*)arrayDataFeed{
    for (int i=0;i<arrayDataFeed.count;i++) {
        NSMutableArray *page=[arrayDataFeed objectAtIndex:i];
        LayoutViewExtention* layoutToReturn = nil;
        
        Class class =  NSClassFromString(@"FacebookLayout1");
		id layoutObject = [[[class alloc] init] autorelease];
        
		
		if ([layoutObject isKindOfClass:[LayoutViewExtention class]] ) {
			
			layoutToReturn = (LayoutViewExtention*)layoutObject;
			//layoutToReturn.delegate=self;
			[layoutToReturn initalizeViews:page];
			[layoutToReturn rotate:self.interfaceOrientation animation:NO];
            [layoutToReturn.view setFrame:self.view.frame];
			layoutToReturn.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
			
			FbHeaderView* headerView = [[FbHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,56)];
            headerView.delegate=self;
            //		headerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
			[headerView setWallTitleText:@"11"];
            //            [headerView changeStyleHeader:idLayOut];
			[headerView rotate:self.interfaceOrientation animation:NO];
			[layoutToReturn setFbheaderView:headerView];
			[headerView release];
			
			FbFooterView* footerView = [[FbFooterView alloc] initWithFrame:CGRectMake(0, layoutToReturn.view.frame.size.height - 50, layoutToReturn.view.frame.size.width, 50)];
			[footerView setBackgroundColor:[UIColor whiteColor]];
            ///================================================
            footerView.deletegate=self;
            footerView._timeArticle=lastTimeStatusUpdate;
            footerView._numberAllpage=_numberPage;
			[footerView setViewArray:arrayPage];
			
			if (self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
				[footerView setFrame:CGRectMake(0, 1004 - 50, 768, footerView.frame.size.height)];
			}else {
				[footerView setFrame:CGRectMake(0, 748 - 50, 1024, footerView.frame.size.height)];
			}
			[footerView rotate:self.interfaceOrientation animation:YES];
			[footerView.searchKeyword setHidden:YES];
			[layoutToReturn setFbfooterView:footerView];
			[footerView release];
            [arrayPage addObject:layoutToReturn];
            layoutToReturn=nil;
        }
        page=nil;
    }
    if (activeIndex==0) {
        [flipViewController.right setEnabled:YES];
        [flipViewController.left setEnabled:YES];
        [self.flipViewController setViewController:[arrayPage objectAtIndex:activeIndex] direction:MPFlipViewControllerDirectionForward animated:YES completion:nil];
        
    }
    if (_isUpdateArticle) {
        _isUpdateArticle=NO;
    }
    
    
    
}

- (void) builtPage{
    NSMutableArray *arrayTembAllFeed=[[NSMutableArray alloc] init];
    int status=arrayDataNewFeedStatus.count/5;
    int feed=arrayDataNewFeed.count/3;
    int pages= status>feed ? status: feed;
    for (int i=0; i<pages; i++) {
        NSMutableArray *arrayTembAllFeed2=[[[NSMutableArray alloc] init] autorelease];
        //NSLog(@"count=== %d ",i);
        
        for (int j=i*3; j<3+i*3; j++) {
            if (j<[arrayDataNewFeed count]) {
                FBObjectModel*fbObject=[arrayDataNewFeed objectAtIndex:j];
                [arrayTembAllFeed2 addObject:fbObject];
                NSLog(@"count=== %d ",j);
            }else{
                FBObjectModel*fbObject=[[FBObjectModel alloc] init];
                [arrayTembAllFeed2 addObject:fbObject];
                
            }
        }
        
        for (int k=i*5; k<5+i*5; k++) {
            if (k<[arrayDataNewFeedStatus count]) {
                FBObjectModel*fbObject=[arrayDataNewFeedStatus objectAtIndex:k];
                [arrayTembAllFeed2 addObject:fbObject];
                
            }else{
                FBObjectModel*fbObject=[[FBObjectModel alloc] init];
                [arrayTembAllFeed2 addObject:fbObject];
                
            }
        }
        [arrayTembAllFeed addObject:arrayTembAllFeed2];
        arrayTembAllFeed2=nil;
    }
    NSLog(@"count=== %d ",arrayTembAllFeed.count);
    _numberPage+=pages;
    [self layoutPage:arrayTembAllFeed];
    arrayTembAllFeed=nil;
}
#pragma mark--- update
-(void)updateListActicle{
    NSLog(@"update  %d  %d",lastTimePostupdate,lastTimeStatusUpdate);
    [arrayDataNewFeedStatus removeAllObjects];
    [arrayDataNewFeed removeAllObjects];
    
    currentAPI=kAPIUSerNewFeed;
    FBFeedPost *post = [[FBFeedPost alloc] init];
    post.postType=currentAPI;
    post.lastTimePost=lastTimePostupdate;
    [post publishPostWithDelegate:self];
    
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
    if (activeIndex>=[arrayPage count]-2&&_isUpdateArticle==NO) {
        _isUpdateArticle=YES;
        [self updateListActicle];
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


#pragma mark---- FbHeader Deleagate
-(void)ezineButtonClicked:(id)sender{
    NSLog(@"EzineClick");
    XAppDelegate._isgotoListArticle=NO;
    EzineAppDelegate *appDelegate=(EzineAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController popViewControllerAnimated:YES];
}

-(void)themButtonClicked:(id)sender{
    
}

-(void)listButtonClicked:(UIButton *)sender{
    
}

-(void)showCategoryOfSource:(UIButton *)sender inRect:(CGRect)frame{
    
    
}

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
    if (activeIndex>=[arrayPage count]-2&&_isUpdateArticle==NO) {
        _isUpdateArticle=YES;
        [self updateListActicle];
    }
    
}
-(void) searchKeywork:(id)sender{
    
}

@end
