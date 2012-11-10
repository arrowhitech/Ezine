//
//  FbListPopUpViewController.m
//  Ezine
//
//  Created by MAC on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FbListPopUpViewController.h"
#import "SourceCell.h"
#import "FacebookListAccountViewController.h"
#import "FbObject.h"


@interface FbListPopUpViewController (){

    NSMutableArray  *arrayFbList;
}
@property (nonatomic, strong)    NSMutableArray  *arrayFbList;


@end

@implementation FbListPopUpViewController
@synthesize tableListFb;
@synthesize imgMan;
@synthesize arrayFbList;
@synthesize delegate;
@synthesize isShowMenu;
@synthesize bgImage;

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
    // image cache
    self.imgMan = [[[HJObjManager alloc] init] autorelease];
	NSString* cacheDirectory = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/imgcache/imgtable/"] ;
	HJMOFileCache* fileCache = [[[HJMOFileCache alloc] initWithRootPath:cacheDirectory] retain];
	self.imgMan.fileCache = fileCache;
    arrayFbList=[[VariableStore sharedInstance]arrayListFb];
    [self.tableListFb reloadData];
}

- (void)viewDidUnload
{
    [self setTableListFb:nil];
    [self setBgImage:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft||toInterfaceOrientation==UIInterfaceOrientationLandscapeRight||toInterfaceOrientation==UIInterfaceOrientationPortrait||toInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown);
}


- (void)dealloc {
    [tableListFb release];
    [bgImage release];
    [super dealloc];
}

#pragma mark--------
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrayFbList count];
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
    FbObject *fbObject=[arrayFbList objectAtIndex:indexPath.row];
    cell.NameSources.text = fbObject.name;
    if (indexPath.row<3) {
        NSString *urlImage=[[VariableStore sharedInstance] urlProlifeImage];
        NSLog(@"urlaaa: %@",urlImage);
        NSURL *url = [NSURL URLWithString:urlImage];
        HJManagedImageV *ImagePark2=[[HJManagedImageV alloc]initWithFrame:CGRectMake(15, 10, 40, 40)];
        ImagePark2.imageView.contentMode=UIViewContentModeScaleToFill;
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
    if (indexPath.row<5) {
        if (self.delegate) {
            [delegate didSelectAPi:indexPath.row];
        }
    }else if (indexPath.row>=5){
        FBFriendsListViewController *fblistFriends=[[FBFriendsListViewController alloc] initWithNibName:@"FBFriendsListViewController" bundle:nil];
        [fblistFriends.view setFrame:CGRectMake(768, 0, 768, 1004 )];
        fblistFriends.delegate=self;
        [self.view.superview addSubview:fblistFriends.view ];
        [self.view.superview bringSubviewToFront:fblistFriends.view];
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
        
    }
    [self showout];
}

#pragma mark--- showin showout
-(void)showin{
    [self.view setHidden:NO];
    CGRect menuFrame = self.view.frame;
    //CGRect imageFrame = self.tableListFb.frame;
 
    menuFrame.size.height = 840;
    //imageFrame.size.height = 700;

    [UIView animateWithDuration:0.2
                          delay:0.0
                        options: UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.view.frame = menuFrame;
                        // self.tableListFb.frame=imageFrame;
                     } 
                     completion:^(BOOL finished){
                         NSLog(@"Done!");
                         CGRect imageFrame = self.tableListFb.frame;
                         imageFrame.size.height = 700;
                         self.tableListFb.frame=imageFrame;
                     }];
    isShowMenu=YES;
}
-(void)showout{
    CGRect menuFrame = self.view.frame;
  //  CGRect imageFrame = self.tableListFb.frame;
    menuFrame.size.height = 20;
    //imageFrame.size.height = 10;

    [UIView animateWithDuration:0.2
                          delay:0.0
                        options: UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.view.frame = menuFrame;
                         //self.tableListFb.frame=imageFrame;
                     } 
                     completion:^(BOOL finished){
                         NSLog(@"Done!");
                         [self.view setHidden:YES];
                     }];
    isShowMenu=NO;

}
#pragma mark---
-(void) selectFriend:(NSString *)IdFriend andName:(NSString *)NameFriends andApiCall:(int)ApiCalll{
   // NSLog(@"idfriend: %@  \n name: %@",IdFriend,NameFriends);
    if (self.delegate) {
        [delegate selectUserFriend:IdFriend andName:NameFriends andApiCall:ApiCalll];
    }
    [self showout];
}

@end
