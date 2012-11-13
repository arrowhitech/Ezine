//
//  LastestOfSource.m
//  Ezine
//
//  Created by PDG2 on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListArticleRelative.h"
#import "LastestCell.h"
#import "ServiceEngine.h"
#import "EzineAppdelegate.h"
#import "ArticleModel.h"
#import "EzineAppdelegate.h"
#import "Utils.h"

@implementation ListArticleRelative
@synthesize listLastest=listLastest_;
@synthesize _siteId,delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(300.0,550.0);
    self.title=@"Tin mới nhất";
    
    self.listLastest = [[NSMutableArray alloc] init];
    _arrayListArticle =[[NSMutableArray alloc] init];
    _arrayListNewArticle=[[NSMutableArray alloc] init];
	
//	NSArray *countriesToLiveInArray = [NSArray arrayWithObjects:@"Iceland", @"Greenland", @"Switzerland", @"Norway", @"New Zealand", @"Greece", @"Italy", @"Ireland", nil];
//	NSDictionary *countriesToLiveInDict = [NSDictionary dictionaryWithObjectsAndKeys:countriesToLiveInArray,@"articles",@"Thể thao",@"title", nil];
//	
//	NSArray *countriesLivedInArray = [NSArray arrayWithObjects:@"India", @"U.S.A", nil];
//	NSDictionary *countriesLivedInDict = [NSDictionary dictionaryWithObjectsAndKeys:countriesLivedInArray,@"articles",@"Văn hoá",@"title", nil];
//	
	//[self.listLastest addObject:countriesToLiveInDict];
	//[self.listLastest addObject:countriesLivedInDict];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated {
    //    [XAppDelegate.listCategoriesOfSourceEngine listCategoryForSource:1 onCompletion:^(NSMutableArray *responeArray){
    //        self.listCategories = responeArray;
    //        [self.tableView reloadData];
    //    }onError:^(NSError* error) {
    //        NSLog(@"%@",error.localizedDescription);
    //    }];
    //
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft||toInterfaceOrientation==UIInterfaceOrientationLandscapeRight||toInterfaceOrientation==UIInterfaceOrientationPortrait||toInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown);
}



#pragma mark -
#pragma mark Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    // Return the number of sections.
//    return 1;
//}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
  
	return [self.listLastest count];
}


//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    NSDictionary *dictionary = [self.listLastest objectAtIndex:section];
//    
//    UIView *headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 25)];
//    [headerView setBackgroundColor:COLOR(176, 175, 175)];
//    UILabel *headerLable=[[UILabel alloc] initWithFrame:CGRectZero];
//    [headerLable setBackgroundColor:[UIColor clearColor]];
//    headerLable.contentMode=UIViewContentModeLeft;
//    headerLable.textAlignment=UITextAlignmentLeft;
//    headerLable.textColor=[UIColor whiteColor];
//    // [headerLable setFont:[UIFont fontWithName:@"MyriadPro-Semibold" size:14+XAppDelegate.appFontSize]];
//    [headerLable setFont:[UIFont fontWithName:@"MyriadPro-Semibold" size:14]];
//    
//    [headerLable setText:[dictionary objectForKey:@"Name"]];
//    headerLable.frame=CGRectMake(5,10, 150, 25);
//    headerLable.numberOfLines=0;
//    [headerLable sizeToFit];
//    [headerView addSubview:headerLable];
//    
//    UILabel *headerLableTime=[[UILabel alloc] initWithFrame:CGRectZero];
//    [headerLableTime setBackgroundColor:[UIColor clearColor]];
//    headerLableTime.contentMode=UIViewContentModeRight;
//    headerLableTime.textAlignment=UITextAlignmentRight;
//    headerLableTime.textColor=[UIColor whiteColor];
//    //[headerLableTime setFont:[UIFont fontWithName:@"MyriadPro-Semibold" size:14+XAppDelegate.appFontSize]];
//    [headerLableTime setFont:[UIFont fontWithName:@"MyriadPro-Semibold" size:14]];
//    
//    [headerLableTime setText:[Utils dateStringFromTimestamp:[dictionary objectForKey:@"PublishTime"]]];
//    headerLableTime.frame=CGRectMake(5,3, 300-10, 25);
//    [headerView addSubview:headerLableTime];
//    
//    return headerView;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 35;
//}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"LastestCell";
    
    LastestCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *topLevelObject=[[NSBundle mainBundle] loadNibNamed:@"LastestCell" owner:self options:nil];
		for (id currentObject in topLevelObject) {
			
			if ([currentObject isKindOfClass:[UITableViewCell class]]) {
				cell=(LastestCell*)currentObject;
				break;
            }
        }
    }
    
    NSDictionary *dictionary = [self.listLastest objectAtIndex:indexPath.row];
    [cell setData:dictionary];
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSLog(@"sender tag=== %d",cell.tag );
//    ArticleModel *model=[[ArticleModel alloc] init];
//    model._ArticleID=cell.tag;
//    model._idLayout=-10;
    if (self.delegate&&[self.delegate respondsToSelector:@selector(didSelectArticle:)]) {
        [self.delegate didSelectArticle:cell.tag];
    }
  //  [[EzineAppDelegate instance] showViewInFullScreen:nil withModel:model];
    
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    self.listLastest = nil;
    [super dealloc];
}

#pragma mark---- get data from service
-(void) fetchedData:(NSDictionary *)data{
    _layoutID=[[data objectForKey:@"LayoutID"] intValue];
    self.listLastest= [data objectForKey:@"ListNewArticle"];
    if ([self.listLastest count]>=1) {
        [self.tableView reloadData];
    }else{
        //        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Bài viết mới nhất" message:@"không có dữ liệu" delegate:self cancelButtonTitle:@"done" otherButtonTitles: nil];
        //        [alertView show];
        //        [alertView release];
        //        NSLog(@"no data");
    }
}

-(void) getLastestSource{
    
    [XAppDelegate.serviceEngine GetListArticleRelative:self._siteId onCompletion:^(NSMutableArray* data) {
        if (data&&data.count>=1) {
            self.listLastest=data;
            NSLog(@"data=== %@",self.listLastest);
            [self.tableView reloadData];
        }
    } onError:^(NSError* error) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Can not connect to service" delegate:self cancelButtonTitle:@"done" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }];
    
}
@end
