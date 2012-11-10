//
//  SettingforDownloadController.m
//  Ezine
//
//  Created by Admin on 7/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingforDownloadController.h"
#import "SettinforDownloadMidleCell.h"
#import "SettingforDownloadCell.h"
#import "UIViewController+MJPopupViewController.h"
#import "SettingDownloadModel.h"
#import "DownloadDataOfflineViewController.h"
#import "SiteDownloadModel.h"


@interface SettingforDownloadController ()
-(void)loadDataforDownload;
@end

@implementation SettingforDownloadController

@synthesize naviBar;
@synthesize arrayChoosen;
@synthesize tableview;
@synthesize arrayIdSiteDownload;

@synthesize delegate;
#pragma mark=========OK=============Private========
    
-(void)loadDataforDownload{    
        [tableview reloadData];
}

#pragma mark====end========    



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [self setTitle:@"Thiết lập tải nguồn tin"];
    [super viewDidLoad];
    settingSwitch=10;
    arrayIdSiteDownload=[[NSMutableArray alloc] init];
    
    [self loadDataforDownload];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)dealloc{
    [super dealloc];
    [arrayIdSiteDownload removeAllObjects];
    [arrayIdSiteDownload release];
    
    [arrayChoosen release];
    arrayChoosen =nil;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft||toInterfaceOrientation==UIInterfaceOrientationLandscapeRight||toInterfaceOrientation==UIInterfaceOrientationPortrait||toInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown);
}
#pragma mark ====TableViewdelegate=========OK======

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
    int numofRow =0;
    switch (section) {
        case 0:
            numofRow = 1;
            break;
        case 1:
            
            numofRow = 1;
            break;
        case 2:
            //numofRow = [arrayChoosen count];
            numofRow=XAppDelegate._arrayAllSite.count-1;
        default:
            break;
    }
    return numofRow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath section]==1) {
        midleCell = (SettinforDownloadMidleCell*)[tableView dequeueReusableCellWithIdentifier:@"cellMiddle"];
        if (midleCell==nil){
            NSArray *topLevelObject=[[NSBundle mainBundle] loadNibNamed:@"SettinforDownloadMidleCell" owner:self options:nil];
            for (id currentObject in topLevelObject) {
                if ([currentObject isKindOfClass:[UITableViewCell class]]) {
                    midleCell=(SettinforDownloadMidleCell*)currentObject;
                    midleCell.delegate=self;
                    break;
                }
            }  
        }
        
        return midleCell;
    }else {
        int row =indexPath.row;
        int section =indexPath.section;
        
         NSString *CellIdentifier = [NSString stringWithFormat:@"CustomTableCell[%d][%d]",section,row];
       //static NSString *CellNib = @"SettingforDownloadCell";
      
        
        cell = (SettingforDownloadCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        if (cell==nil) {
            NSArray *topLevelObject=[[NSBundle mainBundle] loadNibNamed:@"SettingforDownloadCell" owner:self options:nil];
            for (id currentObject in topLevelObject) {
                if ([currentObject isKindOfClass:[SettingforDownloadCell class]]) {
                    cell=(SettingforDownloadCell*)currentObject;
                    break;
                }
            }
            cell = (SettingforDownloadCell *)[topLevelObject objectAtIndex:0];
            
            if ([indexPath section]==0) {
                [cell.titleName setText:@"Sử dụng wifi khi tải nguồn tin"];
                [cell.Swcell addTarget:self action:@selector(btnSwichEnableWifi:) forControlEvents:UIControlEventValueChanged];
            }else {
                SourceModel *source=[XAppDelegate._arrayAllSite objectAtIndex:indexPath.row];
                [cell.titleName setText:source.title];
                
                if (indexPath.row==0) {
                    [cell.titleName setText:@"Trang tin nổi bật"];
                    
                }
                [cell.Swcell addTarget:self action:@selector(btnSwichPEnableDownload:) forControlEvents:UIControlEventValueChanged];
                if (settingSwitch==0) {
                    [cell.Swcell setOn:YES animated:YES];
                }else if (settingSwitch==1){
                    [cell.Swcell setOn:NO animated:YES];
                    
                }
                cell.Swcell.tag=source.sourceId;
                cell.tag=source.sourceId;
            }
          //  [tableView reloadRowsAtIndexPaths:tableview.indexPathsForSelectedRows withRowAnimation:UITableViewRowAnimationNone];
           // [arrTitleName addObject:dict];
            
        }
                return cell;
        
    } 

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section]==1) {
        return 50;
    }else {
        return 47;
    }
}

