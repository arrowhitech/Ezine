//
//  SalientNewsViewController.m
//  Ezine
//
//  Created by MAC on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SalientNewsViewController.h"
#import "PSStackedView.h"
#import "UIImage+OverlayColor.h"
#import "MenuTableViewCell.h"
#import "SourceCell.h"
#import "CellSalientNews.h"
#import "EzineAppdelegate.h"
#import "SiteObject.h"
#import "ListArticleViewController.h"
#include <QuartzCore/QuartzCore.h>

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1
#define kLatestKivaLoansURL [NSURL URLWithString: @"http://api.ezine.vn/home/GetListSite"]

#define kMenuWidth 345
#define kCellText @"CellText"
#define kCellImage @"CellImage" 

@interface JsonSalientNews : NSObject{
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

@implementation JsonSalientNews
@synthesize webId,url,name,title,cover;

@end

@interface JsonLocation : NSObject{
    int    locationId;
    NSString    *name;
   
    
    
}
@property(nonatomic,assign)       int    locationId;
@property(nonatomic,assign)    NSString    *name;


@end

@implementation JsonLocation
@synthesize locationId,name;

@end

@interface SalientNewsViewController ()
@property (nonatomic, strong) NSMutableArray *arrayLocation;
@property (nonatomic, strong) NSMutableArray *arraySlientNews;
@property (nonatomic, strong) NSMutableArray *arrayNameLocation;

@end

@implementation SalientNewsViewController
@synthesize LocationStartpoint;
@synthesize menuTable = menuTable_;
@synthesize arrayLocation = arrayLocation_;
@synthesize arraySlientNews;
@synthesize chooseLocation,showLocation,nameLocation,arrayNameLocation;
@synthesize imageLoadingOperation;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self orientationChanged];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    arrayNameLocation=[[NSMutableArray alloc] init];
    arrayLocation_=[[NSMutableArray alloc] init];
    arraySlientNews=[[NSMutableArray alloc] init];
    _arrayDataJsonreturn=[[NSMutableArray alloc] init];
    _delegate=(EzineAppDelegate*)[[UIApplication sharedApplication] delegate];
#if 0
    self.view.layer.borderColor = [UIColor greenColor].CGColor;
    self.view.layer.borderWidth = 2.f;
#endif
    
    self.menuTable = [[UITableView alloc] initWithFrame:CGRectMake(10, 80, kMenuWidth, self.view.height-80) style:UITableViewStylePlain];
    
    self.menuTable.backgroundColor = [UIColor whiteColor];
    self.menuTable.delegate = self;
    self.menuTable.dataSource = self;
    self.menuTable.showsVerticalScrollIndicator=NO;
    [self.view addSubview:self.menuTable];
    
    
    [[UIDevice currentDevice] orientation];
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged) name:UIDeviceOrientationDidChangeNotification object:nil];
    

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    // add example background
    [XAppDelegate.serviceEngine getLastestForSourceOnCompletion:^(NSMutableArray* images) {
        _arrayDataJsonreturn=images;
        [self fetchedData];
    } onError:^(NSError* error) {
        
    }];
}

