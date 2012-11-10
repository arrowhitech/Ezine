//
//  FacebookListAccountViewController.m
//  Ezine
//
//  Created by MAC on 7/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FacebookListAccountViewController.h"
#import "SourceCell.h"
#import "VariableStore.h"
#import "FbObject.h"



static FacebookListAccountViewController* serviceLib;

@interface FacebookListAccountViewController ()
{
    NSMutableArray  *arrayFbFeed;
}
@property (nonatomic, strong)    NSMutableArray  *arrayFbFeed;


@end


@implementation FacebookListAccountViewController
@synthesize menuTable;
@synthesize activityIndicator,arrayFbFeed;
@synthesize imgMan;
@synthesize bgImage;
@synthesize btn_signOutClick;
@synthesize backClick;


+(FacebookListAccountViewController*)shareInstance {
	if (!serviceLib) {
		serviceLib = [[FacebookListAccountViewController alloc] init];
	}
	return serviceLib;
}
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
    // Activity Indicator
    arrayFbFeed=[[NSMutableArray alloc] init];
    // image cache
    self.imgMan = [[[HJObjManager alloc] init] autorelease];
	NSString* cacheDirectory = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/imgcache/imgtable/"] ;
	HJMOFileCache* fileCache = [[[HJMOFileCache alloc] initWithRootPath:cacheDirectory] retain];
	self.imgMan.fileCache = fileCache;
    // add activityIndicator
//    int xPosition = (self.view.bounds.size.width / 2.0) - 50;
//    int yPosition = (self.view.bounds.size.height / 2.0) - 150.0;
//    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(xPosition, yPosition, 100, 100)];
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [activityIndicator.layer setBackgroundColor:[[UIColor colorWithWhite: 0.0 alpha:1] CGColor]];
    CGPoint center = self.view.center;
    activityIndicator.center = center;
    
    //activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    //[self.view addSubview:activityIndicator];
    
   // [UIApplication sharedApplication].statusBarOrientation ;
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged) name:UIDeviceOrientationDidChangeNotification object:nil];

    [self getFbDetail];

}

- (void)viewDidUnload
{
    [self setBgImage:nil];
    [self setBtn_signOutClick:nil];
    [self setBackClick:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft||toInterfaceOrientation==UIInterfaceOrientationLandscapeRight||toInterfaceOrientation==UIInterfaceOrientationPortrait||toInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown);
}

#pragma -------
#pragma mark---- orientationChanged
-(void)changedLandScape{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:0.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [self.view setFrame:CGRectMake(0, 0, 1004, 768)];
    [UIView commitAnimations];
    
}

