//
//  CategoriesController.m
//  Ezine
//
//  Created by MAC on 7/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CategoriesController.h"
#import "PSStackedView.h"
#import "UIImage+OverlayColor.h"
#import "MenuTableViewCell.h"
#import "SourceNewsController.h"
#import "UIViewController+MJPopupViewController.h"

#import <QuartzCore/QuartzCore.h>

#define kMenuWidth 130
#define kCellText @"CellText"
#define kCellImage @"CellImage"
#define KCellTag    @"CellTag"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1
#define kLatestKivaLoansURL [NSURL URLWithString: @"http://api.kivaws.org/v1/loans/search.json?status=fundraising"] //2
#define LandScapeWeith   236
#define LandScapeHeigh  236
#define SEARCHBAR_BORDER_TAG 1337

@interface JsonCatalogies : NSObject{
    int    CatelogyId;
    NSString    *namePaper;
    NSString    *detailPaper;
}
@property(nonatomic,assign)       int    CatelogyId;
@property(nonatomic,assign)    NSString    *nameNews;

@end

@implementation JsonCatalogies
@synthesize nameNews,CatelogyId;

@end

@interface NSDictionary(JSONCategories)
+(NSDictionary*)dictionaryWithContentsOfJSONURLString:(NSString*)urlAddress;
-(NSData*)toJSON;
@end

@implementation NSDictionary(JSONCategories)
+(NSDictionary*)dictionaryWithContentsOfJSONURLString:(NSString*)urlAddress
{
    NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString: urlAddress] ];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

-(NSData*)toJSON
{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}
@end

@interface CategoriesController ()
@property (nonatomic, strong) NSArray *cellContents;


@end


@implementation CategoriesController
@synthesize menuTables;
@synthesize cellContents = cellContents_;
@synthesize searchInformation;
@synthesize labelDetail;
@synthesize activityIndicator;
@synthesize delegate,bg_image;

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
    CategoriesInform=[[NSMutableArray alloc] init];
    currentCell=[[CategoriesCell alloc] init];
    currentCell.tag=-1;
    [XAppDelegate.serviceEngine ListCategories:^(NSMutableArray* images) {
        
        if ([CategoriesInform isEqualToArray:images]) {
            NSLog(@"cached data categories");
        }else{
            if (CategoriesInform) {
                [CategoriesInform removeAllObjects];
                CategoriesInform=[[NSMutableArray alloc] initWithArray:images copyItems:YES];
            }
            [self fetchedData];
        }
    } onError:^(NSError* error) {
        
    }];
    // Do any additional setup after loading the view from its nib.
    [labelDetail setFont:[UIFont fontWithName:@"UVNHongHaHep" size:27]];
    [labelDetail setTextColor:RGBCOLOR(101, 101, 101)];
    
    [searchInformation setFrame:CGRectMake(125,17, 347,40)];
    [searchInformation setTintColor:[UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1.0]];
    [searchInformation setDelegate:self];
    UIView *bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0,searchInformation.frame.size.height-1,searchInformation.frame.size.width, 1)];
    [bottomBorder setBackgroundColor:[UIColor colorWithRed:237.0/255 green:237.0/255 blue:237.0/255 alpha:1.0]];
    [bottomBorder setOpaque:YES];
    [bottomBorder setTag:SEARCHBAR_BORDER_TAG];
    [searchInformation addSubview:bottomBorder];
    //[searchInformation setContentInset:UIEdgeInsetsMake(5, 0, 5, 35)];
    UITextField* searchField = nil;
    
    for (UIView *searchBarSubview in [searchInformation subviews]) {
        if ([searchBarSubview isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
            [(UITextField *)searchBarSubview setBackground:[UIImage imageNamed:@"searchboxbg.png"]];
            [(UITextField *)searchBarSubview setBackgroundColor:[UIColor clearColor]];
            searchField = (UITextField*)searchBarSubview;
            [searchField setTextAlignment:UITextAlignmentCenter];
        }
        
    }
    [bottomBorder release];
    int xPosition = (self.view.bounds.size.width / 2.0) ;
    int yPosition = (self.view.bounds.size.height / 2.0) ;
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(xPosition, yPosition, 40, 40)];
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.view addSubview:activityIndicator];
    [self showActivityIndicator];
    CategoriesInform=[[NSMutableArray alloc] init];
    
    
