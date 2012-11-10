//
//  MyLauncherFooter.m
//  Ezine
//
//  Created by PDG2 on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyLauncherFooter.h"
#import <MessageUI/MessageUI.h>
#import "MyLauncherView.h"

#import "UIViewController+MJPopupViewController.h"
#import "SettingsViewController.h"

@interface MyLauncherFooter ()

@end

@implementation MyLauncherFooter
@synthesize currrentInterfaceOrientation,wallTitleText;
@synthesize delegate;

-(void)rotate:(UIInterfaceOrientation)interfaceOrientation animation:(BOOL)animation{
	currrentInterfaceOrientation = interfaceOrientation;
}

-(void) setWallTitleText:(NSString *)wallTitle {
	wallTitleText = wallTitle;
    CGRect viewRect=self.frame;
    
    //Page lable
	pageLable=[[UILabel alloc] initWithFrame:CGRectMake(15,15,200,30)];
    [pageLable setFont:[UIFont fontWithName:@"Arial-BoldMT" size:14+XAppDelegate.appFontSize]];
    [pageLable setTextColor:COLOR(153, 153, 153)];
    [pageLable setText:@""];
    [self addSubview:pageLable];
    
    
    // button controll
    bookmarkBtn = [[UIButton alloc] init];
    UIImage *bookmarkIcon=[UIImage imageNamed:@"btn_bookmark_masterPage_n"];
    [bookmarkBtn setSelected:YES];
	[bookmarkBtn setImage:bookmarkIcon forState:UIControlStateSelected];
    bookmarkBtn.backgroundColor = [UIColor clearColor];
    bookmarkBtn.showsTouchWhenHighlighted=YES;
	[bookmarkBtn setFrame:CGRectMake(viewRect.size.width-40,(50-25)/2,25,25)];
    [bookmarkBtn addTarget:self action:@selector(bookmarkTouched) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:bookmarkBtn];
    
    settingBtn = [[UIButton alloc] init];
    UIImage *settingIcon=[UIImage imageNamed:@"btn_setting_masterPage_n"];
    [settingBtn setSelected:YES];
	[settingBtn setImage:settingIcon forState:UIControlStateSelected];
    settingBtn.backgroundColor = [UIColor clearColor];
    settingBtn.showsTouchWhenHighlighted=YES;
	[settingBtn setFrame:CGRectMake(bookmarkBtn.frame.origin.x-50,(50-25)/2,25,25)];
    
    [settingBtn addTarget:self action:@selector(settingTouched) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:settingBtn];
    
    
    downloadBtn = [[UIButton alloc] init];
    UIImage *downloadIcon=[UIImage imageNamed:@"btn_download_masterPage_n"];
    [downloadBtn setSelected:YES];
	[downloadBtn setImage:downloadIcon forState:UIControlStateSelected];
    downloadBtn.backgroundColor = [UIColor clearColor];
    downloadBtn.showsTouchWhenHighlighted=YES;
	[downloadBtn setFrame:CGRectMake(settingBtn.frame.origin.x-50,(50-25)/2,25,25)];
    [downloadBtn addTarget:self action:@selector(downloadTouched) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:downloadBtn];
    
    
    reloadBtn = [[UIButton alloc] init];
    UIImage *reloadIcon=[UIImage imageNamed:@"btn_reload_masterPage_n"];
    [reloadBtn setSelected:YES];
	[reloadBtn setImage:reloadIcon forState:UIControlStateSelected];
    reloadBtn.backgroundColor = [UIColor clearColor];
    reloadBtn.showsTouchWhenHighlighted=YES;
	[reloadBtn setFrame:CGRectMake(downloadBtn.frame.origin.x-50,(50-25)/2,25,25)];
    [reloadBtn addTarget:self action:@selector(reloadTouched) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:reloadBtn];
    
    //search site button
    searchSite = [[UIButton alloc] init];
    UIImage *searchSiteImage=[UIImage imageNamed:@"btn_searchSite@2x.png"];
    [searchSite setSelected:YES];
	[searchSite setImage:searchSiteImage forState:UIControlStateSelected];
    searchSite.backgroundColor = [UIColor clearColor];
    searchSite.showsTouchWhenHighlighted=YES;
	[searchSite setFrame:CGRectMake(reloadBtn.frame.origin.x-50,(50-25)/2,25,25)];
    [searchSite addTarget:self action:@selector(searchSiteClick:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:searchSite];

    [[UIDevice currentDevice] orientation];
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged) name:UIDeviceOrientationDidChangeNotification object:nil];
    
}