-(void)changePortrait{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:0.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [self.view setFrame:CGRectMake(0, 0, 768, 1004)];
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
#pragma mark--------
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%d [arrayFbFeed count",[arrayFbFeed count]);
    return [arrayFbFeed count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ExampleMenuCell";
    
    SourceCell *cell = (SourceCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *topLevelObject=[[NSBundle mainBundle] loadNibNamed:@"SourceCell" owner:self options:nil];
		for (id currentObject in topLevelObject) {
			
			if ([currentObject isKindOfClass:[UITableViewCell class]]) {
				
				cell=(SourceCell*)currentObject;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.NameSources.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
                cell.NameSources.contentMode=UIViewContentModeLeft;
               // cell.logoImage.contentMode = UIViewContentModeCenter;
                
				break;
            }
        }  
        
        //
    }
    FbObject *fbObject=[arrayFbFeed objectAtIndex:indexPath.row];
    cell.NameSources.text = fbObject.name;
    if (indexPath.row<3) {
        NSLog(@"url: %@",urlImage);
        HJManagedImageV *ImagePark2=[[HJManagedImageV alloc]initWithFrame:CGRectMake(15, 10, 40, 40)];
        ImagePark2.imageView.contentMode=UIViewContentModeScaleToFill;
        NSURL *url = [NSURL URLWithString:urlImage];
        ImagePark2.url = url;
        ImagePark2.oid =nil;
        [self.imgMan manage:ImagePark2];
        [cell addSubview:ImagePark2];
        }else {
        [cell.logoImage setImage:fbObject.prolifeImage];
    }
    
    
    cell.detailSource.text=fbObject.title;
    [cell.btnAddSource setTag:fbObject.typeFeed];
    [cell.btnAddSource setHidden:YES];
        
    return cell;
}
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {  
    if (indexPath.row>=5) {
        FBFriendsListViewController *fblistFriends=[[FBFriendsListViewController alloc] initWithNibName:@"FBFriendsListViewController" bundle:nil];
        [fblistFriends.view setFrame:CGRectMake(768, 0, 768, 1004 )];
        fblistFriends.delegate=self;
        [self.view addSubview:fblistFriends.view ];
        fblistFriends.currentAPI=indexPath.row;
        [fblistFriends getApiFacebook];
        CGRect menuFrame = fblistFriends.view.frame;
        menuFrame.origin.x =0;
        [UIView animateWithDuration:0.4
                              delay:0.0
                            options: UIViewAnimationOptionTransitionNone
                         animations:^{
                             fblistFriends.view.frame = menuFrame;
                         } 
                         completion:^(BOOL finished){
                             //                             if (self.delegate) {
                             //                                 [self.delegate backMenuClick];
                             //                             }
                             
                             
                         }];

    }    else {
        FacebookDetailViewController *viewdetail=[[FacebookDetailViewController alloc] init];
        [self.view addSubview:viewdetail.view];
        viewdetail.currentAPICall=[indexPath row];
        [viewdetail getApifeedFacebook:indexPath.row];
    }
    
    
    }



#pragma mark--- get facebook detail
-(void)getFbDetail{
    NSLog(@"get detail");
    [self showActivityIndicator];
    FBFeedPost *post = [[FBFeedPost alloc] initWithGetUserPermissions:self];
    [post publishPostWithDelegate:self];

}
#pragma mark----
#pragma mark FBRequestDelegate
-(void)reloaddata{
    NSLog(@"count : %d ",arrayFbFeed.count);

    [self.menuTable reloadData];

}
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
	NSLog(@"ResponseFailed: %@", error);
	
}

- (void)request:(FBRequest *)request didLoad:(id)result {
    [self hideActivityIndicator];
    if ([result isKindOfClass:[NSArray class]]) {
        result = [result objectAtIndex:0];
    }
	NSLog(@"Parsed Response FBRequest 1: %@", result);
    urlImage=nil;
    urlImage=[[NSString alloc] initWithFormat:@"%@",[result objectForKey:@"pic"]];
    NSString    *name=[result objectForKey:@"name"];
    [[NSUserDefaults standardUserDefaults] setObject:urlImage forKey:@"urlProfile"];
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"nameProfile"];

    FbObject    *fbobject=[[FbObject alloc]init];;
    fbobject.typeFeed=kAPIGraphUserPermissions;
    fbobject.urlImage=urlImage;
    fbobject.name=@"Tin mới";
    fbobject.title=@"Các mục gần đây nhất";
    NSLog(@"url: %@",fbobject.urlImage);

    [arrayFbFeed addObject:fbobject];
    
    [fbobject release];
    fbobject=[[FbObject alloc]init];
    fbobject.typeFeed=kAPIGraphUserPermissions;
    fbobject.urlImage=urlImage;
    fbobject.name=@"Trên tường của bạn";
    fbobject.title=@"";
    NSLog(@"url: %@",fbobject.urlImage);
    [arrayFbFeed addObject:fbobject];
    
    [fbobject release];
    fbobject=[[FbObject alloc]init];
    fbobject.typeFeed=kAPIGraphUserPhotosPost;
    fbobject.urlImage=urlImage;
    fbobject.name=@"Ảnh của bạn";
    fbobject.title=@"Hình ảnh mà bạn gắn thẻ";
    NSLog(@"url: %@",fbobject.urlImage);
    [arrayFbFeed addObject:fbobject];
    
    [fbobject release];
    fbobject=[[FbObject alloc]init];
    fbobject.typeFeed=kAPIGraphUserPermissions;
    fbobject.prolifeImage=[UIImage imageNamed:@"newImage_facebookFeed.png"];
    fbobject.name=@"Tin ảnh mới";
    fbobject.title=@"";
    NSLog(@"url: %@",fbobject.urlImage);
    [arrayFbFeed addObject:fbobject];

    [fbobject release];
    fbobject=[[FbObject alloc]init];
    fbobject.typeFeed=kAPIGraphUserPermissions;
    fbobject.prolifeImage=[UIImage imageNamed:@"newLinks_fbFeed.png"];
    fbobject.name=@"Link mới";
    fbobject.title=@"";
    NSLog(@"url: %@",fbobject.urlImage);
    [arrayFbFeed addObject:fbobject];
    // group
    [fbobject release];
    fbobject=[[FbObject alloc]init];
    fbobject.typeFeed=kAPIGraphUserPermissions;
    fbobject.prolifeImage=[UIImage imageNamed:@"group_fbFeed.png"];
    fbobject.name=@"Nhóm";
    fbobject.title=@"";
    [arrayFbFeed addObject:fbobject];
    
    [fbobject release];
    fbobject=[[FbObject alloc]init];
    fbobject.typeFeed=kAPIGraphUserPermissions;
    fbobject.prolifeImage=[UIImage imageNamed:@"group_fbFeed.png"];
    fbobject.name=@"Trang";
    fbobject.title=@"";
    [arrayFbFeed addObject:fbobject];

    [fbobject release];
    fbobject=[[FbObject alloc]init];
    fbobject.typeFeed=kAPIGraphUserFriends;
    fbobject.prolifeImage=[UIImage imageNamed:@"group_fbFeed.png"];
    fbobject.name=@"Danh sách bạn bè";
    fbobject.title=@"";
    [arrayFbFeed addObject:fbobject];

    [fbobject release];
    fbobject=[[FbObject alloc]init];
    fbobject.typeFeed=kAPIGraphUserFriends;
    fbobject.prolifeImage=[UIImage imageNamed:@"group_fbFeed.png"];
    fbobject.name=@"Bạn bè";
    fbobject.title=@"";
    [arrayFbFeed addObject:fbobject];
    
    [fbobject release];
    fbobject=[[FbObject alloc]init];
    //[self reloaddata];
    VariableStore *store=[VariableStore sharedInstance] ;
    if (store.arrayListFb) {
        [store.arrayListFb removeAllObjects];
    }
    store.arrayListFb=arrayFbFeed;
    store.urlProlifeImage=urlImage;
    
    FacebookDetailViewController *viewdetail=[[FacebookDetailViewController alloc] init];
    [self.view addSubview:viewdetail.view];
    viewdetail.view.frame=CGRectMake(0, 10, 768, 1004);
    viewdetail.currentAPICall=kAPIUSerNewFeed;
    [viewdetail getApifeedFacebook:kAPIUSerNewFeed];
}
#pragma mark---- signOut
- (IBAction)btnBackClick:(id)sender {
    [self.view removeFromSuperview];
}

- (IBAction)btn_SignOutClick:(id)sender {
    [[[FBRequestWrapper defaultManager] facebook] logout:self];
    [self.view removeFromSuperview];
}

#pragma mark-----FBlistFriendsDelegate
-(void)selectFriend:(NSString *)IdFriend andName:(NSString *)NameFriends andApiCall:(int)ApiCalll{
    NSLog(@"idFriend: %@  name:  %@",IdFriend,NameFriends);
}

- (void)dealloc {
    [bgImage release];
    [btn_signOutClick release];
    [backClick release];
    [super dealloc];
}

#pragma mark--- 
-(void)cancelFacebook{
    [self.view removeFromSuperview];
}
#pragma mark---
-(void)backToMainView{
    [self.view removeFromSuperview];
}
@end