#if 0
    self.view.layer.borderColor = [UIColor greenColor].CGColor;
    self.view.layer.borderWidth = 2.f;
#endif
    
    // add example background
    // self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    
    // prepare menu content
    
    if ([UIApplication sharedApplication].statusBarOrientation==UIInterfaceOrientationLandscapeLeft||[UIApplication sharedApplication].statusBarOrientation==UIInterfaceOrientationLandscapeRight){
        [self.view setFrame:CGRectMake(self.view.frame.origin.x, 0, 477, 768)];
        
    }else if ([UIApplication sharedApplication].statusBarOrientation==UIInterfaceOrientationPortrait||[UIApplication sharedApplication].statusBarOrientation==UIInterfaceOrientationPortraitUpsideDown){
        [self.view setFrame:CGRectMake(self.view.frame.origin.x, 0, 477, 1004)];
        
    }
    
    
    [[UIDevice currentDevice] orientation] ;
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    
}
- (void)viewDidUnload
{
    [self setLabelDetail:nil];
    [self setBg_image:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)dealloc {
    [labelDetail release];
    [menuTables release];
    [bg_image release];
    [super dealloc];
}
//===========

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft||toInterfaceOrientation==UIInterfaceOrientationLandscapeRight||toInterfaceOrientation==UIInterfaceOrientationPortrait||toInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown);
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
#pragma mark--------
#pragma mark--------orientationChanged

