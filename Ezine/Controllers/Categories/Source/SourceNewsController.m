//
//  SourceNewsController.m
//  Ezine
//
//  Created by MAC on 7/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SourceNewsController.h"
#import "PSStackedView.h"
#import "UIImage+OverlayColor.h"
#import "MenuTableViewCell.h"
#import "SourceCell.h"
#import "SiteObject.h"
#import "ListArticleViewController.h"
#import "UIViewController+MJPopupViewController.h"

#import "EzineAppdelegate.h"

#include <QuartzCore/QuartzCore.h>

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1
#define kLatestKivaLoansURL [NSURL URLWithString: @"http://api.kivaws.org/v1/loans/search.json?status=fundraising"]
#define kMenuWidth 345
#define kCellText @"CellText"
#define kCellImage @"CellImage" 

@interface JsonSourceNews : NSObject{
    int    webId;
    NSString    *name;
    NSString    *url;
    NSString    *cover;
    NSString    *title;


}
@property(nonatomic,assign)       int    webId;
@property(nonatomic,assign)    NSString    *url;
@property(nonatomic,assign)    NSString    *name;
@property(nonatomic,assign)    NSString    *cover;
@property(nonatomic,assign)    NSString    *title;

@end

@implementation JsonSourceNews
@synthesize webId,url,name,title,cover;

@end


@interface SourceNewsController ()
@property (nonatomic, strong) NSArray *cellContents;
@end

@implementation SourceNewsController
@synthesize menuTable = menuTable_;
@synthesize cellContents = cellContents_;
@synthesize _categoryID;
@synthesize imageLoadingOperation;
@synthesize activityIndicator;
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
    ezineDelegate=(EzineAppDelegate *)[[UIApplication sharedApplication] delegate];
    // Do any additional setup after loading the view from its nib.
    arrayNews=[[NSMutableArray alloc] init];
    _arrayDataListSite=[[NSMutableArray alloc]init];
    
    
#if 0
    self.view.layer.borderColor = [UIColor greenColor].CGColor;
    self.view.layer.borderWidth = 2.f;
#endif
    int xPosition = (self.view.bounds.size.width / 2.0) ;
    int yPosition = (self.view.bounds.size.height / 2.0)-100 ;
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(xPosition, yPosition, 40, 40)];
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.view addSubview:activityIndicator];


        // prepare menu content
//    NSMutableArray *contents = [[NSMutableArray alloc] init];
//    for (int i=0; i<20; i++) {
//        [contents addObject:[NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"Logo_vnex.png"], kCellImage, NSLocalizedString(@"VnExpress",@""), kCellText, nil]];
//    }
//        self.cellContents = contents;
//    
//    // add table menu
//	UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 290, kMenuWidth, 600) style:UITableViewStylePlain];
//    self.menuTable = tableView;
//    
//    self.menuTable.backgroundColor = [UIColor whiteColor];
//    self.menuTable.delegate = self;
//    self.menuTable.dataSource = self;
//    self.menuTable.showsVerticalScrollIndicator=NO;
//    [self.view addSubview:self.menuTable];
//    [self.menuTable reloadData];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self showActivityIndicator];
    [XAppDelegate.serviceEngine listSiteByCategoryID:self._categoryID onCompletion:^(NSDictionary* images) {
        _dataListSiteByCategoryID=images;
        [self fetchedData];
        
    } onError:^(NSError* error) {
        [self hideActivityIndicator];
    }];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft||toInterfaceOrientation==UIInterfaceOrientationLandscapeRight||toInterfaceOrientation==UIInterfaceOrientationPortrait||toInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
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
#pragma mark--------
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_arrayDataListSite count];
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
                cell.logoImage.contentMode = UIViewContentModeScaleToFill;
                cell.isSource=YES;
                        break;
            }
        }  

        //
    }
    SiteObject  *siteobject=[_arrayDataListSite objectAtIndex:indexPath.row];
    cell.NameSources.text = siteobject._title;
    cell.detailSource.text= siteobject._name;
    
    [cell.btnAddSource addTarget:self action:@selector(btnAddClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnAddSource setTag:indexPath.row];
    for (NSNumber *idSite in ezineDelegate.arrayIdSite) {
        if ([idSite intValue]==siteobject._siteID) {
            [cell.btnAddSource setHidden:YES];
        }
    }
    NSString *LogoUrl=siteobject._logoUrl;
    if ((NSNull *)LogoUrl==[NSNull null]) {
        LogoUrl =@"";
    }
    self.imageLoadingOperation = [XAppDelegate.serviceEngine imageAtURL:[NSURL URLWithString:LogoUrl]
                                                onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
                                                    if([LogoUrl isEqualToString:[url absoluteString]]) {
                                                        
                                                        if (isInCache) {
                                                            cell.logoImage.image = fetchedImage;
                                                            
                                                            
                                                        } else {
                                                            UIImageView *loadedImageView = [[UIImageView alloc] initWithImage:fetchedImage];
                                                            loadedImageView.frame = cell.logoImage.frame;
                                                            loadedImageView.alpha = 0;
                                                            [loadedImageView removeFromSuperview];
                                                            
                                                            cell.logoImage.image = fetchedImage;
                                                            cell.logoImage.alpha = 1;
                                                            
                                                        }
                                                    }
                                                }];
    

    if (indexPath.row<3) {
        [cell.logoImage setFrame:CGRectMake(10, 10, cell.frame.size.width-20, cell.frame.size.height-20)];
        [cell.btnAddSource setHidden:YES];
        [cell.NameSources setFrame:CGRectMake(160, 28, 170, 40)];
        [cell.NameSources setTextAlignment:UITextAlignmentRight];
        cell.NameSources.textColor=[UIColor whiteColor];
        cell.NameSources.font=[UIFont fontWithName:@"UVNHongHaHepBold" size:20];
        
        [cell.detailSource setFrame:CGRectMake(160, 52, 170, 40)];
        [cell.detailSource setTextAlignment:UITextAlignmentRight];
        cell.detailSource.textColor=[UIColor whiteColor];
        cell.detailSource.font=[UIFont fontWithName:@"UVNHongHaHep" size:18];
        
        cell.NameSources.shadowColor = [UIColor blackColor];
        cell.NameSources.shadowOffset = CGSizeMake(0, 1);
        
        cell.detailSource.shadowColor = [UIColor blackColor];
        cell.detailSource.shadowOffset = CGSizeMake(0, 1);

    }
    [cell setTag:siteobject._siteID];
    NSLog(@"iddd==== %d",cell.tag);

    return cell;
}
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row<3) {
        return 100;
    }
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {  
    UITableViewCell *cell=[(UITableView *)tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"iddd==== %d",cell.tag);
    if (self.delegate) {
        [self.delegate didSelectSite];
    }

    ListArticleViewController *vc=[[ListArticleViewController alloc] initWithNibName:@"ListArticleViewController" bundle:nil];
    [vc setSiteId:cell.tag];
    [vc loaddataFromSite];
    EzineAppDelegate *appDelegate=(EzineAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:vc animated:YES];
   }

