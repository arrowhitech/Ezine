//
//  SettingForDownloadViewController.m
//  Ezine
//
//  Created by Admin on 7/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingForDownloadViewController.h"

#import "IASKSpecifier.h"
#import "IASKSettingsReader.h"

@interface SettingForDownloadViewController ()

@end

@implementation SettingForDownloadViewController
@synthesize naviBar;


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
    
    
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark============OK================


//- (CGFloat)tableView:(UITableView *)tableView {
//    
//    
//    
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int row =0;
    
    switch (section) {
        case 0:
            row =1;
            break;
        case 1:
            row =1;
            break;
        case 2:
            row=8;
            break;
        default:
            break;
    }
    return row;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderForKey:(NSString*)key {
//    return 44;
//    
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderForKey:(NSString*)key {
//    
//    
//}
//
//- (CGFloat)tableView:(UITableView*)tableView heightForSpecifier:(IASKSpecifier*)specifier {
//    
//    
//}
//
//- (UITableViewCell*)tableView:(UITableView*)tableView cellForSpecifier:(IASKSpecifier*)specifier {
//    
//}

#pragma mark -
- (void)settingsViewController:(IASKAppSettingsViewController*)sender buttonTappedForSpecifier:(IASKSpecifier*)specifier {
    
}


- (void)settingsViewControllerDidEnd:(IASKAppSettingsViewController*)sender {
    [self dismissModalViewControllerAnimated:YES];
    
}



@end
