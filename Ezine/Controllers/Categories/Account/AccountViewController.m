//
//  AccountViewController.m
//  Ezine
//
//  Created by MAC on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AccountViewController.h"
#import "PSStackedView.h"
#import "UIImage+OverlayColor.h"
#import "MenuTableViewCell.h"
#import "SourceCell.h"
#import "CategoriesController.h"
#import "FacebookListAccountViewController.h"

#import <QuartzCore/QuartzCore.h>
#import "SectionHeaderView.h"

#define kMenuWidth 345
#define kCellText @"CellText"
#define kCellImage @"CellImage" 
#define k_tag_ezineAccount  100

@interface AccountViewController ()
@property (nonatomic, strong) NSArray *cellContents;
-(void)AccountEzineDetail;
@end

@implementation AccountViewController
@synthesize menuTable = menuTable_;
@synthesize cellContents = cellContents_;
@synthesize imgMan,delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)checkUserEzineLogin{
    NSString *name=[[NSUserDefaults standardUserDefaults] objectForKey:@"EzineAccountName"];
    if ([name length]>1) {
        isloginEzine=YES;
    }else{
        isloginEzine=NO;
    }
}
-(void)checkFBlogin{
    NSMutableArray *contents = [[NSMutableArray alloc] init];
    
    NSString *accesstoken=[[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    if (accesstoken==nil||[accesstoken length]<2) {
        NSLog(@"not login");
        [contents addObject:[NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"FaceBook_48x48.png"], kCellImage, NSLocalizedString(@"Facebook",@""), kCellText, nil]];
        islogin=NO;
    }else {
        NSLog(@"login");
        islogin=YES;        
    }
    
//    [contents addObject:[NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"twitterLogo.png"], kCellImage, NSLocalizedString(@"Twitter",@""), kCellText, nil]];
//    [contents addObject:[NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"googleReaderLogo.png"], kCellImage, NSLocalizedString(@"Google Reader",@""), kCellText, nil]];
//    [contents addObject:[NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"linkedlnLogo.png"], kCellImage, NSLocalizedString(@"Linkedln",@""), kCellText, nil]];
//    [contents addObject:[NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"instargramLogo.png"], kCellImage, NSLocalizedString(@"Instagram",@""), kCellText, nil]];
//    [contents addObject:[NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"flickrLogo.png"], kCellImage, NSLocalizedString(@"Flickr",@""), kCellText, nil]];
    
    self.cellContents = contents;
    
    // add table menu
	UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 80, kMenuWidth, self.view.height-80) style:UITableViewStylePlain];
    self.menuTable = tableView;
    
    self.menuTable.backgroundColor = [UIColor whiteColor];
    self.menuTable.delegate = self;
    self.menuTable.dataSource = self;
    self.menuTable.showsVerticalScrollIndicator=NO;
    [self.view addSubview:self.menuTable];
    [self.menuTable reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
 	
   // [UIApplication sharedApplication].statusBarOrientation ;
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged) name:UIDeviceOrientationDidChangeNotification object:nil];

#if 0
    self.view.layer.borderColor = [UIColor greenColor].CGColor;
    self.view.layer.borderWidth = 2.f;
#endif
      // add example background
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    
    // prepare menu content
    self.imgMan = [[[HJObjManager alloc] init] autorelease];
	NSString* cacheDirectory = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/imgcache/imgtable/"] ;
	HJMOFileCache* fileCache = [[[HJMOFileCache alloc] initWithRootPath:cacheDirectory] retain];
	self.imgMan.fileCache = fileCache;
    [self checkUserEzineLogin];
    [self checkFBlogin];
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


