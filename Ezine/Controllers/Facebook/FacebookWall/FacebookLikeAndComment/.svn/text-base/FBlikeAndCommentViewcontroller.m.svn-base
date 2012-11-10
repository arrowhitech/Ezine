//
//  FBlikeAndCommentViewcontroller.m
//  Ezine
//
//  Created by MAC on 8/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FBlikeAndCommentViewcontroller.h"
#import "SourceCell.h"

@interface JsonCommentAndLike : NSObject    {
    NSString    *idFriends;
    NSString    *nameFriends;
    NSString    *messages;

}

@property(nonatomic, retain)NSString    *idFriends;
@property(nonatomic, retain)NSString    *nameFriends;
@property(nonatomic, retain)NSString    *messages;

@end

@implementation JsonCommentAndLike
@synthesize idFriends,nameFriends,messages;


@end

@interface FBlikeAndCommentViewcontroller ()

@end

@implementation FBlikeAndCommentViewcontroller
@synthesize tableCommentAndLike;
@synthesize jsonFbFeed,imgMan,activityIndicator;


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
    arrayLike=[[NSMutableArray alloc] init];
    arrayComment=[[NSMutableArray alloc] init];
    
    self.imgMan = [[[HJObjManager alloc] init] autorelease];
	NSString* cacheDirectory = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/imgcache/imgtable/"] ;
	HJMOFileCache* fileCache = [[[HJMOFileCache alloc] initWithRootPath:cacheDirectory] autorelease];
	self.imgMan.fileCache = fileCache;
    
    int xPosition = (self.view.bounds.size.width / 2.0) - 50;
    int yPosition = (self.view.bounds.size.height / 2.0) - 150.0;
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(xPosition, yPosition, 100, 100)];
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.view addSubview:activityIndicator];
    
}

- (void)viewDidUnload
{
    [self setTableCommentAndLike:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft||toInterfaceOrientation==UIInterfaceOrientationLandscapeRight||toInterfaceOrientation==UIInterfaceOrientationPortrait||toInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [tableCommentAndLike release];
    [super dealloc];
}
#pragma mark----
-(void)showIn{
    CGRect menuFrame = self.view.frame;
    menuFrame.origin.y = 0;
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options: UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.view.frame = menuFrame;
                     } 
                     completion:^(BOOL finished){
                         NSLog(@"Done!");
                     }];
}

-(void)showOut{
    CGRect menuFrame = self.view.frame;
    menuFrame.origin.y =1024;
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options: UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.view.frame = menuFrame;
                     } 
                     completion:^(BOOL finished){
                         [self.view removeFromSuperview];
                         //                             if (self.delegate) {
                         //                                 [self.delegate backMenuClick];
                         //                             }
                         
                         
                     }];
    
}

#pragma mark----activityIndicator
/*
 * This method shows the activity indicator and
 * deactivates the table to avoid user input.
 */
- (void)showActivityIndicator {
    if (![activityIndicator isAnimating]) {
        [activityIndicator startAnimating];
        self.tableCommentAndLike.scrollEnabled=NO;
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
        self.tableCommentAndLike.scrollEnabled=YES;

    }
    
}
#pragma mark---- action hanlde

- (IBAction)btnLikesClicks:(id)sender {
    [self showActivityIndicator];
    int countLike=[[jsonFbFeed.likes objectForKey:@"count"] intValue];

    NSString *idfeed=jsonFbFeed.idfeed;
    NSString *graphPath=[[NSString alloc]initWithFormat:@"%@/likes&limit=%d",idfeed,countLike];
    [[[FBRequestWrapper defaultManager] facebook] requestWithGraphPath:graphPath andDelegate:self];
    isShowComment=NO;
    
}

- (IBAction)btnCommentClicks:(id)sender {
    
    [self showActivityIndicator];
    int countComment=[[jsonFbFeed.comments objectForKey:@"count"] intValue];

    NSString *idfeed=jsonFbFeed.idfeed;
    NSString *graphPath=[[NSString alloc]initWithFormat:@"%@/comments&limit=%d",idfeed,countComment];
    [[[FBRequestWrapper defaultManager] facebook] requestWithGraphPath:graphPath andDelegate:self];
    isShowComment=NO;

    isShowComment=YES;

}

#pragma mark---- 
#pragma mark FBRequestDelegate

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    [self hideActivityIndicator];
	NSLog(@"ResponseFailed: %@", error);
	
}

- (void)request:(FBRequest *)request didLoad:(id)result {
    NSArray *array=[result objectForKey:@"data"];
    if (isShowComment) {
        if (arrayComment) {
            [arrayComment removeAllObjects];
        }
        for (int i=0; i<[array count]; i++) {
            NSDictionary* loan = [array objectAtIndex:i];
            JsonCommentAndLike *comment=[[[JsonCommentAndLike alloc] init]autorelease];
            comment.messages=[loan objectForKey:@"message"];
            NSDictionary    *from=[loan objectForKey:@"from"];
            comment.idFriends=[from objectForKey:@"id"];
            comment.nameFriends=[from objectForKey:@"name"];
            [arrayComment addObject:comment];
        }
    }else {
        if (arrayLike) {
            [arrayLike removeAllObjects];
        }
        for (int i=0; i<[array count]; i++) {
            NSDictionary* loan = [array objectAtIndex:i];
            JsonCommentAndLike *likes=[[[JsonCommentAndLike alloc] init]autorelease];
            likes.idFriends=[loan objectForKey:@"id"];
            likes.nameFriends=[loan objectForKey:@"name"];
            [arrayLike addObject:likes];
        }
    }
    [self.tableCommentAndLike reloadData];
    [self hideActivityIndicator];
}
#pragma mark--------
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (isShowComment) {
        return [arrayComment count];
    }else {
        return [arrayLike count];
    }
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
    if (isShowComment) {
        JsonCommentAndLike *comment=[arrayComment objectAtIndex:indexPath.row];
        cell.NameSources.text=comment.nameFriends;
        cell.detailSource.text=comment.messages;
        [cell.btnAddSource setHidden:YES];
        HJManagedImageV *userFeedIcon=[[HJManagedImageV alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
        userFeedIcon.imageView.contentMode=UIViewContentModeScaleToFill;
        NSString *UrlIconFeed=[[NSString alloc] initWithFormat:@"https://graph.facebook.com/%@/picture",comment.idFriends];
        NSLog(@"UrlIconFeed:%@",UrlIconFeed);
        NSURL *url = [NSURL URLWithString:UrlIconFeed];
        userFeedIcon.url = url;
        userFeedIcon.oid =nil;
        [self.imgMan manage:userFeedIcon];
        [cell addSubview:userFeedIcon];

    }else {
        JsonCommentAndLike *like=[arrayLike objectAtIndex:indexPath.row];
        cell.NameSources.text=like.nameFriends;
        cell.detailSource.text=@"";
        [cell.btnAddSource setHidden:YES];
        HJManagedImageV *userFeedIcon=[[HJManagedImageV alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
        userFeedIcon.imageView.contentMode=UIViewContentModeScaleToFill;
        NSString *UrlIconFeed=[[NSString alloc] initWithFormat:@"https://graph.facebook.com/%@/picture",like.idFriends];
        NSLog(@"UrlIconFeed:%@",UrlIconFeed);
        NSURL *url = [NSURL URLWithString:UrlIconFeed];
        userFeedIcon.url = url;
        userFeedIcon.oid =nil;
        [self.imgMan manage:userFeedIcon];
        [cell addSubview:userFeedIcon];

    }
       return cell;
}
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (isShowComment) {
        return 100;
    }else {
        return 60;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    }



@end