#pragma mark--- action Add
-(void)btnAddClick:(id)sender{
    UIButton *adbutton=(UIButton *)sender;
    [adbutton setHidden:YES];
    NSLog(@"sender tag 1: %d",[sender tag]);
    SiteObject *siteObject=[_arrayDataListSite objectAtIndex:[sender tag]];
    SourceModel *sourceToAdd = [[SourceModel alloc] initWithId:siteObject._siteID image:@"addSite" title:siteObject._title isAddButton:NO isTop:NO articleList:nil];
    [XAppDelegate._arrayAllSite insertObject:sourceToAdd atIndex:XAppDelegate._arrayAllSite.count-1];
    [XAppDelegate.arrayIdSite addObject:[NSNumber numberWithInt:sourceToAdd.sourceId]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:XAppDelegate.arrayIdSite];
    [defaults setObject:data forKey:@"IdAllSite"];
    [defaults synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"KDidAddSiteNotification" object:self userInfo:nil];
}
#pragma mark--- Json
- (void)fetchedData {
    //parse out the json data
    if (_arrayDataListSite) {
        [_arrayDataListSite removeAllObjects];
    }
    if (arrayNews) {
        [arrayNews removeAllObjects];
    }
    NSLog(@"data return: %@",_dataListSiteByCategoryID);
    NSArray *arrayDataSiteTop3=[_dataListSiteByCategoryID objectForKey:@"SiteTop3"];
    NSArray *arraySiteListOthers=[_dataListSiteByCategoryID objectForKey:@"SiteListOthers"];
    for (int i=0; i<arrayDataSiteTop3.count; i++) {
        NSDictionary    *dataSite=[arrayDataSiteTop3 objectAtIndex:i];
        SiteObject      *siteObject=[[SiteObject alloc] init];
        siteObject._logoUrl=[dataSite   objectForKey:@"ImageUrl"];
        siteObject._siteID=[[dataSite objectForKey:@"SiteID"] intValue];
        siteObject._title=[dataSite objectForKey:@"Title"];
        siteObject._name=[dataSite objectForKey:@"Info"];
        [_arrayDataListSite addObject:siteObject];
    }
    for (int i=0; i<arraySiteListOthers.count; i++) {
        NSDictionary    *dataSite=[arraySiteListOthers objectAtIndex:i];
        SiteObject      *siteObject=[[SiteObject alloc] init];
        siteObject._logoUrl=[dataSite   objectForKey:@"LogoUrl"];
        siteObject._siteID=[[dataSite objectForKey:@"SiteID"] intValue];
        siteObject._title=[dataSite objectForKey:@"Title"];
        siteObject._name=[dataSite objectForKey:@"Info"];
        [_arrayDataListSite addObject:siteObject];
    }
   
    // add table menu
	UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMenuWidth, 830) style:UITableViewStylePlain];
    self.menuTable = tableView;
    
    self.menuTable.backgroundColor = [UIColor whiteColor];
    self.menuTable.delegate = self;
    self.menuTable.dataSource = self;
    self.menuTable.showsVerticalScrollIndicator=NO;
    [self.menuTable setEditing:NO];
    [self.view addSubview:self.menuTable];
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
    v.backgroundColor = [UIColor clearColor];
    [self.menuTable setTableHeaderView:v];
    [self.menuTable setTableFooterView:v];
    [v release];

    [self.menuTable reloadData];
    [self hideActivityIndicator];
}

@end
