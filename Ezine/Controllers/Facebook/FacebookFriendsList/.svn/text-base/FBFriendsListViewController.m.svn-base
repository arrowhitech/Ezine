//
//  FBFriendsListViewController.m
//  Ezine
//
//  Created by MAC on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FBFriendsListViewController.h"

@interface JsonFriend : NSObject    {
    NSString    *idFriends;
    NSString    *nameFriends;
}

@property(nonatomic, retain)NSString    *idFriends;
@property(nonatomic, retain)NSString    *nameFriends;

@end

@implementation JsonFriend
@synthesize idFriends,nameFriends;


@end

@interface FBFriendsListViewController ()

@end

@implementation FBFriendsListViewController
@synthesize tableListFriends;
@synthesize activityIndicator,imgMan;
@synthesize delegate;
@synthesize currentAPI;


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
    arrayFriends=[[NSMutableArray alloc] init];
    variabelStore=[VariableStore sharedInstance];
    self.imgMan = [[[HJObjManager alloc] init] autorelease];
	NSString* cacheDirectory = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/imgcache/imgtable/"] ;
	HJMOFileCache* fileCache = [[[HJMOFileCache alloc] initWithRootPath:cacheDirectory] retain];
	self.imgMan.fileCache = fileCache;
    // add activityIndicator
    int xPosition = (self.view.bounds.size.width / 2.0) - 50;
    int yPosition = (self.view.bounds.size.height / 2.0) - 150.0;
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(xPosition, yPosition, 100, 100)];
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.view addSubview:activityIndicator];
    //[self getApiFacebook];
    
}

- (void)viewDidUnload
{
    [self setTableListFriends:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft||toInterfaceOrientation==UIInterfaceOrientationLandscapeRight||toInterfaceOrientation==UIInterfaceOrientationPortrait||toInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [tableListFriends release];
    [super dealloc];
}
#pragma mark--- activity
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


#pragma mark---
- (IBAction)btnBackClick:(id)sender {
    CGRect menuFrame = self.view.frame;
    menuFrame.origin.x =768;
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

-(void)getApiFacebook{
    [self showActivityIndicator];
    NSString *graphPath;
    NSLog(@"api: %d",currentAPI);
    switch (currentAPI) {
        case kAPIGroup:
            graphPath=@"me/groups";
            break;
        case kAPIPage:
            graphPath=@"me/likes";
            break;
        case kAPIUserFriends:
            graphPath=@"me/friends";
            break;
        case kAPIUserFriendsList:
            graphPath=@"me/friendlists";
            break;
        default:
            break;
    }
    [[[FBRequestWrapper defaultManager] facebook] requestWithGraphPath:graphPath andDelegate:self];
}
-(void)getGroups{
    [[[FBRequestWrapper defaultManager] facebook] requestWithGraphPath:@"me/groups" andDelegate:self];}
#pragma mark--- FBrequestWrapper delegate
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    [self hideActivityIndicator];
	NSLog(@"ResponseFailed: %@", error);
	
}

- (void)request:(FBRequest *)request didLoad:(id)result {
    [self hideActivityIndicator];
    if ([result isKindOfClass:[NSArray class]]) {
        result = [result objectAtIndex:0];
    }
    NSArray *dataReturn=[result objectForKey:@"data"];
    for (int i=0; i<[dataReturn count]; i++) {
        NSDictionary *dataFriend=[dataReturn objectAtIndex:i];
        JsonFriend *jsonFriend=[[[JsonFriend alloc] init]autorelease];
        jsonFriend.idFriends=[dataFriend objectForKey:@"id"];
        jsonFriend.nameFriends=[dataFriend objectForKey:@"name"];
        [arrayFriends addObject:jsonFriend];
    }
    [self.tableListFriends reloadData];
    NSLog(@"result: %@",result);
}
#pragma mark--------
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
       return [arrayFriends count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ExampleMenuCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        // Show disclosure only if this view is related to showing nearby places, thus allowing
        // the user to check-in.
        }
        
        //
    
    JsonFriend *jsonFriend=[arrayFriends objectAtIndex:indexPath.row];
    UILabel *labeltext=[[UILabel alloc] initWithFrame:CGRectMake(100, 15, 300, 25)];
    [labeltext setText:jsonFriend.nameFriends];
    [labeltext setFont:[UIFont boldSystemFontOfSize:18]];
    [cell addSubview:labeltext];
    [labeltext release];
    [cell.detailTextLabel setText:@""];
    HJManagedImageV *userFeedIcon=[[HJManagedImageV alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
    userFeedIcon.imageView.contentMode=UIViewContentModeScaleToFill;
    NSString *UrlIconFeed=[[NSString alloc] initWithFormat:@"https://graph.facebook.com/%@/picture",jsonFriend.idFriends];
    NSLog(@"UrlIconFeed:%@",UrlIconFeed);
    NSURL *url = [NSURL URLWithString:UrlIconFeed];
    userFeedIcon.url = url;
    userFeedIcon.oid =nil;
    [self.imgMan manage:userFeedIcon];
    [cell addSubview:userFeedIcon];
    return cell;
}
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {  
      JsonFriend *jsonFriend=[arrayFriends objectAtIndex:indexPath.row];  
            if (self.delegate) {
            [delegate selectFriend:jsonFriend.idFriends andName:jsonFriend.nameFriends andApiCall:currentAPI];
        }  
        

    
    CGRect menuFrame = self.view.frame;
    menuFrame.origin.x =768;
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


@end
