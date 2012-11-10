//
//  YourEzineControllerViewController.m
//  Ezine
//
//  Created by MAC on 7/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "YourEzineControllerViewController.h"
#import "PSStackedView.h"
#import "UIImage+OverlayColor.h"
#import "MenuTableViewCell.h"
#import "SourceCell.h"
#import "EzineAppdelegate.h"
#include <QuartzCore/QuartzCore.h>
#import "MyLauncherView.h"
#import "SourceModel.h"
#import "SectionHeaderView.h"
#import "SectionInfo.h"
#import "Play.h"

#define kMenuWidth 345
#define kCellText @"CellText"
#define kCellImage @"CellImage"
#define DEFAULT_ROW_HEIGHT 78
#define HEADER_HEIGHT 45

@interface YourEzineControllerViewController ()

@property (nonatomic, assign) NSInteger openSectionIndex;
@property (nonatomic, strong) NSArray *cellContents;
@property (nonatomic, strong) NSMutableArray* sectionInfoArray;

@end

@implementation YourEzineControllerViewController
@synthesize openSectionIndex=openSectionIndex_;
@synthesize menuTable = menuTable_;
@synthesize cellContents = cellContents_;
@synthesize imageLoadingOperation,activityIndicator,sectionInfoArray,plays;

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
#if 0
    self.view.layer.borderColor = [UIColor greenColor].CGColor;
    self.view.layer.borderWidth = 2.f;
#endif
    
    // add example background
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    
    // prepare menu content
    _arraySiteUSer=[[NSMutableArray alloc] init];
    _arraySiteUSerAdd=[[NSMutableArray alloc] init];
    sectionInfoArray=[[NSMutableArray alloc] init];
    plays=[[NSMutableArray alloc] init];
    openSectionIndex_ = NSNotFound;
    _site=0;
    NSString *accesstoken=[[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    if (accesstoken==nil||[accesstoken length]<2) {
        NSLog(@"not login");
        _isLoginFacebook=NO;
    }else{
        _isLoginFacebook=YES;
    }
    [XAppDelegate.serviceEngine getListArticleUserKeyword:^(NSMutableArray* data){
        NSLog(@"list site user add====%@",data);
        [self fetchedDataUserKeyWordAdd:data];
    } onError:^(NSError* error) {
        
    }];
    
    [self LoadDataSiteUser];
    // add table menu
	self.menuTable = [[UITableView alloc] initWithFrame:CGRectMake(10, 20, kMenuWidth, self.view.height-40) style:UITableViewStylePlain];
    
    self.menuTable.backgroundColor = [UIColor whiteColor];
    self.menuTable.showsVerticalScrollIndicator=NO;
    [self.view addSubview:self.menuTable];
    int xPosition = (self.view.bounds.size.width / 2.0) ;
    int yPosition = (self.view.bounds.size.height / 2.0)-100 ;
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(xPosition, yPosition, 40, 40)];
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.view addSubview:activityIndicator];
    [self showActivityIndicator];
    //[self.menuTable reloadData];
    
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