#pragma mark--- rotate
-(void)orientationChanged{
    NSLog(@"orientationChange footer");
    if ([UIApplication sharedApplication].statusBarOrientation==UIInterfaceOrientationLandscapeLeft||[UIApplication sharedApplication].statusBarOrientation==UIInterfaceOrientationLandscapeRight) {
        CGRect frame= self.frame;
        frame.size.width=1024;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDelay:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        
        self.frame=frame;
        [bookmarkBtn setFrame:CGRectMake(1024-40,(50-25)/2,25,25)];

        [settingBtn setFrame:CGRectMake(bookmarkBtn.frame.origin.x-50,(50-25)/2,25,25)];
        [downloadBtn setFrame:CGRectMake(settingBtn.frame.origin.x-50,(50-25)/2,25,25)];
        [reloadBtn setFrame:CGRectMake(downloadBtn.frame.origin.x-50,(50-25)/2,25,25)];
        [searchSite setFrame:CGRectMake(reloadBtn.frame.origin.x-50,(50-25)/2,25,25)];

        [UIView commitAnimations];
    }else if ([UIApplication sharedApplication].statusBarOrientation==UIInterfaceOrientationPortrait||[UIApplication sharedApplication].statusBarOrientation==UIInterfaceOrientationPortraitUpsideDown){
        CGRect frame= self.frame;
        frame.size.width=768;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDelay:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        
        self.frame=frame;
        [bookmarkBtn setFrame:CGRectMake(768-40,(50-25)/2,25,25)];
        [settingBtn setFrame:CGRectMake(bookmarkBtn.frame.origin.x-50,(50-25)/2,25,25)];
        [downloadBtn setFrame:CGRectMake(settingBtn.frame.origin.x-50,(50-25)/2,25,25)];
        [reloadBtn setFrame:CGRectMake(downloadBtn.frame.origin.x-50,(50-25)/2,25,25)];
        [searchSite setFrame:CGRectMake(reloadBtn.frame.origin.x-50,(50-25)/2,25,25)];

        [UIView commitAnimations];
    }
    
    
    
}
#pragma mark----
-(void)setPageNumber:(NSInteger)pageNumber andTotalPage:(NSInteger)totalPage{
    [pageLable setText:[NSString stringWithFormat:@"Trang %d của %d",pageNumber,totalPage]];
    NSLog(@"page : %@",pageLable.text);
}


-(void)bookmarkTouched{
    NSLog(@"bookmark click");
    if (self.delegate){
        [self.delegate bookmarkClick];
    }
}

-(void)settingTouched{
    if (self.delegate) {
        [self.delegate settingClick];
    }
}


-(void)downloadTouched{
    
    if (self.delegate){
        [self.delegate downloadClick];
    }
}

-(void)reloadTouched{
    NSLog(@"reload clicked");
//    if (self.delegate){
//        [self.delegate reloadClick];
//    }
    [[NSNotificationCenter defaultCenter] postNotificationName:KDidReloadSiteNotification object:self userInfo:nil];

}

-(void)searchSiteClick:(id)sender{
    NSLog(@"search Site click");
    if (self.delegate){
        [self.delegate searchSiteClick:sender];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft||toInterfaceOrientation==UIInterfaceOrientationLandscapeRight||toInterfaceOrientation==UIInterfaceOrientationPortrait||toInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown);
}

-(void) dealloc {
	[wallTitleText release];
    [pageLable release];
	[super dealloc];
}
@end