-(IBAction)btnSwichPEnableDownload:(id)sender{
    UISwitch* switchSite=(UISwitch*)sender;
    
    CGPoint hitPoint = [switchSite convertPoint:CGPointZero toView:tableview];
    NSIndexPath *hitIndex = [self.tableview indexPathForRowAtPoint:hitPoint];
    
    SettingforDownloadCell *cells=(SettingforDownloadCell*)[tableview cellForRowAtIndexPath:hitIndex];
    NSLog(@"id=== %d \n name== %@",cells.tag,cells.titleName.text);
    if ([switchSite isOn]) {
        SiteDownloadModel *model=[[SiteDownloadModel alloc] init];
        model.siteID=cells.tag;
        model.nameSite=cells.titleName.text;
        [arrayIdSiteDownload addObject:model];
        
        }else{
        if (arrayIdSiteDownload) {
            NSMutableArray *arrayTemb=[[NSMutableArray alloc] initWithArray:arrayIdSiteDownload];
            for (SiteDownloadModel *idsite in arrayTemb) {
                if (idsite.siteID==cells.tag) {
                    [arrayTemb removeObject:idsite];
                    break;
                }
            }
        [arrayIdSiteDownload removeAllObjects];
        arrayIdSiteDownload=[[NSMutableArray alloc] initWithArray:arrayTemb];
        }
    }
    NSLog(@"arraysite download===%@",arrayIdSiteDownload);
    
}

-(IBAction)btnSwichEnableWifi:(id)sender{
    
}

#pragma mark--- settingMiddleCell delegate
-(void)chooseAllSite:(id)sender{
    NSLog(@"choose all");
    settingSwitch=0;
    if (arrayIdSiteDownload) {
        [arrayIdSiteDownload removeAllObjects];
       // arrayIdSiteDownload=nil;
    }
    SiteDownloadModel* model1 =[[SiteDownloadModel alloc]init];
    model1.siteID =1;
    model1.nameSite =@"Trang tin nổi bật";
    [arrayIdSiteDownload addObject:model1];
    for (int i =1;i<[XAppDelegate._arrayAllSite count]-1;i++) {
         SiteDownloadModel* model =[[SiteDownloadModel alloc]init];
        SourceModel* source =[XAppDelegate._arrayAllSite objectAtIndex:i];
        NSLog(@"SourceModel==%@===%d",source.title,source.sourceId);
        model.siteID = source.sourceId;
        model.nameSite =source.title;
        [arrayIdSiteDownload addObject:model];
        // NSLog(@"arraysite download===%@",arrayIdSiteDownload);
    }
//    arrayIdSiteDownload=[[NSMutableArray alloc]initWithArray:XAppDelegate.arrayIdSite copyItems:YES];
   
    NSLog(@"arraysite download===%@",arrayIdSiteDownload);
    
    [self.tableview reloadData];

}

-(void)disableAllsite:(id)sender{
    NSLog(@"disable all");

    settingSwitch=1;
    if (arrayIdSiteDownload) {
        [arrayIdSiteDownload removeAllObjects];
    }
    [self.tableview reloadData];

}
-(void)viewDidDisappear:(BOOL)animated{
    
    if (self.delegate) {
        [self.delegate chooseDataforDownload:self];
        
    }
    [super viewDidDisappear:animated];
}
@end
