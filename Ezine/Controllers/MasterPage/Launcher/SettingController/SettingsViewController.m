//
//  SettingsViewController.m
//  Ezine
//
//  Created by Admin on 7/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"
#import "IASKSpecifier.h"
#import "IASKSettingsReader.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController
//@synthesize myView;
@synthesize appSettingController;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andFrame:(CGRect)frame 
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
                [self.view setFrame:frame];
        
    }
    return self;
}

- (void)viewDidLoad
{
        [super viewDidLoad];
        
}

- (void)viewDidUnload
{
    
   
    [super viewDidUnload];
    
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft||toInterfaceOrientation==UIInterfaceOrientationLandscapeRight||toInterfaceOrientation==UIInterfaceOrientationPortrait||toInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark============OK================

- (IASKAppSettingsViewController*)appSettingController {
    NSLog(@"appSettingsViewController function");
    if (!appSettingController) {
        appSettingController=[[IASKAppSettingsViewController alloc] init];
        appSettingController.delegate = self;
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:appSettingController];
        navController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        navController.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:navController animated:YES completion:nil];
        [appSettingController release];

    }
    return appSettingController;
    

}


- (CGFloat)tableView:(UITableView *)tableView {
    
    
    return tableView.frame.size.height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int row =0;
    
    switch (section) {
        case 0:
            row =2;
            break;
        case 1:
            row =6;
            break;
        case 2:
            row=1;
            break;
        default:
            break;
    }
    return row;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
            if (indexPath.row==0) {
                NSLog(@"Gioi thieu");
            }else {
                NSLog(@"Tro giup");
            }
            break;
            
        case 1:
            
            switch (indexPath.row) {
                case 0:
                    
                    NSLog(@"Danh dau de doc sau");
                    break;
                case 3:
                    
                    NSLog(@"Loai bo hien thi");
                    break;
                case 4:
                    
                    NSLog(@"THiet lap tai nguon tin");
                    break;
                case 5:
                    
                    NSLog(@"Noi dung huong dan");
                default:
                    break;
            }
            
            break;

        case 2:
            if (indexPath.row==0) {
                NSLog(@"Button clicked");
                UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Demo Action 1 called" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
                [alert show];
                
            }
            break;
                default:
            break;
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderForKey:(NSString*)key {
    return 44;
    
}

- (void) switchChanged:(id)sender {
    UISwitch* switchControl = sender;
    NSLog( @"The switch is %@", switchControl.on ? @"ON" : @"OFF" );
}

#pragma mark -
- (void)settingsViewController:(IASKAppSettingsViewController*)sender buttonTappedForSpecifier:(IASKSpecifier*)specifier {
    
	if ([specifier.key isEqualToString:@"btnFacebook"]) {
        NSLog(@"Button clicked");
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Demo Action 1 called" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
		[alert show];
        
	} 
}


- (void)settingsViewControllerDidEnd:(IASKAppSettingsViewController*)sender {
       
      [self dismissModalViewControllerAnimated:YES];
    
}

#pragma mark ============Ok-================

-(IBAction)btnFinishSetting:(id)sender{
    
    
}

@end