#pragma mark------ modify
-(IBAction)btnModify:(id)sender{
    if ([self.menuTable isEditing]) {
        [self.menuTable setEditing:NO animated:YES];
        
    }else {
        [self.menuTable setEditing:YES animated:YES];
        
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDataSource
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"indexpah===%d",indexPath.row);
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.menuTable beginUpdates];
        
        //add code here for when you hit delete
        NSLog(@"indexpah===%d",indexPath.row);
        if (indexPath.section==0) {
            if (_isLoginFacebook) {
                if (indexPath.row==0) {
                    _isLoginFacebook=NO;
                }else {
                    SectionInfo *sectionInfo = [self.sectionInfoArray objectAtIndex:0];
                    [sectionInfo.play.quotations removeLastObject];
                    [_arraySiteUSer removeObjectAtIndex:indexPath.row-1];
                    MyLauncherItem *item=[[MyLauncherItem alloc] init];
                    item._sourcemoder=[[SourceModel alloc] init];
                    item._sourcemoder.sourceId=[[XAppDelegate.arrayIdSite objectAtIndex:indexPath.row-1] intValue];
                    NSDictionary *info = [NSDictionary dictionaryWithObject:item forKey:@"item"];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:KDidDeleteSiteNotification object:self userInfo:info];
                    
                }
            }else {
                MyLauncherItem *item=[[MyLauncherItem alloc] init];
                item._sourcemoder=[[SourceModel alloc] init];
                item._sourcemoder.sourceId=[[XAppDelegate.arrayIdSite objectAtIndex:indexPath.row] intValue];
                NSDictionary *info = [NSDictionary dictionaryWithObject:item forKey:@"item"];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:KDidDeleteSiteNotification object:self userInfo:info];
                [_arraySiteUSer removeObjectAtIndex:indexPath.row];
                SectionInfo *sectionInfo = [self.sectionInfoArray objectAtIndex:0];
                [sectionInfo.play.quotations removeLastObject];
                
            }
            [self.menuTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.menuTable endUpdates];
        }else{
            [_arraySiteUSerAdd removeObjectAtIndex:indexPath.row];
            SectionInfo *sectionInfo = [self.sectionInfoArray objectAtIndex:1];
            [sectionInfo.play.quotations removeLastObject];
            [self.menuTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.menuTable endUpdates];
            
        }
        
        
    }
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    SectionInfo *sectionInfo = [self.sectionInfoArray objectAtIndex:section];
    NSInteger numStoriesInSection = [[sectionInfo.play quotations] count];
    NSLog(@"nember cell=== %d",numStoriesInSection);
    if (section==1) {
        if (_isLoginFacebook) {
            return sectionInfo.open ? numStoriesInSection : 0;
        }else{
            return sectionInfo.open ? numStoriesInSection : 0;
        }
        
    }else{
        if (numStoriesInSection==0) {
            return 0;
        }
        return sectionInfo.open ? numStoriesInSection : 0;
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
                
                //                cell.NameSources.shadowOffset = CGSizeMake(0, 2);
                //                cell.NameSources.shadowColor = [UIColor colorWithWhite:0 alpha:0.25];
                cell.NameSources.contentMode=UIViewContentModeLeft;
                cell.logoImage.contentMode = UIViewContentModeCenter;
                cell.NameSources.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
                cell.NameSources.contentMode=UIViewContentModeLeft;
                cell.logoImage.contentMode = UIViewContentModeScaleToFill;
				break;
            }
        }
    }
    if (indexPath.section==0) {
        cell.section=0;
//        if (_isLoginFacebook) {
//            if (indexPath.row==0) {
//                NSString    *urlLogoSite=[[NSUserDefaults standardUserDefaults]objectForKey:@"urlProfile"];
//                NSString    *name=[[NSUserDefaults standardUserDefaults]objectForKey:@"nameProfile"];
//                cell.NameSources.text=@"Facebook";
//                cell.detailSource.text=name;
//                
//                if ((NSNull *)urlLogoSite==[NSNull null]) {
//                    urlLogoSite =@"";
//                }
//                self.imageLoadingOperation = [XAppDelegate.serviceEngine imageAtURL:[NSURL URLWithString:urlLogoSite]
//                                                                       onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
//                                                                           if([urlLogoSite isEqualToString:[url absoluteString]]) {
//                                                                               
//                                                                               if (isInCache) {
//                                                                                   cell.logoImage.image = fetchedImage;
//                                                                                   //     [self hideActivityIndicator];
//                                                                                   
//                                                                               } else {
//                                                                                   
//                                                                                   
//                                                                                   
//                                                                                   cell.logoImage.image = fetchedImage;
//                                                                                   cell.logoImage.alpha = 1;
//                                                                                   // [self hideActivityIndicator];
//                                                                                   
//                                                                               }
//                                                                           }
//                                                                       }];
//                [cell.btnAddSource addTarget:self action:@selector(btnAddClick:) forControlEvents:UIControlEventTouchUpInside];
//                [cell.btnAddSource setTag:indexPath.row];
//                
//            }else{
//                
//            }
//            NSDictionary *datasite=[_arraySiteUSer objectAtIndex:indexPath.row-1];
//            if ([datasite objectForKey:@"Name"]==[NSNull null]) {
//                cell.NameSources.text =@"";
//
//            }else{
//                cell.NameSources.text = [datasite objectForKey:@"Name"];
//
//            }
//            if ([datasite objectForKey:@"Info"]==[NSNull null]) {
//                cell.detailSource.text =@"";
//                
//            }else{
//                cell.detailSource.text = [datasite objectForKey:@"Info"];
//                
//            }
//            NSString *urlLogoSite=[datasite objectForKey:@"LogoUrl"];
//            if ((NSNull *)urlLogoSite==[NSNull null]) {
//                urlLogoSite =@"";
//            }
//            self.imageLoadingOperation = [XAppDelegate.serviceEngine imageAtURL:[NSURL URLWithString:urlLogoSite]
//                                                                   onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
//                                                                       if([urlLogoSite isEqualToString:[url absoluteString]]) {
//                                                                           
//                                                                           if (isInCache) {
//                                                                               cell.logoImage.image = fetchedImage;
//                                                                               //     [self hideActivityIndicator];
//                                                                               
//                                                                           } else {
//                                                                               
//                                                                               
//                                                                               
//                                                                               cell.logoImage.image = fetchedImage;
//                                                                               cell.logoImage.alpha = 1;
//                                                                               // [self hideActivityIndicator];
//                                                                               
//                                                                           }
//                                                                       }
//                                                                   }];
//            
//            [cell.btnAddSource addTarget:self action:@selector(btnAddClick:) forControlEvents:UIControlEventTouchUpInside];
//            [cell.btnAddSource setTag:[[datasite objectForKey:@"SiteID"] integerValue]];
//            
//            
//        }else{
            NSDictionary *datasite=[_arraySiteUSer objectAtIndex:indexPath.row];
            if ([datasite objectForKey:@"Name"]==[NSNull null]) {
                cell.NameSources.text =@"";
                
            }else{
                cell.NameSources.text = [datasite objectForKey:@"Name"];
                
            }
            if ([datasite objectForKey:@"Info"]==[NSNull null]) {
                cell.detailSource.text =@"";
                
            }else{
                cell.detailSource.text = [datasite objectForKey:@"Info"];
                
            }
            NSString *urlLogoSite=[datasite objectForKey:@"LogoUrl"];
            if ((NSNull *)urlLogoSite==[NSNull null]) {
                urlLogoSite =@"";
            }
            self.imageLoadingOperation = [XAppDelegate.serviceEngine imageAtURL:[NSURL URLWithString:urlLogoSite]
                                                                   onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
                                                                       if([urlLogoSite isEqualToString:[url absoluteString]]) {
                                                                           
                                                                           if (isInCache) {
                                                                               cell.logoImage.image = fetchedImage;
                                                                               //     [self hideActivityIndicator];
                                                                               
                                                                           } else {
                                                                               
                                                                               
                                                                               
                                                                               cell.logoImage.image = fetchedImage;
                                                                               cell.logoImage.alpha = 1;
                                                                               // [self hideActivityIndicator];
                                                                               
                                                                           }
                                                                       }
                                                                   }];
            
            [cell.btnAddSource addTarget:self action:@selector(btnAddClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.btnAddSource setTag:[[datasite objectForKey:@"SiteID"] integerValue]];
            
        //}
        
        [cell.btnAddSource setHidden:YES];
        return cell;
        
    }else{
        cell.section=1;
        NSDictionary *data=[_arraySiteUSerAdd objectAtIndex:indexPath.row];
        NSString *nameKeyword=[data objectForKey:@"Keyword"];
        int       keyWordID=[[data objectForKey:@"KeywordID"]integerValue];
        [cell.logoImage setImage:[UIImage imageNamed:@"img_logoEzine.png"]];
        [cell.NameSources setFont:[UIFont fontWithName:@"UVNHongHaHepBold" size:17]];
        cell.NameSources.frame=CGRectMake(70, 18, 232, 21);
        
        cell.NameSources.text=[NSString stringWithFormat:@"Ezine - %@",nameKeyword];
        cell.detailSource.text=@"";
        [cell.btnAddSource setHidden:YES];
        [cell setTag:keyWordID];
        return cell;
    }
    
}
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDelegate
-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section {
    
    /*
     Create the section header views lazily.
     */
	SectionInfo *sectionInfo = [self.sectionInfoArray objectAtIndex:section];
    if (!sectionInfo.headerView) {
        NSString *playName;
        if (section==0) {
            playName=@"Nguồn Tin Của Bạn";
        }else if (section==1){
            playName=@"Nguồn Tin Theo Chủ Đề";
        }
        sectionInfo.headerView = [[SectionHeaderView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.menuTable.bounds.size.width, HEADER_HEIGHT) title:playName section:section delegate:self];
    }
    
    return sectionInfo.headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return HEADER_HEIGHT;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark--- action Add
-(void)btnAddClick:(id)sender{
    
    NSLog(@"sender tag: %d",[sender tag]);
}
#pragma mark----- reload tableview
-(void)reloadTableview{
    NSMutableArray *infoArray = [[NSMutableArray alloc] init];
    
    
    SectionInfo *sectionInfo = [[SectionInfo alloc] init];
    sectionInfo.play=[[Play alloc] init];
    sectionInfo.play.quotations = [[NSMutableArray alloc] initWithArray:_arraySiteUSer copyItems:YES];;
    sectionInfo.open = NO;
    
    NSNumber *defaultRowHeight = [NSNumber numberWithInteger:DEFAULT_ROW_HEIGHT];
    NSInteger countOfQuotations = [[sectionInfo.play quotations] count];
    for (NSInteger i = 0; i < countOfQuotations; i++) {
        [sectionInfo insertObject:defaultRowHeight inRowHeightsAtIndex:i];
    }
    
    [infoArray addObject:sectionInfo];
    SectionInfo *sectionInfo1 = [[SectionInfo alloc] init];
    sectionInfo1.play=[[Play alloc] init];
    sectionInfo1.play.quotations = [[NSMutableArray alloc] initWithArray:_arraySiteUSerAdd copyItems:YES];;
    sectionInfo1.open = NO;
    
    NSNumber *defaultRowHeight1 = [NSNumber numberWithInteger:DEFAULT_ROW_HEIGHT];
    NSInteger countOfQuotations1 = [[sectionInfo1.play quotations] count];
    for (NSInteger i = 0; i < countOfQuotations1; i++) {
        [sectionInfo1 insertObject:defaultRowHeight1 inRowHeightsAtIndex:i];
    }
    
    [infoArray addObject:sectionInfo1];
    
    self.sectionInfoArray = infoArray;
    NSLog(@"sectioninfoArray===%d",sectionInfoArray.count);
    self.menuTable.delegate = self;
    self.menuTable.dataSource = self;
    [self.menuTable reloadData];
}
#pragma mark--- load data site user add
-(void)fetchedDataUserKeyWordAdd:(NSMutableArray*)data{
    if (_arraySiteUSerAdd) {
        [_arraySiteUSerAdd removeAllObjects];
    }
    _arraySiteUSerAdd=[[NSMutableArray alloc] initWithArray:data copyItems:YES];
    [plays addObject:_arraySiteUSerAdd];
    if (plays.count==2) {
        [self reloadTableview];
    }
}

#pragma mark--- load data site
-(void)fetchedData:(NSDictionary*)data{
    [_arraySiteUSer addObject:data];
    _site++;
    if (_site<[XAppDelegate.arrayIdSite count]) {
        [self LoadDataSiteUser];
    }else{
        [plays addObject:_arraySiteUSer];
        if (plays.count==2) {
            [self reloadTableview];
        }
        [self hideActivityIndicator];
    }
}
-(void) LoadDataSiteUser{
    
    [XAppDelegate.serviceEngine getDetailAsite:[[XAppDelegate.arrayIdSite objectAtIndex:_site] integerValue] onCompletion:^(NSDictionary* data) {
       // NSLog(@"data site===%@",data);
        [self fetchedData:data];
        
    } onError:^(NSError* error) {
       
    }];
    
}
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
#pragma mark Section header delegate

-(void)sectionHeaderView:(SectionHeaderView*)sectionHeaderView sectionOpened:(NSInteger)sectionOpened {
	
	SectionInfo *sectionInfo = [self.sectionInfoArray objectAtIndex:sectionOpened];
	
	sectionInfo.open = YES;
    
    /*
     Create an array containing the index paths of the rows to insert: These correspond to the rows for each quotation in the current section.
     */
    NSInteger countOfRowsToInsert = [sectionInfo.play.quotations count];
    NSMutableArray *indexPathsToInsert = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < countOfRowsToInsert; i++) {
        [indexPathsToInsert addObject:[NSIndexPath indexPathForRow:i inSection:sectionOpened]];
    }
    
    /*
     Create an array containing the index paths of the rows to delete: These correspond to the rows for each quotation in the previously-open section, if there was one.
     */
    NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
    
    NSInteger previousOpenSectionIndex = self.openSectionIndex;
    if (previousOpenSectionIndex != NSNotFound) {
		
		SectionInfo *previousOpenSection = [self.sectionInfoArray objectAtIndex:previousOpenSectionIndex];
        previousOpenSection.open = NO;
        [previousOpenSection.headerView toggleOpenWithUserAction:NO];
        NSInteger countOfRowsToDelete = [previousOpenSection.play.quotations count];
        for (NSInteger i = 0; i < countOfRowsToDelete; i++) {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:previousOpenSectionIndex]];
        }
    }
    
    // Style the animation so that there's a smooth flow in either direction.
    UITableViewRowAnimation insertAnimation;
    UITableViewRowAnimation deleteAnimation;
    if (previousOpenSectionIndex == NSNotFound || sectionOpened < previousOpenSectionIndex) {
        insertAnimation = UITableViewRowAnimationTop;
        deleteAnimation = UITableViewRowAnimationBottom;
    }
    else {
        insertAnimation = UITableViewRowAnimationBottom;
        deleteAnimation = UITableViewRowAnimationTop;
    }
    
    // Apply the updates.
    [self.menuTable beginUpdates];
    [self.menuTable insertRowsAtIndexPaths:indexPathsToInsert withRowAnimation:insertAnimation];
    [self.menuTable deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:deleteAnimation];
    [self.menuTable endUpdates];
    self.openSectionIndex = sectionOpened;
    
}


-(void)sectionHeaderView:(SectionHeaderView*)sectionHeaderView sectionClosed:(NSInteger)sectionClosed {
    
    /*
     Create an array of the index paths of the rows in the section that was closed, then delete those rows from the table view.
     */
	SectionInfo *sectionInfo = [self.sectionInfoArray objectAtIndex:sectionClosed];
	
    sectionInfo.open = NO;
    NSInteger countOfRowsToDelete = [self.menuTable numberOfRowsInSection:sectionClosed];
    
    if (countOfRowsToDelete > 0) {
        NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < countOfRowsToDelete; i++) {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:sectionClosed]];
        }
        [self.menuTable deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:UITableViewRowAnimationTop];
    }
    self.openSectionIndex = NSNotFound;
}



@end
