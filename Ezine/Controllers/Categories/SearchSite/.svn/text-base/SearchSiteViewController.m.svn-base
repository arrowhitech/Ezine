//
//  SearchSiteViewController.m
//  Ezine
//
//  Created by MAC on 8/15/12.
//
//

#import "SearchSiteViewController.h"
#import "EzineAppDelegate.h"

@interface SearchSiteViewController ()

@end

@implementation SearchSiteViewController

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
    _arrayDataSite=[[NSMutableArray alloc] init];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 290, 345, 600) style:UITableViewStylePlain];
    self.menuTable = tableView;
    
    self.menuTable.backgroundColor = [UIColor whiteColor];
    self.menuTable.delegate = self;
    self.menuTable.dataSource = self;
    self.menuTable.showsVerticalScrollIndicator=NO;
    [self.view addSubview:self.menuTable];
    // Do any additional setup after loading the view from its nib.
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
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_arrayDataSite count];
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
                
				break;
            }
        }
        
        //
    }
    SiteObject  *siteobject=[_arrayDataSite objectAtIndex:indexPath.row];
    cell.NameSources.text = siteobject._name;
    cell.detailSource.text=@"";
    
    [cell.btnAddSource addTarget:self action:@selector(btnAddClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnAddSource setTag:indexPath.row];
    for (NSNumber *idSite in XAppDelegate.arrayIdSite) {
        if ([idSite intValue]==siteobject._siteID) {
            [cell.btnAddSource setHidden:YES];
        }
    }
    NSString *LogoUrl=siteobject._logoUrl;
    //test logo url
    
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
    
    
       return cell;
}
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // PSStackedViewController *stackController = XAppDelegate.stackController;
    
    }

#pragma mark---- fetchedData
-(void)fetchedData:(NSMutableArray *)data{
    if (_arrayDataSite) {
        [_arrayDataSite removeAllObjects];
    }
    for (int i=0; i<[data count]; i++) {
        NSDictionary *dataSite=[data objectAtIndex:i];
        SiteObject *siteObject=[[SiteObject alloc] init];
        siteObject._logoUrl=[dataSite objectForKey:@"LogoUrl"];
        siteObject._name=[dataSite objectForKey:@"Name"];
        siteObject._siteID=[[dataSite objectForKey:@"SiteID"] intValue];
        [_arrayDataSite addObject:siteObject];
    }
    [self.menuTable reloadData];
}
#pragma mark--- search Site
-(void)startSearchSite:(NSString *)nameSite{
    
    [XAppDelegate.serviceEngine SearchSiteEngineSiteName:_nameSearch onCompletion:^(NSMutableArray* images) {
        [self fetchedData:images];
        
    } onError:^(NSError* error) {
        
    }];
    
}

#pragma mark-- add click
-(void)btnAddClick:(id)sender{
    UIButton *adbutton=(UIButton *)sender;
    [adbutton setHidden:YES];
    SiteObject *siteObject=[_arrayDataSite objectAtIndex:[sender tag]];
    NSLog(@"add %@ and %@",siteObject._title,siteObject._name);
    SourceModel *sourceToAdd = [[SourceModel alloc] initWithId:siteObject._siteID image:@"addSite" title:siteObject._name isAddButton:NO isTop:NO articleList:nil];
    [XAppDelegate._arrayAllSite insertObject:sourceToAdd atIndex:XAppDelegate._arrayAllSite.count-1];
    [XAppDelegate.arrayIdSite addObject:[NSNumber numberWithInt:sourceToAdd.sourceId]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:XAppDelegate.arrayIdSite];
    [defaults setObject:data forKey:@"IdAllSite"];
    [defaults synchronize];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"KDidAddSiteNotification" object:self userInfo:nil];
}
@end
