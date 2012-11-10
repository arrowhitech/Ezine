//
//  MyLauncherFooter.h
//  Ezine
//
//  Created by PDG2 on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFKPageFlipper.h"

@protocol MyLauncherFooterDelegate<NSObject>
@optional
- (void) settingClick;
- (void) reloadClick;
- (void) bookmarkClick;
- (void) downloadClick;
-(void)searchSiteClick:(id)sender;

@end


@interface MyLauncherFooter : UIView{
    
	UIInterfaceOrientation currrentInterfaceOrientation;
	NSString* wallTitleText;
    UILabel     *pageLable;
    UIButton    *settingBtn;
    UIButton    *downloadBtn;
    UIButton    *bookmarkBtn;
    UIButton    *reloadBtn;
    UIButton    *searchSite;

    
}
@property (nonatomic,readonly) UIInterfaceOrientation currrentInterfaceOrientation;
@property (nonatomic,retain) NSString* wallTitleText;
@property (assign, nonatomic) id <MyLauncherFooterDelegate>delegate;

-(void)bookmarkTouched;
-(void)settingTouched;
-(void)downloadTouched;
-(void)reloadTouched;

-(void)rotate:(UIInterfaceOrientation)interfaceOrientation animation:(BOOL)animation;
-(void)setPageNumber:(NSInteger) pageNumber andTotalPage:(NSInteger)totalPage;



@end
