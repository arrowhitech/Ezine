//
//  MyLauncherHeader.h
//  Ezine
//
//  Created by PDG2 on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKNetworkKit.h"

@protocol MyLauncherHeaderDelegate<NSObject>
@optional
- (void) plusButtonClick;
@end

@interface MyLauncherHeader : UIView{
	UIInterfaceOrientation currrentInterfaceOrientation;
	NSString    *wallTitleText;
    UIButton    *plusButton;
    UILabel     *_nameUser;
    UIImageView *_avatarUser;
}
@property (assign, nonatomic) id <MyLauncherHeaderDelegate>delegate;
@property (nonatomic,readonly) UIInterfaceOrientation currrentInterfaceOrientation;
@property (nonatomic,retain) NSString* wallTitleText;
@property (nonatomic, strong) MKNetworkOperation* imageLoadingOperation;
@property (nonatomic, strong)    UIImageView *_avatarUser;

-(void)rotate:(UIInterfaceOrientation)interfaceOrientation animation:(BOOL)animation;
-(void)plusClick:(id)sender;
@end
