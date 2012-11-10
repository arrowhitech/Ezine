//
//  FacebookDetailViewController.m
//  Ezine
//
//  Created by MAC on 7/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FacebookDetailViewController.h"
#import "JsonFBNewFeed.h"
#import "FBDetailViewController.h"
#import "VariableStore.h"
#import "FBFeedObject.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)


@interface FacebookDetailViewController ()
-(void) loadDetail;
@end

@implementation FacebookDetailViewController
@synthesize currentAPICall;
@synthesize activityIndicator;
@synthesize btn_showList;
@synthesize lableFbList;
@synthesize imgMan;
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
    fbListView=[[FbListPopUpViewController alloc] initWithNibName:@"FbListPopUpViewController" bundle:nil];
    fbListView.delegate=self;
    [fbListView.view setFrame:CGRectMake(150, 40, 425, 20)];
    [self.view addSubview:fbListView.view];
    [fbListView.view setHidden:YES];
    
    self.imgMan = [[[HJObjManager alloc] init] autorelease];
	NSString* cacheDirectory = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/imgcache/imgtable/"] ;
	HJMOFileCache* fileCache = [[[HJMOFileCache alloc] initWithRootPath:cacheDirectory] autorelease];
	self.imgMan.fileCache = fileCache;
    arrayNewFeed=[[NSMutableArray alloc] init];
    arrayViewController=[[NSMutableArray alloc] init];
    int xPosition = (self.view.bounds.size.width / 2.0) - 50;
    int yPosition = (self.view.bounds.size.height / 2.0) - 150.0;
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(xPosition, yPosition, 100, 100)];
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.view addSubview:activityIndicator];
    [self loadDetail];
}

- (void)viewDidUnload
{
    [self setBtn_showList:nil];
    [self setLableFbList:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft||toInterfaceOrientation==UIInterfaceOrientationLandscapeRight||toInterfaceOrientation==UIInterfaceOrientationPortrait||toInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark----
-(void)loadDetail{
    ImageProlife=[[HJManagedImageV alloc]initWithFrame:CGRectMake(280, 15, 40, 40)];
    ImageProlife.imageView.contentMode=UIViewContentModeScaleAspectFill;
    NSString *urlImage=[[VariableStore sharedInstance] urlProlifeImage];
    NSURL *url = [NSURL URLWithString:urlImage];
    ImageProlife.url = url;
    ImageProlife.oid =nil;
    [self.imgMan manage:ImageProlife];
    [self.view addSubview:ImageProlife];
    
}
#pragma mark---

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
    NSLog(@"hide");
    if ([activityIndicator isAnimating]) {
        [activityIndicator stopAnimating];
    }
    
}

#pragma ------
#pragma mark--- get api facebook

-(void)getApifeedFacebook:(int)ApiGet{
    [self showActivityIndicator];
    NSLog(@"kAPIUSerNewFeed: %d",currentAPICall);
    switch (ApiGet) {
        case kAPIUSerNewFeed:{
            NSLog(@"kAPIUSerNewFeed");
            [self.lableFbList setText:@"Tin mới"];
            FBFeedPost *post = [[FBFeedPost alloc] initWithGetUserFeed:self withApi:ApiGet];
            [post publishPostWithDelegate:self]; 
        
            break;
        }
        case kAPIUserImageWall:{
            NSLog(@"kAPIUserImageWall");
            [self.lableFbList setText:@"Trên tường của bạn"];
            FBFeedPost *post = [[FBFeedPost alloc] initWithGetUserFeed:self withApi:ApiGet];
            [post publishPostWithDelegate:self]; 
            break;
        }
        case kAPIUserImage:{
            [self.lableFbList setText:@"Ảnh của bạn"];

            FBFeedPost *post = [[FBFeedPost alloc] initWithGetUserFeed:self withApi:ApiGet];
            [post publishPostWithDelegate:self]; 
            break;
        }
        case KAPINewImage:{
            [self.lableFbList setText:@"Tin ảnh mới"];
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
            [self.lableFbList setText:@"Link mới"];
            NSString *queryKey=[[NSString alloc] initWithFormat:@"SELECT post_id FROM stream WHERE filter_key in (SELECT filter_key FROM stream_filter WHERE uid=me() AND type='newsfeed') AND is_hidden = 0 AND type= 80 LIMIT 40"];
            NSMutableDictionary *params1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                            queryKey, @"query",
                                            nil];
            
            [[[FBRequestWrapper defaultManager] facebook] requestWithMethodName:@"fql.query"
                                                                      andParams:params1
                                                                  andHttpMethod:@"POST"
                                                                    andDelegate:self];            break;
        }
        case kAPIGroup:{
            [self.lableFbList setText:@"Nhóm"];

           
            break;
            ;
        }   
        case kAPIPage:{
            [self.lableFbList setText:@"Trang"];

            break;
        }
        case kAPIUserFriendsList:{
            [self.lableFbList setText:@""];

            FBFeedPost *post = [[FBFeedPost alloc] initWithGetUserFeed:self withApi:ApiGet];
            [post publishPostWithDelegate:self];   
            break;
        }
        case kAPIUserFriends:{
            [self.lableFbList setText:@""];

            break;
        }
        default:
            break;
    }
}