- (void)viewDidUnload
{
    [self setLocationStartpoint:nil];
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
    [UIView setAnimationDelay:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
   // [self.menuTable setFrame:CGRectMake(10, 10, 345, 580)];
    [self.nameLocation   setFrame:CGRectMake(204, 610, 115, 24)];
    [self.chooseLocation setFrame:CGRectMake(204,625 ,115 ,24 )];
    [self.showLocation   setFrame:CGRectMake(310, 610, 32, 30)];
    [self.LocationStartpoint setFrame:CGRectMake(204, 527, 115, 37)];
    [viewLocation setRefView:self.LocationStartpoint];
    [UIView commitAnimations];

}
-(void)changePortrait{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
   // [self.menuTable setFrame:CGRectMake(10, 10, 345, 850)];
    [self.chooseLocation setFrame:CGRectMake(204,890,115 ,24 )];
    [self.nameLocation   setFrame:CGRectMake(204, 875, 115, 24)];
    [self.showLocation   setFrame:CGRectMake(310, 875, 32, 30)];
    [self.LocationStartpoint setFrame:CGRectMake(204, 763, 115, 37)];
    [viewLocation setRefView:self.LocationStartpoint];
    [UIView commitAnimations];

}

-(void)orientationChanged{
    if ([UIApplication sharedApplication].statusBarOrientation==UIInterfaceOrientationLandscapeLeft||[UIApplication sharedApplication].statusBarOrientation==UIInterfaceOrientationLandscapeRight) {
        [self changedLandScape];
        NSLog(@"orientationChanged");
    }else if([UIApplication sharedApplication].statusBarOrientation==UIInterfaceOrientationPortrait||[UIApplication sharedApplication].statusBarOrientation==UIInterfaceOrientationPortraitUpsideDown){
            [self changePortrait];
            
        
    }

}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"        return [arraySlientNews count] %d",[arraySlientNews count]);
        return [arraySlientNews count];
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
        static NSString *CellIdentifier = @"ExampleMenuCell";
        
        CellSalientNews *cell = (CellSalientNews*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *topLevelObject=[[NSBundle mainBundle] loadNibNamed:@"CellSalientNews" owner:self options:nil];
            for (id currentObject in topLevelObject) {
                
                if ([currentObject isKindOfClass:[UITableViewCell class]]) {
                    
                    cell=(CellSalientNews*)currentObject;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.imageNews.contentMode = UIViewContentModeScaleToFill;
                    [cell.detailNews setTextAlignment:UITextAlignmentRight];
                    cell.detailNews.font=[UIFont fontWithName:@"TimesNewRomanPSMT" size:25];
                    cell.detailNews.shadowColor = [UIColor blackColor];
                    cell.detailNews.shadowOffset = CGSizeMake(0, 1);
                    break;
                }
            }  
            
            //
        }
        SiteObject *jsonNews=[arraySlientNews objectAtIndex:indexPath.row];
        cell.detailNews.text=jsonNews._title;
    
    if ((NSNull *)jsonNews._logoUrl==[NSNull null]) {
        jsonNews._logoUrl =@"";
    }
        self.imageLoadingOperation = [XAppDelegate.serviceEngine imageAtURL:[NSURL URLWithString:jsonNews._logoUrl]
                                                      onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
                                                          if([jsonNews._logoUrl isEqualToString:[url absoluteString]]) {
                                                              
                                                              if (isInCache) {
                                                                  cell.imageNews.image = fetchedImage;
                                                                  
                                                                  
                                                              } else {
                                                                  UIImageView *loadedImageView = [[UIImageView alloc] initWithImage:fetchedImage];
                                                                  loadedImageView.frame = cell.imageNews.frame;
                                                                  loadedImageView.alpha = 0;
                                                                  [loadedImageView removeFromSuperview];
                                                                  
                                                                  cell.imageNews.image = fetchedImage;
                                                                  cell.imageNews.alpha = 1;
                                                                  
                                                              }
                                                          }
                                                      }];
    
    
    [cell.detailNews setTag:indexPath.row];
    [cell setTag:jsonNews._siteID];
    if (indexPath.row<3) {
        
        [cell.detailNews setOrigin:CGPointMake(160, 135)];

    }
        return cell;
        
    }
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath row]<3) {
        return 180;
    }else {
        return 100;
    }
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {  
    // PSStackedViewController *stackController = XAppDelegate.stackController;
    UITableViewCell *cell=[(UITableView *)tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"iddd==== %d",cell.tag);
    if (self.delegate) {
        [self.delegate didSelectSiteInSalentNews];
    }
    
    ListArticleViewController *vc=[[ListArticleViewController alloc] initWithNibName:@"ListArticleViewController" bundle:nil];
    [vc setSiteId:cell.tag];
    [vc loaddataFromSite];
    EzineAppDelegate *appDelegate=(EzineAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:vc animated:YES];


    
}
#pragma ----mark--- button handle
-(void)btnDetail:(id)sender{
}

//======== show location
-(void)btnshowClick:(id)sender{
    if ([viewLocation.view isHidden]) {
        [viewLocation openAnimation];
    }else {
        [viewLocation closeAnimation];
    }
}
- (void)fetchedData{
    //parse out the json data
    
    //2
    if (arraySlientNews) {
        [arraySlientNews removeAllObjects];
    }
    if (arrayLocation_) {
        [arrayLocation_ removeAllObjects];
    }
    for (int i=0;i<[_arrayDataJsonreturn count]; i++) {
        NSDictionary *datareturn=[_arrayDataJsonreturn objectAtIndex:i];
        SiteObject *siteObject=[[[SiteObject alloc] init] autorelease];
        siteObject._logoUrl=[datareturn objectForKey:@"MainHeadImageUr"];
        siteObject._title=[datareturn objectForKey:@"Title"];
        siteObject._siteID=[[datareturn objectForKey:@"SiteID"] intValue];
        [arraySlientNews addObject:siteObject];
    }
    
            //test data location
    
    for (int i=0;i<10; i++) {
        JsonLocation *jsonobject=[[[JsonLocation alloc]init] autorelease];
        jsonobject.locationId=i;
        jsonobject.name=@"Viet Nam";
        [arrayLocation_ addObject:jsonobject];
        [arrayNameLocation addObject:jsonobject.name];
    }
    NSLog(@"array Slient New: %d",[arraySlientNews count]);
    [self.menuTable reloadData];
    viewLocation=[[DropDownView alloc] initWithArrayData:arrayNameLocation cellHeight:30 heightTableView:80 paddingTop:-8 paddingLeft:-5 paddingRight:-10 refView:self.LocationStartpoint animation:BLENDIN openAnimationDuration:0.2 closeAnimationDuration:0.2];
    viewLocation.delegate=self;
    [self.view addSubview:viewLocation.view];
}
- (void)dealloc {
    [LocationStartpoint release];
    [super dealloc];
}

#pragma mark--- dropview delegate
-(void)dropDownCellSelected:(NSInteger)returnIndex{
    self.nameLocation.text=[arrayNameLocation objectAtIndex:returnIndex]; 
}
@end