-(void)orientationChanged{
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *sectionHeader = nil;
    if (section==0) {
        sectionHeader= @"Tài Khoản Ezine";
    }else if(section==1){
        sectionHeader= @"Các Tài Khoản Của Bạn";
    }else if(section==2) {
        sectionHeader= @"Thêm Tài Khoản";
    }
    return sectionHeader;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 1;
    } else if (section==1){
        return 1;
    }else {
        return [cellContents_ count];
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    SectionHeaderView *headerView = [[[SectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)] autorelease];

    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(10, 3, tableView.bounds.size.width - 10, 18)] autorelease];
    if (section==0) {
        label.text = @"Tài Khoản Ezine";
    }else if (section==1){
        label.text = @"Các Tài Khoản Của Bạn";

    }else {
        label.text = @"Thêm Tài Khoản";

    }
    label.textColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    label.backgroundColor = [UIColor clearColor];
    [headerView addSubview:label];
    static NSMutableArray *colors = nil;
    if (colors == nil) {
        colors = [[NSMutableArray alloc] initWithCapacity:3];
        UIColor *color = nil;
        color = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
        [colors addObject:(id)[color CGColor]];
        color = [UIColor colorWithRed:236.0/255.0 green:236.0/255.0 blue:236.0/255.0 alpha:1.0];
        [colors addObject:(id)[color CGColor]];
        color = [UIColor colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:1.0];
        [colors addObject:(id)[color CGColor]];
    }
    [(CAGradientLayer *)headerView.layer setColors:colors];
    [(CAGradientLayer *)headerView.layer setLocations:[NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0], [NSNumber numberWithFloat:0.48], [NSNumber numberWithFloat:1.0], nil]];

    return headerView;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section]==1&&islogin) {
        static NSString *CellIdentifier = @"ExampleMenuCell";
        
        SourceCell *cell = (SourceCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *topLevelObject=[[NSBundle mainBundle] loadNibNamed:@"SourceCell" owner:self options:nil];
            for (id currentObject in topLevelObject) {
                
                if ([currentObject isKindOfClass:[UITableViewCell class]]) {
                    
                    cell=(SourceCell*)currentObject;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.NameSources.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
//                    cell.NameSources.shadowOffset = CGSizeMake(0, 2);
//                    cell.NameSources.shadowColor = [UIColor colorWithWhite:0 alpha:0.25];
                    cell.NameSources.contentMode=UIViewContentModeLeft;
                    
                    cell.logoImage.contentMode = UIViewContentModeCenter;
                    
                    break;
                }
            }  
            
            //
        }
        
        
        NSString    *urlImage=[[NSUserDefaults standardUserDefaults]objectForKey:@"urlProfile"];
        NSString    *name=[[NSUserDefaults standardUserDefaults]objectForKey:@"nameProfile"];

        cell.NameSources.text=@"Facebook";
        cell.detailSource.text=name;
        HJManagedImageV *ImagePark2=[[HJManagedImageV alloc]initWithFrame:CGRectMake(15, 10, 40, 40)];
        ImagePark2.imageView.contentMode=UIViewContentModeScaleToFill;
        NSURL *url = [NSURL URLWithString:urlImage];
        ImagePark2.url = url;
        ImagePark2.oid =nil;
        [self.imgMan manage:ImagePark2];
        [cell addSubview:ImagePark2];
        [cell.btnAddSource setImage:[UIImage imageNamed:@"btn_detailAccount.png"] forState:UIControlStateNormal];
        [cell.btnAddSource addTarget:self action:@selector(btnDetail:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnAddSource setTag:indexPath.row];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        [(UIButton *)cell.accessoryView addTarget:self action:@selector(btnDetail:) forControlEvents:UIControlEventTouchUpInside];
        [(UIButton *)cell.accessoryView setTag:indexPath.row];
        [cell.btnAddSource setHidden:YES];
        //if (indexPath.row == 5)
        //    cell.enabled = NO;
        
        return cell;

    }else if ([indexPath section]==1&&!islogin){
        static NSString *CellIdentifier = @"ExampleMenuCell";
        
        MenuTableViewCell *cell = (MenuTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[MenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.textLabel.text = [[cellContents_ objectAtIndex:indexPath.row] objectForKey:kCellText];
        cell.imageView.image = [[cellContents_ objectAtIndex:indexPath.row] objectForKey:kCellImage];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

        //if (indexPath.row == 5)
        //    cell.enabled = NO;
        
        return cell;
    }else {
        if (!isloginEzine) {
            static NSString *CellIdentifier = @"ExampleMenuCell";
            
            SourceCell *cell = (SourceCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            cell=nil;

            if (cell == nil) {
                NSArray *topLevelObject=[[NSBundle mainBundle] loadNibNamed:@"SourceCell" owner:self options:nil];
                for (id currentObject in topLevelObject) {
                    
                    if ([currentObject isKindOfClass:[UITableViewCell class]]) {
                        
                        cell=(SourceCell*)currentObject;
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        cell.NameSources.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
                        //                    cell.NameSources.shadowOffset = CGSizeMake(0, 2);
                        //                    cell.NameSources.shadowColor = [UIColor colorWithWhite:0 alpha:0.25];
                        cell.NameSources.contentMode=UIViewContentModeLeft;
                        
                        cell.logoImage.contentMode = UIViewContentModeCenter;
                        
                        break;
                    }
                }
                
                //
            }
            
            
            cell.NameSources.text=@"Tài Khoản Ezine";
            cell.detailSource.text=@"Click để tạo tài khoản hoặc đăng nhập";
            cell.logoImage.image = [UIImage imageNamed:@"EzineLogo.png"];
            [cell.btnAddSource setImage:[UIImage imageNamed:@"btn_detailAccount.png"] forState:UIControlStateNormal];
            [cell.btnAddSource addTarget:self action:@selector(btnDetail:) forControlEvents:UIControlEventTouchUpInside];
            [cell.btnAddSource setTag:k_tag_ezineAccount];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            [(UIButton *)cell.accessoryView addTarget:self action:@selector(btnDetail:) forControlEvents:UIControlEventTouchUpInside];
            [(UIButton *)cell.accessoryView setTag:k_tag_ezineAccount];
            [cell.btnAddSource setHidden:YES];
            //if (indexPath.row == 5)
            //    cell.enabled = NO;
            
            return cell;

        }else{
            static NSString *CellIdentifier = @"ExampleMenuCell";
            
            SourceCell *cell = (SourceCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            cell=nil;
            if (cell == nil) {
                NSArray *topLevelObject=[[NSBundle mainBundle] loadNibNamed:@"SourceCell" owner:self options:nil];
                for (id currentObject in topLevelObject) {
                    
                    if ([currentObject isKindOfClass:[UITableViewCell class]]) {
                        
                        cell=(SourceCell*)currentObject;
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        cell.NameSources.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
                        //                    cell.NameSources.shadowOffset = CGSizeMake(0, 2);
                        //                    cell.NameSources.shadowColor = [UIColor colorWithWhite:0 alpha:0.25];
                        cell.NameSources.contentMode=UIViewContentModeLeft;
                        
                        cell.logoImage.contentMode = UIViewContentModeCenter;
                        
                        break;
                    }
                }
                
                //
            }
            
            
            NSString    *urlImage=[[NSUserDefaults standardUserDefaults]objectForKey:@"EzineAccountAvatar"];
            NSString    *name=[[NSUserDefaults standardUserDefaults]objectForKey:@"EzineAccountName"];
            
            cell.NameSources.text=@"Ezine";
            cell.detailSource.text=name;
            HJManagedImageV *ImagePark2=[[HJManagedImageV alloc]initWithFrame:CGRectMake(15, 10, 40, 40)];
            ImagePark2.imageView.contentMode=UIViewContentModeScaleToFill;
            NSURL *url = [NSURL URLWithString:urlImage];
            ImagePark2.url = url;
            ImagePark2.oid =nil;
            [self.imgMan manage:ImagePark2];
            [cell addSubview:ImagePark2];
            [cell.btnAddSource setImage:[UIImage imageNamed:@"btn_detailAccount.png"] forState:UIControlStateNormal];
            [cell.btnAddSource addTarget:self action:@selector(btnDetail:) forControlEvents:UIControlEventTouchUpInside];
            [cell.btnAddSource setTag:indexPath.row];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            [(UIButton *)cell.accessoryView addTarget:self action:@selector(btnDetail:) forControlEvents:UIControlEventTouchUpInside];
            [(UIButton *)cell.accessoryView setTag:indexPath.row];
            [cell.btnAddSource setHidden:YES];

            //if (indexPath.row == 5)
            //    cell.enabled = NO;
            
            return cell;
            

        }
      
    }
   }
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {  
    // PSStackedViewController *stackController = XAppDelegate.stackController;
    if ([indexPath section]==0) {
        [self AccountEzineDetail];
    }else if ([indexPath section]==1){
//        FBFeedPost *post = [[FBFeedPost alloc] init];
//        post.postType=kAPIGraphUserPermissions;
//        [post publishPostWithDelegate:self];
         NSLog(@"AAAAABBBBBB");
        for (UIView* next = [self.view superview]; next; next = next.superview)
        {
            UIResponder* nextResponder = [next nextResponder];
            
            if ([nextResponder isKindOfClass:[CategoriesController class]])
            {
                CategoriesController *categories= (CategoriesController*)nextResponder;
                [categories didSelectSite];
            }
        }
        FacebookListViewController   *fbListScreen=[[FacebookListViewController alloc]initWithNibName:@"FacebookListViewController" bundle:nil];
        [fbListScreen.view setFrame:CGRectMake(0, 0, 768, 1004)];
        [XAppDelegate.navigationController pushViewController:fbListScreen animated:YES];
        [fbListScreen release];
       //        CGRect menuFrame = fbListScreen.view.frame;
//        menuFrame.origin.x = 0;
//        [UIView animateWithDuration:0.4
//                              delay:0.0
//                            options: UIViewAnimationOptionTransitionNone
//                         animations:^{
//                             fbListScreen.view.frame = menuFrame;
//                         } 
//                         completion:^(BOOL finished){
//                             NSLog(@"Done!");
//                         }];

    }else if ([indexPath section]==2) {
         NSLog(@"AAAAABBBBBB222222");
        if (!islogin) {
            if (indexPath.row==0) {
                FacebookListAccountViewController   *fbListScreen=[[FacebookListAccountViewController alloc]initWithNibName:@"FacebookListAccountViewController" bundle:nil];
                [fbListScreen.view setFrame:CGRectMake(768, 0, 768, 1024)];
                [self.view.superview.superview addSubview:fbListScreen.view];
                CGRect menuFrame = fbListScreen.view.frame;
                menuFrame.origin.x = 0;
                [UIView animateWithDuration:0.4
                                      delay:0.0
                                    options: UIViewAnimationOptionTransitionNone
                                 animations:^{
                                     fbListScreen.view.frame = menuFrame;
                                 } 
                                 completion:^(BOOL finished){
                                     NSLog(@"Done!");
                                 }];

            }
        }
    }
    
}

#pragma ----mark--- button handle
-(void)AccountEzineDetail{
    if (isloginEzine) {
        AccountDetailController *accountdetai=[[AccountDetailController alloc] initWithNibName:@"AccountDetailController" bundle:nil];
        accountdetai.delegate=self;
        if([UIApplication sharedApplication].statusBarOrientation==UIInterfaceOrientationLandscapeLeft||[UIApplication sharedApplication].statusBarOrientation==UIInterfaceOrientationLandscapeRight) {
            
            NSLog(@"Landscape");
            [accountdetai.view setFrame:CGRectMake(1024, 20, 550, 1004)];
            [self.view.superview addSubview:accountdetai.view];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            [accountdetai.view setFrame:CGRectMake(0, 20, 550, 768)];
            [UIView commitAnimations];
            
        }else {
            
            NSLog(@"portrait");
            [accountdetai.view setFrame:CGRectMake(768, 20, 550, 1004)];
            [self.view.superview addSubview:accountdetai.view];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            [accountdetai.view setFrame:CGRectMake(0, 20, 550, 1004)];
            [UIView commitAnimations];
            
        }

    }else{
        if (ezineAccount) {
            [ezineAccount release];
        }
        ezineAccount=[[EzineAccountViewController alloc] initWithNibName:@"EzineAccountViewController" bundle:nil];
        ezineAccount.delegate=self;
        if([UIApplication sharedApplication].statusBarOrientation==UIInterfaceOrientationLandscapeLeft||[UIApplication sharedApplication].statusBarOrientation==UIInterfaceOrientationLandscapeRight) {
            
            NSLog(@"Landscape");
            [ezineAccount.view setFrame:CGRectMake(1024, 20, 550, 1004)];
            [self.view.superview addSubview:ezineAccount.view];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            [ezineAccount.view setFrame:CGRectMake(0, 20, 550, 768)];
            [UIView commitAnimations];
            
        }else {
            
            NSLog(@"portrait");
            [ezineAccount.view setFrame:CGRectMake(768, 20, 550, 1004)];
            [self.view.superview addSubview:ezineAccount.view];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            [ezineAccount.view setFrame:CGRectMake(0, 20, 550, 1004)];
            [UIView commitAnimations];
            
        }
        

    }
  
}
-(void)btnDetail:(id)sender{
    if ([sender tag]==k_tag_ezineAccount) 
        [self AccountEzineDetail];
}
#pragma mark-- fb delegate
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
	NSLog(@"ResponseFailed: %@", error);
	
}

- (void)request:(FBRequest *)request didLoad:(id)result {
    if ([result isKindOfClass:[NSArray class]]) {
        result = [result objectAtIndex:0];
    }
	NSLog(@"Parsed Response FBRequest 1: %@", result);
    NSString *urlImage=nil;
    urlImage=[[NSString alloc] initWithFormat:@"%@",[result objectForKey:@"pic"]];
    NSString    *name=[result objectForKey:@"name"];
    [[NSUserDefaults standardUserDefaults] setObject:urlImage forKey:@"urlProfile"];
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"nameProfile"];
    XAppDelegate._isgotoListArticle=YES;
    FacebookListViewController *vc=[[FacebookListViewController alloc] initWithNibName:@"FacebookListViewController" bundle:nil];
//    [vc.view setFrame:self.view.frame];
//    [vc setSiteId:item.siteID];
//    [vc loaddataFromSite];
    
    //EzineAppDelegate *appDelegate=(EzineAppDelegate*)[[UIApplication sharedApplication] delegate];
    [self presentPopupViewController:vc animationType:MJPopupViewAnimationSlideRightLeft];
    
    [vc release];
    
}
#pragma mark---logout
-(void)logout{
    NSLog(@"log out Ezine");
    isloginEzine=NO;
    [self.menuTable reloadData];
}

#pragma mark---
-(void)LoginSuccess{
    isloginEzine=YES;
    [self.menuTable reloadData];
    [self AccountEzineDetail];
}

//-(void)cancelFacebook{
//    NSLog(@"Cacel");
//    [self.navigationController popViewControllerAnimated:YES];
//    
//}

@end