#pragma mark------
-(void)btnEzine:(id)sender{
    [flipper setCurrentPage:1 animated:YES setNewView:NO];
    CGRect menuFrame = self.view.frame;
    menuFrame.origin.x =768;
    [UIView animateWithDuration:0.4
                          delay:0.6
                        options: UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.view.frame = menuFrame;
                     } 
                     completion:^(BOOL finished){
                         [self.view.superview removeFromSuperview];
                                                  //                             if (self.delegate) {
                         //                                 [self.delegate backMenuClick];
                         //                             }
                         
                         
                     }];

}
- (IBAction)btnShowListClick:(id)sender {
    NSLog(@"variableGloberl: %d",[[[VariableStore sharedInstance]arrayListFb] count]);
    [self.view bringSubviewToFront:fbListView.view];
    if (fbListView.isShowMenu) {
        [fbListView showout];

    }else {
        [fbListView showin];
    }
}

#pragma mark----
#pragma mark FBRequestDelegate
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    [self hideActivityIndicator];
	NSLog(@"ResponseFailed: %@", error);
	
}

- (void)request:(FBRequest *)request didLoad:(id)result {
    
    [self hideActivityIndicator];
    if(result==nil||[result count]<1){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"no data" message:@"no data " delegate:self cancelButtonTitle:@"done" otherButtonTitles: nil];
        [alert show];
        [alert release];
        return;
    }
        
    
    if (currentAPICall==kAPIUserFriendsList&&isGetFriendsList) {
        isGetFriendsList=NO;
        NSLog(@"result friens List: %@  %d",result,[result count]);
        NSString    *idallFeed=[[NSString alloc] initWithFormat:@"100"];
        for (int i=0;i<[result count] ; i++) {
            NSDictionary* loan = [result objectAtIndex:i];
            NSString *post_id=[loan objectForKey:@"post_id"];
            int       type=[[loan objectForKey:@"type"] intValue];
            if (type==46||type==56||type==66||type==80||type==128||type==247||type==257) {
                              
                idallFeed=[idallFeed stringByAppendingFormat:[NSString stringWithFormat:@", %@",post_id]];

            }
        }
        NSLog(@"IdAllFeed= %@",idallFeed);
        NSString    *access_token=[[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
        NSString *UrlFriendsList=[[NSString alloc]initWithFormat:@"https://graph.facebook.com/?ids=%@&access_token=%@",idallFeed,access_token];
        NSURL   *url=[NSURL URLWithString:[UrlFriendsList stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
        NSLog(@"url :   %@",url);
        dispatch_async(kBgQueue, ^{
            NSData* data = [NSData dataWithContentsOfURL: url];
            [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
        });

        
        
    }else if (currentAPICall==KAPINewImage || currentAPICall==kAPINewLink) {
        NSString    *idallFeed=[[NSString alloc] initWithFormat:@"100"];
        for (int i=0;i<[result count] ; i++) {
            NSDictionary* loan = [result objectAtIndex:i];
            NSString *post_id=[loan objectForKey:@"post_id"];
                idallFeed=[idallFeed stringByAppendingFormat:[NSString stringWithFormat:@", %@",post_id]];
        }
        NSLog(@"IdAllFeed= %@",idallFeed);
        NSString    *access_token=[[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
        NSString *UrlFriendsList=[[NSString alloc]initWithFormat:@"https://graph.facebook.com/?ids=%@&access_token=%@",idallFeed,access_token];
        NSURL   *url=[NSURL URLWithString:[UrlFriendsList stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
        NSLog(@"url :   %@",url);
        dispatch_async(kBgQueue, ^{
            NSData* data = [NSData dataWithContentsOfURL: url];
            [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
        });
        

    }else {
        if ([result isKindOfClass:[NSArray class]]) {
            result = [result objectAtIndex:0];
        }
        
        //NSDictionary *nextPage=[result objectForKey:@"paging"];
        //NSString *UrlNextPage=[nextPage objectForKey:@"next"];
        
        
        NSArray *array=[result objectForKey:@"data"];
        NSLog(@"result :%@   %d",result,[array count]);
        if (array==nil) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Facebook" message:@"no data" delegate:self cancelButtonTitle:@"done"otherButtonTitles: nil];
            [alert show];
            [alert release];
            return;
        }
        UIButton *button;
        switch (currentAPICall) {
            case kAPIUSerNewFeed:
                for (int i=0;i<[array count]; i++) {
                    NSLog(@"\n\n\n result %d: %@",i,[array objectAtIndex:i]);
                    NSDictionary* loan = [array objectAtIndex:i];
                    FBFeedObject *jsonFb=[[FBFeedObject alloc] init];
                    jsonFb.idfeed=[loan objectForKey:@"id"];
                    jsonFb.from=[loan objectForKey:@"from"];
                    jsonFb.message=[loan objectForKey:@"message"];
                    jsonFb.link=[loan objectForKey:@"link"];
                    jsonFb.picture=[loan objectForKey:@"picture"];
                    jsonFb.name=[loan objectForKey:@"name"];
                    jsonFb.caption=[loan objectForKey:@"caption"];
                    jsonFb.actions=[loan objectForKey:@"actions"];
                    jsonFb.type=[loan objectForKey:@"type"];
                    jsonFb.create_time=[loan objectForKey:@"created_time"];
                    jsonFb.update_time=[loan objectForKey:@"updated_time"];
                    jsonFb.likes=[loan objectForKey:@"likes"];
                    jsonFb.comments=[loan objectForKey:@"comments"];
                    jsonFb.description=[loan objectForKey:@"description"];
                    jsonFb.source=[loan objectForKey:@"source"];
                    jsonFb.story=[loan objectForKey:@"story"];
                    jsonFb.object_id=[loan objectForKey:@"object_id"];
                    [arrayNewFeed addObject:jsonFb];
                }
                NSLog(@"actions:  %d",[arrayNewFeed count]);
                if (flipper) {
                    [flipper removeFromSuperview];
                    flipper=nil;
                    // [flipper reloadInputViews];
                    //[flipper setCurrentPage:1 animated:YES];
                }
                flipper = [[[AFKPageFlipper alloc] initWithFrame:self.view.bounds] autorelease];
                flipper.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
                flipper.dataSource = self;
                [self.view addSubview:flipper];
                
                
                button=[[UIButton  alloc] initWithFrame:CGRectMake(20, 20, 70, 37)];
                [button setImage:[UIImage imageNamed:@"btn_Ezine.png"] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(btnEzine:) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:button];
                [self.view bringSubviewToFront:btn_showList];
                [self.view bringSubviewToFront:lableFbList];
                [self.view bringSubviewToFront:ImageProlife];    
                [self.view bringSubviewToFront:activityIndicator];  
                break;
            case kAPIUserImageWall:
                for (int i=0;i<[array count]; i++) {
                    NSLog(@"\n\n\n result %d: %@",i,[array objectAtIndex:i]);
                    NSDictionary* loan = [array objectAtIndex:i];
                    FBFeedObject *jsonFb=[[FBFeedObject alloc] init];
                    jsonFb.idfeed=[loan objectForKey:@"id"];
                    jsonFb.from=[loan objectForKey:@"from"];
                    jsonFb.message=[loan objectForKey:@"message"];
                    jsonFb.link=[loan objectForKey:@"link"];
                    jsonFb.picture=[loan objectForKey:@"picture"];
                    jsonFb.name=[loan objectForKey:@"name"];
                    jsonFb.caption=[loan objectForKey:@"caption"];
                    jsonFb.actions=[loan objectForKey:@"actions"];
                    jsonFb.type=[loan objectForKey:@"type"];
                    jsonFb.create_time=[loan objectForKey:@"created_time"];
                    jsonFb.update_time=[loan objectForKey:@"updated_time"];
                    jsonFb.likes=[loan objectForKey:@"likes"];
                    jsonFb.comments=[loan objectForKey:@"comments"];
                    jsonFb.description=[loan objectForKey:@"description"];
                    jsonFb.source=[loan objectForKey:@"source"];
                    jsonFb.story=[loan objectForKey:@"story"];
                    jsonFb.object_id=[loan objectForKey:@"object_id"];
                    [arrayNewFeed addObject:jsonFb];
                    
                }
                NSLog(@"actions:  %d",[arrayNewFeed count]);
                
                
                if (flipper) {
                    [flipper removeFromSuperview];
                    flipper=nil;
                    // [flipper reloadInputViews];
                    //[flipper setCurrentPage:1 animated:YES];
                }
                flipper = [[[AFKPageFlipper alloc] initWithFrame:self.view.bounds] autorelease];
                flipper.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
                flipper.dataSource = self;
                [self.view addSubview:flipper];
                
                
                button=[[UIButton  alloc] initWithFrame:CGRectMake(20, 12, 70, 37)];
                [button setImage:[UIImage imageNamed:@"btn_Ezine.png"] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(btnEzine:) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:button];
                [self.view bringSubviewToFront:btn_showList];
                [self.view bringSubviewToFront:lableFbList];
                [self.view bringSubviewToFront:ImageProlife];    
                [self.view bringSubviewToFront:activityIndicator];  
                break;

                break;
            case kAPIUserImage:
                for (int i=0;i<[array count]; i++) {
                    NSLog(@"\n\n\n result %d: %@",i,[array objectAtIndex:i]);
                    NSDictionary* loan = [array objectAtIndex:i];
                    FBFeedObject *jsonFb=[[FBFeedObject alloc] init];
                    jsonFb.idfeed=[loan objectForKey:@"id"];
                    jsonFb.from=[loan objectForKey:@"from"];
                    jsonFb.message=[loan objectForKey:@"message"];
                    jsonFb.link=[loan objectForKey:@"link"];
                    jsonFb.picture=[loan objectForKey:@"picture"];
                    jsonFb.name=[loan objectForKey:@"name"];
                    jsonFb.caption=[loan objectForKey:@"caption"];
                    jsonFb.actions=[loan objectForKey:@"actions"];
                    jsonFb.type=[loan objectForKey:@"type"];
                    jsonFb.create_time=[loan objectForKey:@"created_time"];
                    jsonFb.update_time=[loan objectForKey:@"updated_time"];
                    jsonFb.likes=[loan objectForKey:@"likes"];
                    jsonFb.comments=[loan objectForKey:@"comments"];
                    jsonFb.description=[loan objectForKey:@"description"];
                    jsonFb.source=[loan objectForKey:@"source"];
                    jsonFb.story=[loan objectForKey:@"story"];
                    jsonFb.object_id=[loan objectForKey:@"object_id"];
                    [arrayNewFeed addObject:jsonFb];
                    
                }
                NSLog(@"actions:  %d",[arrayNewFeed count]);
                
                
                if (flipper) {
                    [flipper removeFromSuperview];
                    flipper=nil;
                    // [flipper reloadInputViews];
                    //[flipper setCurrentPage:1 animated:YES];
                }
                flipper = [[[AFKPageFlipper alloc] initWithFrame:self.view.bounds] autorelease];
                flipper.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
                flipper.dataSource = self;
                [self.view addSubview:flipper];
                
                
                button=[[UIButton  alloc] initWithFrame:CGRectMake(20, 12, 70, 37)];
                [button setImage:[UIImage imageNamed:@"btn_Ezine.png"] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(btnEzine:) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:button];
                [self.view bringSubviewToFront:btn_showList];
                [self.view bringSubviewToFront:lableFbList];
                [self.view bringSubviewToFront:ImageProlife];    
                [self.view bringSubviewToFront:activityIndicator]; 
                break;
            case KAPINewImage:
                for (int i=0;i<[array count]; i++) {
                    NSLog(@"\n\n\n result %d: %@",i,[array objectAtIndex:i]);
                    NSDictionary* loan = [array objectAtIndex:i];
                    FBFeedObject *jsonFb=[[FBFeedObject alloc] init];
                    jsonFb.idfeed=[loan objectForKey:@"id"];
                    jsonFb.from=[loan objectForKey:@"from"];
                    jsonFb.message=[loan objectForKey:@"message"];
                    jsonFb.link=[loan objectForKey:@"link"];
                    jsonFb.picture=[loan objectForKey:@"picture"];
                    jsonFb.name=[loan objectForKey:@"name"];
                    jsonFb.caption=[loan objectForKey:@"caption"];
                    jsonFb.actions=[loan objectForKey:@"actions"];
                    jsonFb.type=[loan objectForKey:@"type"];
                    jsonFb.create_time=[loan objectForKey:@"created_time"];
                    jsonFb.update_time=[loan objectForKey:@"updated_time"];
                    jsonFb.likes=[loan objectForKey:@"likes"];
                    jsonFb.comments=[loan objectForKey:@"comments"];
                    jsonFb.description=[loan objectForKey:@"description"];
                    jsonFb.source=[loan objectForKey:@"source"];
                    jsonFb.story=[loan objectForKey:@"story"];
                    jsonFb.object_id=[loan objectForKey:@"object_id"];
                    [arrayNewFeed addObject:jsonFb];
                    
                }
                NSLog(@"actions:  %d",[arrayNewFeed count]);
                
                
                if (flipper) {
                    [flipper removeFromSuperview];
                    flipper=nil;
                    // [flipper reloadInputViews];
                    //[flipper setCurrentPage:1 animated:YES];
                }
                flipper = [[[AFKPageFlipper alloc] initWithFrame:self.view.bounds] autorelease];
                flipper.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
                flipper.dataSource = self;
                [self.view addSubview:flipper];
                
                
                button=[[UIButton  alloc] initWithFrame:CGRectMake(20, 12, 70, 37)];
                [button setImage:[UIImage imageNamed:@"btn_Ezine.png"] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(btnEzine:) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:button];
                [self.view bringSubviewToFront:btn_showList];
                [self.view bringSubviewToFront:lableFbList];
                [self.view bringSubviewToFront:ImageProlife];    
                [self.view bringSubviewToFront:activityIndicator]; 
                break;
            case kAPINewLink:
                for (int i=0;i<[array count]; i++) {
                    NSLog(@"\n\n\n result %d: %@",i,[array objectAtIndex:i]);
                    NSDictionary* loan = [array objectAtIndex:i];
                    FBFeedObject *jsonFb=[[FBFeedObject alloc] init];
                    jsonFb.idfeed=[loan objectForKey:@"id"];
                    jsonFb.from=[loan objectForKey:@"from"];
                    jsonFb.message=[loan objectForKey:@"message"];
                    jsonFb.link=[loan objectForKey:@"link"];
                    jsonFb.picture=[loan objectForKey:@"picture"];
                    jsonFb.name=[loan objectForKey:@"name"];
                    jsonFb.caption=[loan objectForKey:@"caption"];
                    jsonFb.actions=[loan objectForKey:@"actions"];
                    jsonFb.type=[loan objectForKey:@"type"];
                    jsonFb.create_time=[loan objectForKey:@"created_time"];
                    jsonFb.update_time=[loan objectForKey:@"updated_time"];
                    jsonFb.likes=[loan objectForKey:@"likes"];
                    jsonFb.comments=[loan objectForKey:@"comments"];
                    jsonFb.description=[loan objectForKey:@"description"];
                    jsonFb.source=[loan objectForKey:@"source"];
                    jsonFb.story=[loan objectForKey:@"story"];
                    jsonFb.object_id=[loan objectForKey:@"object_id"];
                    [arrayNewFeed addObject:jsonFb];
                    
                }
                NSLog(@"actions:  %d",[arrayNewFeed count]);
                
                
                if (flipper) {
                    [flipper removeFromSuperview];
                    flipper=nil;
                    // [flipper reloadInputViews];
                    //[flipper setCurrentPage:1 animated:YES];
                }
                flipper = [[[AFKPageFlipper alloc] initWithFrame:self.view.bounds] autorelease];
                flipper.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
                flipper.dataSource = self;
                [self.view addSubview:flipper];
                
                
                button=[[UIButton  alloc] initWithFrame:CGRectMake(20, 12, 70, 37)];
                [button setImage:[UIImage imageNamed:@"btn_Ezine.png"] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(btnEzine:) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:button];
                [self.view bringSubviewToFront:btn_showList];
                [self.view bringSubviewToFront:lableFbList];
                [self.view bringSubviewToFront:ImageProlife];    
                [self.view bringSubviewToFront:activityIndicator]; 
                break;
            case kAPIGroup:
                for (int i=0;i<[array count]; i++) {
                    NSLog(@"\n\n\n result %d: %@",i,[array objectAtIndex:i]);
                    NSDictionary* loan = [array objectAtIndex:i];
                    FBFeedObject *jsonFb=[[FBFeedObject alloc] init];
                    jsonFb.idfeed=[loan objectForKey:@"id"];
                    jsonFb.from=[loan objectForKey:@"from"];
                    jsonFb.message=[loan objectForKey:@"message"];
                    jsonFb.link=[loan objectForKey:@"link"];
                    jsonFb.picture=[loan objectForKey:@"picture"];
                    jsonFb.name=[loan objectForKey:@"name"];
                    jsonFb.caption=[loan objectForKey:@"caption"];
                    jsonFb.actions=[loan objectForKey:@"actions"];
                    jsonFb.type=[loan objectForKey:@"type"];
                    jsonFb.create_time=[loan objectForKey:@"created_time"];
                    jsonFb.update_time=[loan objectForKey:@"updated_time"];
                    jsonFb.likes=[loan objectForKey:@"likes"];
                    jsonFb.comments=[loan objectForKey:@"comments"];
                    jsonFb.description=[loan objectForKey:@"description"];
                    jsonFb.source=[loan objectForKey:@"source"];
                    jsonFb.story=[loan objectForKey:@"story"];
                    jsonFb.object_id=[loan objectForKey:@"object_id"];
                    [arrayNewFeed addObject:jsonFb];
                    
                }
                NSLog(@"actions:  %d",[arrayNewFeed count]);
                
                
                if (flipper) {
                    [flipper removeFromSuperview];
                    flipper=nil;
                    // [flipper reloadInputViews];
                    //[flipper setCurrentPage:1 animated:YES];
                }
                flipper = [[[AFKPageFlipper alloc] initWithFrame:self.view.bounds] autorelease];
                flipper.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
                flipper.dataSource = self;
                [self.view addSubview:flipper];
                
                
                button=[[UIButton  alloc] initWithFrame:CGRectMake(20, 12, 70, 37)];
                [button setImage:[UIImage imageNamed:@"btn_Ezine.png"] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(btnEzine:) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:button];
                [self.view bringSubviewToFront:btn_showList];
                [self.view bringSubviewToFront:lableFbList];
                [self.view bringSubviewToFront:ImageProlife];    
                [self.view bringSubviewToFront:activityIndicator]; 
                break;
            case kAPIPage:
                for (int i=0;i<[array count]; i++) {
                    NSLog(@"\n\n\n result %d: %@",i,[array objectAtIndex:i]);
                    NSDictionary* loan = [array objectAtIndex:i];
                    FBFeedObject *jsonFb=[[FBFeedObject alloc] init];
                    jsonFb.idfeed=[loan objectForKey:@"id"];
                    jsonFb.from=[loan objectForKey:@"from"];
                    jsonFb.message=[loan objectForKey:@"message"];
                    jsonFb.link=[loan objectForKey:@"link"];
                    jsonFb.picture=[loan objectForKey:@"picture"];
                    jsonFb.name=[loan objectForKey:@"name"];
                    jsonFb.caption=[loan objectForKey:@"caption"];
                    jsonFb.actions=[loan objectForKey:@"actions"];
                    jsonFb.type=[loan objectForKey:@"type"];
                    jsonFb.create_time=[loan objectForKey:@"created_time"];
                    jsonFb.update_time=[loan objectForKey:@"updated_time"];
                    jsonFb.likes=[loan objectForKey:@"likes"];
                    jsonFb.comments=[loan objectForKey:@"comments"];
                    jsonFb.description=[loan objectForKey:@"description"];
                    jsonFb.source=[loan objectForKey:@"source"];
                    jsonFb.story=[loan objectForKey:@"story"];
                    jsonFb.object_id=[loan objectForKey:@"object_id"];
                    [arrayNewFeed addObject:jsonFb];
                    
                }
                NSLog(@"actions:  %d",[arrayNewFeed count]);
                
                
                if (flipper) {
                    [flipper removeFromSuperview];
                    flipper=nil;
                    // [flipper reloadInputViews];
                    //[flipper setCurrentPage:1 animated:YES];
                }
                flipper = [[[AFKPageFlipper alloc] initWithFrame:self.view.bounds] autorelease];
                flipper.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
                flipper.dataSource = self;
                [self.view addSubview:flipper];
                
                
                button=[[UIButton  alloc] initWithFrame:CGRectMake(20, 12, 70, 37)];
                [button setImage:[UIImage imageNamed:@"btn_Ezine.png"] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(btnEzine:) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:button];
                [self.view bringSubviewToFront:btn_showList];
                [self.view bringSubviewToFront:lableFbList];
                [self.view bringSubviewToFront:ImageProlife];    
                [self.view bringSubviewToFront:activityIndicator]; 
                break;
            case kAPIUserFriendsList:
                if ([array count]>1) {
                    [arrayNewFeed removeAllObjects];
                    [arrayViewController removeAllObjects];
                    
                }else {
                    for (int i=0;i<[array count]; i++) {
                        NSLog(@"\n\n\n result %d: %@",i,[array objectAtIndex:i]);
                        NSDictionary* loan = [array objectAtIndex:i];
                        FBFeedObject *jsonFb=[[FBFeedObject alloc] init];
                        jsonFb.idfeed=[loan objectForKey:@"id"];
                        jsonFb.from=[loan objectForKey:@"from"];
                        jsonFb.message=[loan objectForKey:@"message"];
                        jsonFb.link=[loan objectForKey:@"link"];
                        jsonFb.picture=[loan objectForKey:@"picture"];
                        jsonFb.name=[loan objectForKey:@"name"];
                        jsonFb.caption=[loan objectForKey:@"caption"];
                        jsonFb.actions=[loan objectForKey:@"actions"];
                        jsonFb.type=[loan objectForKey:@"type"];
                        jsonFb.create_time=[loan objectForKey:@"created_time"];
                        jsonFb.update_time=[loan objectForKey:@"updated_time"];
                        jsonFb.likes=[loan objectForKey:@"likes"];
                        jsonFb.comments=[loan objectForKey:@"comments"];
                        jsonFb.description=[loan objectForKey:@"description"];
                        jsonFb.source=[loan objectForKey:@"source"];
                        jsonFb.story=[loan objectForKey:@"story"];
                        jsonFb.object_id=[loan objectForKey:@"object_id"];
                        [arrayNewFeed addObject:jsonFb];
                        
                    }
                    NSLog(@"actions:  %d",[arrayNewFeed count]);
                    
                    
                    if (flipper) {
                        [flipper removeFromSuperview];
                        flipper=nil;
                        // [flipper reloadInputViews];
                        //[flipper setCurrentPage:1 animated:YES];
                    }
                    flipper = [[[AFKPageFlipper alloc] initWithFrame:self.view.bounds] autorelease];
                    flipper.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
                    flipper.dataSource = self;
                    [self.view addSubview:flipper];
                    
                    
                    button=[[UIButton  alloc] initWithFrame:CGRectMake(20, 12, 70, 37)];
                    [button setImage:[UIImage imageNamed:@"btn_Ezine.png"] forState:UIControlStateNormal];
                    [button addTarget:self action:@selector(btnEzine:) forControlEvents:UIControlEventTouchUpInside];
                    [self.view addSubview:button];
                    [self.view bringSubviewToFront:btn_showList];
                    [self.view bringSubviewToFront:lableFbList];
                    [self.view bringSubviewToFront:ImageProlife];    
                    [self.view bringSubviewToFront:activityIndicator]; 
                }
               
                break;
            case kAPIUserFriends:
                for (int i=0;i<[array count]; i++) {
                    NSLog(@"\n\n\n result %d: %@",i,[array objectAtIndex:i]);
                    NSDictionary* loan = [array objectAtIndex:i];
                    FBFeedObject *jsonFb=[[FBFeedObject alloc] init];
                    jsonFb.idfeed=[loan objectForKey:@"id"];
                    jsonFb.from=[loan objectForKey:@"from"];
                    jsonFb.message=[loan objectForKey:@"message"];
                    jsonFb.link=[loan objectForKey:@"link"];
                    jsonFb.picture=[loan objectForKey:@"picture"];
                    jsonFb.name=[loan objectForKey:@"name"];
                    jsonFb.caption=[loan objectForKey:@"caption"];
                    jsonFb.actions=[loan objectForKey:@"actions"];
                    jsonFb.type=[loan objectForKey:@"type"];
                    jsonFb.create_time=[loan objectForKey:@"created_time"];
                    jsonFb.update_time=[loan objectForKey:@"updated_time"];
                    jsonFb.likes=[loan objectForKey:@"likes"];
                    jsonFb.comments=[loan objectForKey:@"comments"];
                    jsonFb.description=[loan objectForKey:@"description"];
                    jsonFb.source=[loan objectForKey:@"source"];
                    jsonFb.story=[loan objectForKey:@"story"];
                    jsonFb.object_id=[loan objectForKey:@"object_id"];
                    [arrayNewFeed addObject:jsonFb];
                    
                }
                NSLog(@"actions:  %d",[arrayNewFeed count]);
                
                
                if (flipper) {
                    [flipper removeFromSuperview];
                    flipper=nil;
                    // [flipper reloadInputViews];
                    //[flipper setCurrentPage:1 animated:YES];
                }
                flipper = [[[AFKPageFlipper alloc] initWithFrame:self.view.bounds] autorelease];
                flipper.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
                flipper.dataSource = self;
                [self.view addSubview:flipper];
                
                
                button=[[UIButton  alloc] initWithFrame:CGRectMake(20, 12, 70, 37)];
                [button setImage:[UIImage imageNamed:@"btn_Ezine.png"] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(btnEzine:) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:button];
                [self.view bringSubviewToFront:btn_showList];
                [self.view bringSubviewToFront:lableFbList];
                [self.view bringSubviewToFront:ImageProlife];    
                [self.view bringSubviewToFront:activityIndicator]; 
                break;
                
            default:
                break;
        }
        
    }
              
}

- (void)fetchedData:(NSData *)responseData {
    //parse out the json data
       NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData //1
                                                         options:kNilOptions 
                                                           error:&error];
    NSLog(@"json=:%@",json);
    NSArray *array=[json allValues];
    if (currentAPICall==kAPIUserFriendsList) {
        NSLog(@"data =%d",[array count]);
        if ([array count]>1) {
            [arrayNewFeed removeAllObjects];
            [arrayViewController removeAllObjects];
            
        }
            for (int i=0;i<[array count]; i++) {
                NSLog(@"\n\n\n result %d: %@",i,[array objectAtIndex:i]);
                NSDictionary* loan = [array objectAtIndex:i];
                FBFeedObject *jsonFb=[[FBFeedObject alloc] init];
                jsonFb.idfeed=[loan objectForKey:@"id"];
                jsonFb.from=[loan objectForKey:@"from"];
                jsonFb.message=[loan objectForKey:@"message"];
                jsonFb.link=[loan objectForKey:@"link"];
                jsonFb.picture=[loan objectForKey:@"picture"];
                jsonFb.name=[loan objectForKey:@"name"];
                jsonFb.caption=[loan objectForKey:@"caption"];
                jsonFb.actions=[loan objectForKey:@"actions"];
                jsonFb.type=[loan objectForKey:@"type"];
                jsonFb.create_time=[loan objectForKey:@"created_time"];
                jsonFb.update_time=[loan objectForKey:@"updated_time"];
                jsonFb.likes=[loan objectForKey:@"likes"];
                jsonFb.comments=[loan objectForKey:@"comments"];
                jsonFb.description=[loan objectForKey:@"description"];
                jsonFb.source=[loan objectForKey:@"source"];
                jsonFb.story=[loan objectForKey:@"story"];
                jsonFb.object_id=[loan objectForKey:@"object_id"];
                [arrayNewFeed addObject:jsonFb];
                
            }
            NSLog(@"actions:  %d",[arrayNewFeed count]);
            
            if (flipper) {
                [flipper removeFromSuperview];
                flipper=nil;
                // [flipper reloadInputViews];
                //[flipper setCurrentPage:1 animated:YES];
            }
            flipper = [[[AFKPageFlipper alloc] initWithFrame:self.view.bounds] autorelease];
            flipper.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            flipper.dataSource = self;
            [self.view addSubview:flipper];
            
            
            UIButton* button=[[UIButton  alloc] initWithFrame:CGRectMake(20, 12, 70, 37)];
            [button setImage:[UIImage imageNamed:@"btn_Ezine.png"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(btnEzine:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
            [self.view bringSubviewToFront:btn_showList];
            [self.view bringSubviewToFront:lableFbList];
            [self.view bringSubviewToFront:ImageProlife];    
            [self.view bringSubviewToFront:activityIndicator]; 
        

        return;
    }else if (currentAPICall==KAPINewImage||currentAPICall==kAPINewLink) {
        NSLog(@"data =%d",[array count]);
        if ([array count]>1) {
            [arrayNewFeed removeAllObjects];
            [arrayViewController removeAllObjects];
            
        }
        for (int i=0;i<[array count]; i++) {
            NSLog(@"\n\n\n result %d: %@",i,[array objectAtIndex:i]);
            NSDictionary* loan = [array objectAtIndex:i];
            FBFeedObject *jsonFb=[[FBFeedObject alloc] init];
            jsonFb.idfeed=[loan objectForKey:@"id"];
            jsonFb.from=[loan objectForKey:@"from"];
            jsonFb.message=[loan objectForKey:@"message"];
            jsonFb.link=[loan objectForKey:@"link"];
            jsonFb.picture=[loan objectForKey:@"picture"];
            jsonFb.name=[loan objectForKey:@"name"];
            jsonFb.caption=[loan objectForKey:@"caption"];
            jsonFb.actions=[loan objectForKey:@"actions"];
            jsonFb.type=[loan objectForKey:@"type"];
            jsonFb.create_time=[loan objectForKey:@"created_time"];
            jsonFb.update_time=[loan objectForKey:@"updated_time"];
            jsonFb.likes=[loan objectForKey:@"likes"];
            jsonFb.comments=[loan objectForKey:@"comments"];
            jsonFb.description=[loan objectForKey:@"description"];
            jsonFb.source=[loan objectForKey:@"source"];
            jsonFb.story=[loan objectForKey:@"story"];
            jsonFb.object_id=[loan objectForKey:@"object_id"];
            [arrayNewFeed addObject:jsonFb];
            
        }
        NSLog(@"actions:  %d",[arrayNewFeed count]);
        
        if (flipper) {
            [flipper removeFromSuperview];
            flipper=nil;
            // [flipper reloadInputViews];
            //[flipper setCurrentPage:1 animated:YES];
        }
        flipper = [[[AFKPageFlipper alloc] initWithFrame:self.view.bounds] autorelease];
        flipper.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        flipper.dataSource = self;
        [self.view addSubview:flipper];
        
        
        UIButton* button=[[UIButton  alloc] initWithFrame:CGRectMake(20, 12, 70, 37)];
        [button setImage:[UIImage imageNamed:@"btn_Ezine.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnEzine:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        [self.view bringSubviewToFront:btn_showList];
        [self.view bringSubviewToFront:lableFbList];
        [self.view bringSubviewToFront:ImageProlife];    
        [self.view bringSubviewToFront:activityIndicator]; 
        
        
        return;

    }

            for (int i=0;i<[array count]; i++) {
                //NSLog(@"\n\n\n result %d: %@",i,[array objectAtIndex:i]);
                
                NSDictionary* loan = [array objectAtIndex:i];
                JsonFBNewFeed *jsonFb=[[JsonFBNewFeed alloc] init];
                jsonFb.title=[loan objectForKey:@"message"];
                jsonFb.urlPicture=[loan objectForKey:@"picture"];
                jsonFb.dateCreate=[loan objectForKey:@"created_time"];
                NSArray *action=[loan objectForKey:@"actions"];
                if ([action count]>1) {
                    NSDictionary *arrayAction=[action objectAtIndex:1];
                    jsonFb.linkLikeFeed=[arrayAction objectForKey:@"link"];
                }
                NSString *description=[loan objectForKey:@"description"];
                // get id, name Feed
                NSDictionary* from=[loan objectForKey:@"from"];
                if (from) {
                    jsonFb.nameProlife=[from objectForKey:@"name"];
                    NSString    *IdFeed=[[NSString alloc] initWithFormat:@"%@",[from objectForKey:@"id"] ];
                    jsonFb.idFeed=IdFeed;
                }
                // get number like
                NSDictionary* like=[loan objectForKey:@"likes"];
                jsonFb.numberUserLike=[[like objectForKey:@"count"] intValue];
                // get first name like
                NSArray *arraylike=[like objectForKey:@"data"];
                if (arraylike) {
                    NSDictionary *userLike=[arraylike objectAtIndex:0];
                    jsonFb.userLike=[userLike objectForKey:@"name"];
                }
                if ((jsonFb.urlPicture||jsonFb.title)&&!description) {
                    [arrayNewFeed addObject:jsonFb];
                }
            }
            
            [flipper setNumberOfPages:[arrayNewFeed count]];

               
    
}
#pragma mark -
#pragma mark Data source implementation


- (NSInteger) numberOfPagesForPageFlipper:(AFKPageFlipper *)pageFlipper {
    return [arrayNewFeed count];
}


- (UIView *) viewForPage:(NSInteger) page inFlipper:(AFKPageFlipper *) pageFlipper {
    
        if ([arrayViewController count]>page) {
            
            FBDetailViewController *mainView=[arrayViewController objectAtIndex:page-1];
            [mainView.view setHidden:NO];
            return mainView.view;
        }else {
            FBDetailViewController *mainView=[[FBDetailViewController alloc] initWithNibName:@"FBDetailViewController" bundle:nil];
            mainView.fliper=flipper;
            mainView.jsonFbFeed=[arrayNewFeed objectAtIndex:page-1];
            [arrayViewController addObject:mainView];
            [mainView.view setFrame:CGRectMake(0, 0, 768, 1004)];
            return mainView.view;
        }
    
   	
}

#pragma mark--- Fblist delegate
-(void)didSelectAPi:(int)APiCall{
    currentAPICall=APiCall;
    NSString *urlImage=[[VariableStore sharedInstance] urlProlifeImage];
    NSURL *url = [NSURL URLWithString:urlImage];
    ImageProlife.url = url;
    [self.imgMan manage:ImageProlife];
    
    NSLog(@"currentAPI=%d",currentAPICall);
    [arrayNewFeed removeAllObjects];
    [arrayViewController removeAllObjects];
    [self getApifeedFacebook:currentAPICall];
}
-(void)selectUserFriend:(NSString *)IdFriends andName:(NSString *)nameFriends andApiCall:(int)ApiCall{
    currentAPICall=ApiCall;
    if (ApiCall==kAPIUserFriendsList) {
        isGetFriendsList=YES;
        NSString *queryKey=[[NSString alloc] initWithFormat:@"SELECT post_id,type FROM stream WHERE filter_key in (SELECT filter_key FROM stream_filter WHERE uid=me() AND name='%@') AND is_hidden = 0 ORDER BY updated_time DESC LIMIT 40",nameFriends];
        NSMutableDictionary *params1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                        queryKey, @"query",
                                        nil];
        
        [[[FBRequestWrapper defaultManager] facebook] requestWithMethodName:@"fql.query"
                                                                  andParams:params1
                                                              andHttpMethod:@"POST"
                                                                andDelegate:self];
        
    }else {
        NSLog(@"idfriend: %@  \n name: %@",IdFriends,nameFriends);
        [self.lableFbList setText:nameFriends];
        [self showActivityIndicator];
        NSString *UrlIconFeed=[[NSString alloc] initWithFormat:@"https://graph.facebook.com/%@/picture",IdFriends];
        NSURL *urlFriendSImage = [NSURL URLWithString:UrlIconFeed];
        ImageProlife.url=urlFriendSImage;
        [self.imgMan manage:ImageProlife];
        [arrayNewFeed removeAllObjects];
        [arrayViewController removeAllObjects];
        NSString *graphPath=[[NSString alloc]initWithFormat:@"%@/feed",IdFriends];
        [[[FBRequestWrapper defaultManager] facebook] requestWithGraphPath:graphPath andDelegate:self];

    }
   }
#pragma mark-----
- (void)dealloc {
    [btn_showList release];
    [lableFbList release];
    [super dealloc];
}
@end