-(void)orientationChanged{
    if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeLeft||[[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeRight) {
        weight=LandScapeHeigh;
        [self changedLandScape];
        NSLog(@"orientationChanged");
    }else if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortrait||[[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortraitUpsideDown){
        weight=0;
        [self changePortrait];
        
    }
    
}

-(void)changedLandScape{
    NSLog(@"changedLandScape");
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    [self.view setFrame:CGRectMake(self.view.frame.origin.x, 10, 480, 768)];
    [bg_image setFrame:CGRectMake(0, 34, 477, 768)];
    if (yourEzine) {
        [yourEzine.view setFrame:CGRectMake(131, 80, 345, self.view.frame.size.height-80)];
        [yourEzine.menuTable setFrame:CGRectMake(0, 55, 345, yourEzine.view.frame.size.height-55)];
    }
    if (accountScreen) {
        [accountScreen.view setFrame:CGRectMake(131, 80, 345,self.view.frame.size.height-80)];
        [accountScreen.menuTable setFrame:CGRectMake(0, 10, 345, accountScreen.view.frame.size.height-20)];
    }
    if (salientNewsScreen) {
        [salientNewsScreen.view setFrame:CGRectMake(131, 80, 345, self.view.frame.size.height-80)];
        [salientNewsScreen.menuTable setFrame:CGRectMake(0, 10, 345, salientNewsScreen.view.frame.size.height-20)];
    }
    [UIView commitAnimations];
}
-(void)changePortrait{
    NSLog(@"changePortTrait");
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    [self.view setFrame:CGRectMake(self.view.frame.origin.x, 10, 480, 1004)];
    [bg_image setFrame:CGRectMake(0, 23, 477, 1004)];
    if (yourEzine) {
        [yourEzine.view setFrame:CGRectMake(131, 80, 345, self.view.frame.size.height-80)];
        [yourEzine.menuTable setFrame:CGRectMake(0, 55, 345, yourEzine.view.frame.size.height-55)];
    }
    if (accountScreen) {
        [accountScreen.view setFrame:CGRectMake(131, 80, 345,self.view.frame.size.height-80)];
        [accountScreen.menuTable setFrame:CGRectMake(0, 10, 345, accountScreen.view.frame.size.height-20)];
    }
    if (salientNewsScreen) {
        [salientNewsScreen.view setFrame:CGRectMake(131, 80, 345, self.view.frame.size.height-80)];
        [salientNewsScreen.menuTable setFrame:CGRectMake(0, 10, 345, salientNewsScreen.view.frame.size.height-20)];
    }

    [UIView commitAnimations];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [cellContents_ count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ExampleMenuCell";
    
    CategoriesCell *cell = (CategoriesCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSLog(@"new cell");
        cell = [[CategoriesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.text = [[cellContents_ objectAtIndex:indexPath.row] objectForKey:kCellText];
        cell.textLabel.font=[UIFont fontWithName:@"UVNHongHaHep" size:18];
        [cell.textLabel setTextColor:RGBCOLOR(101, 101, 101)];
        
        cell.imageView.image = [[cellContents_ objectAtIndex:indexPath.row] objectForKey:kCellImage];
        [cell.imageView setFrame:CGRectMake(0, 0, 21, 16)];
        [cell.imageView setContentMode:UIViewContentModeScaleAspectFill];
        NSInteger tagID=[[[cellContents_ objectAtIndex:indexPath.row] objectForKey:KCellTag] integerValue];
        [cell setTag:tagID];
        
    }
    //if (indexPath.row == 5)
    //    cell.enabled = NO;
    
    return cell;
}
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // PSStackedViewController *stackController = XAppDelegate.stackController;
    
    CategoriesCell *cell = (CategoriesCell*)[tableView cellForRowAtIndexPath:indexPath];
    // reset image choose( cell 0,1,2)
    if (currentCell.tag==0) {
        [currentCell.imageView setImage:[UIImage imageNamed:@"EZ_categories.png"]];
        
    }else if (currentCell.tag==1){
        [currentCell.imageView setImage:[UIImage imageNamed:@"Account_Catogories.png"]];
        
    }else if (currentCell.tag==2){
        [currentCell.imageView setImage:[UIImage imageNamed:@"NewsFloating_catogories.png"]];
        
    }
    //===== set image when celll choose
    if (indexPath.row ==0) {
        [cell.imageView setImage:[UIImage imageNamed:@"img_ezineChoose.png"]];
    }else if (indexPath.row==1){
        [cell.imageView setImage:[UIImage imageNamed:@"img_accountChoose"]];
    }else if (indexPath.row==2){
        [cell.imageView setImage:[UIImage imageNamed:@"img_starChoose.png"]];
    }
    currentCell=cell;
    if (indexPath.row == 0) {
        if (yourEzine) {
            [self.view bringSubviewToFront:yourEzine.view];
        }else {
            yourEzine=[[YourEzineControllerViewController alloc]init];
            [yourEzine.view setFrame:CGRectMake(131, 80, 345, self.view.frame.size.height-80)];
            [yourEzine.menuTable setFrame:CGRectMake(0, 55, 345, yourEzine.view.frame.size.height-55)];
            [yourEzine.view setBackgroundColor:[UIColor whiteColor]];
            [self.view addSubview:yourEzine.view];
            
        }
    }else if(indexPath.row == 1) {
        if (accountScreen) {
            [self.view bringSubviewToFront:accountScreen.view];
        }else {
            accountScreen=[[AccountViewController alloc]init];
            [accountScreen.view setFrame:CGRectMake(131, 80, 345,self.view.frame.size.height-80)];
            [accountScreen.menuTable setFrame:CGRectMake(0, 10, 345, 830-weight)];
            [accountScreen.view setBackgroundColor:[UIColor whiteColor]];
            accountScreen.view.tag=-1000;
            [self.view addSubview:accountScreen.view];
            
        }
        
        
    }else if(indexPath.row == 2) { // Twitter style
        if (salientNewsScreen) {
            [salientNewsScreen.view removeFromSuperview];
            [salientNewsScreen release];
            salientNewsScreen=[[SalientNewsViewController alloc]init];
            [salientNewsScreen.view setFrame:CGRectMake(131, 80, 345, self.view.frame.size.height-80)];
            [salientNewsScreen.menuTable setFrame:CGRectMake(0, 10, 345, 830-weight)];
            [salientNewsScreen.view setBackgroundColor:[UIColor whiteColor]];
            salientNewsScreen.delegate=self;
            [self.view addSubview:salientNewsScreen.view];
            
        }else {
            salientNewsScreen=[[SalientNewsViewController alloc]init];
            salientNewsScreen.delegate=self;
            [salientNewsScreen.view setFrame:CGRectMake(131, 80, 345, self.view.frame.size.height-80)];
            [salientNewsScreen.menuTable setFrame:CGRectMake(0, 10, 345, 830-weight)];
            [salientNewsScreen.view setBackgroundColor:[UIColor whiteColor]];
            [self.view addSubview:salientNewsScreen.view];
        }
        
        
    }
    else {
        if (sourceNews) {
            [sourceNews.view removeFromSuperview];
            [sourceNews release];
        }
        UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
        NSLog(@"id catelogy: %d",cell.tag );
        sourceNews=[[SourceNewsController alloc] init];
        sourceNews._categoryID=cell.tag;
        sourceNews.delegate=self;
        [sourceNews.view setFrame:CGRectMake(131, 80, 345, self.view.frame.size.height-80)];
        [sourceNews.menuTable setFrame:CGRectMake(0, 290, 345, 830-weight)];
        [sourceNews.view setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:sourceNews.view];
    }
    
}
#pragma mark - searchbar delegate
- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller{
    [controller.searchBar setTintColor:nil];
    
    // Hide our custom border
    [[controller.searchBar viewWithTag:SEARCHBAR_BORDER_TAG] setHidden:YES];
}

- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller{
    [controller.searchBar setTintColor:[UIColor colorWithRed:238.0f/255.0f green:245.0f/255.0f blue:248.0f/255.0f alpha:1.0f]];
    //Show our custom border again
    [[controller.searchBar viewWithTag:SEARCHBAR_BORDER_TAG] setHidden:NO];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchInformation resignFirstResponder];
    NSLog(@"search bar Search: %@",searchInformation.text);
    if (searchSite) {
        [searchSite startSearchSite:searchInformation.text];
        [self.view bringSubviewToFront:searchSite.view];
    }else{
        searchSite=[[SearchSiteViewController alloc] initWithNibName:@"SearchSiteViewController" bundle:nil];
        [searchSite.view setFrame:CGRectMake(131, 80, 345, self.view.frame.size.height-80)];
        [searchSite.menuTable setFrame:CGRectMake(0, 10, 345, 830-weight)];
        [searchSite.view setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:searchSite.view];
        [searchSite startSearchSite:searchInformation.text];
    }
}
#pragma mark--- Json
- (void)fetchedData{
    //parse out the json data
    NSMutableArray *contents = [[NSMutableArray alloc] init];
    [contents addObject:[NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"EZ_categories.png"], kCellImage, NSLocalizedString(@"Ezine",@""), kCellText,NSLocalizedString(@"0",@""), KCellTag, nil]];
    [contents addObject:[NSDictionary dictionaryWithObjectsAndKeys:[UIImage invertImageNamed:@"Account_Catogories"], kCellImage, NSLocalizedString(@"Tài Khoản",@""), kCellText,NSLocalizedString(@"1",@""), KCellTag, nil]];
    [contents addObject:[NSDictionary dictionaryWithObjectsAndKeys:[UIImage invertImageNamed:@"NewsFloating_catogories"], kCellImage, NSLocalizedString(@"Tin Nổi Bật",@""), kCellText,NSLocalizedString(@"2",@""), KCellTag, nil]];
    for (int i=0; i<CategoriesInform.count; i++) {
        NSDictionary *dataCateloges=[CategoriesInform objectAtIndex:i];
        NSString *name=[dataCateloges objectForKey:@"Name"];
        NSString *categoryID=[dataCateloges objectForKey:@"CategoryID"];
        [contents addObject:[NSDictionary dictionaryWithObjectsAndKeys: NSLocalizedString(name,@""), kCellText,NSLocalizedString(categoryID,@""), KCellTag, nil]];
        
    }
    
    self.cellContents = contents;
    
    // add table menu
	self.menuTables = [[UITableView alloc] initWithFrame:CGRectMake(0, 70, kMenuWidth, self.view.height-100) style:UITableViewStylePlain];
    self.menuTables.backgroundColor = [UIColor clearColor];
    self.menuTables.delegate = self;
    self.menuTables.dataSource = self;
    [self.view addSubview:self.menuTables];
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
    v.backgroundColor = [UIColor clearColor];
    [self.menuTables setTableHeaderView:v];
    [self.menuTables setTableFooterView:v];
    [v release];
    [self.menuTables reloadData];
    [self hideActivityIndicator];
    
}
#pragma mark-- sourceNew delegate
-(void)didSelectSite{
    NSLog(@"dismiss Categories");
    if (self.delegate) {
        [self.delegate dismissCategories];
    }
}
#pragma mark--- sarientNEw delegate
-(void)didSelectSiteInSalentNews{
    if (self.delegate) {
        [self.delegate dismissCategories];
    }
}
@end
