//
//  MyLauncherItem.h
//  Ezine
//
//  Created by PDG2 on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "SourceModel.h"
#import "MKNetworkKit.h"

@protocol MyLauncherItemDelegate <NSObject>
-(void)didDeleteItem:(id)item;
-(void)didInforClick:(id)item;
@end

@interface MyLauncherItem : UIControl
{
    id <MyLauncherItemDelegate> delegate;
	Class targetController;
    int       siteID;
	NSString *title;
	NSString *image;
	NSString *controllerStr;
	
	BOOL dragging;
	BOOL deletable;
    BOOL inforable;
    BOOL isAddButton;
    
	UIButton *closeButton;
    UIButton *inforButton;
    
    UIActivityIndicatorView* _spinner;
    MKNetworkEngine *networkEngine;
    UILabel         *_titleSiteTop1;
    UILabel         *_titleSiteTop2;
    UILabel         *_titleSiteTop3;
    BOOL            _isSiteTop;
    NSInteger       _ArticleIdLatest;

}
@property (nonatomic, assign) BOOL isAddButton;
@property (nonatomic, assign) id delegate;
@property (nonatomic,retain) Class targetController;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *image;
@property (nonatomic, retain) NSString *controllerStr;
@property (nonatomic, retain) UIButton *closeButton;
@property                     int       siteID;
@property (nonatomic, strong) MKNetworkOperation* imageLoadingOperation;
@property (nonatomic, strong) UIImageView *logoSite;
@property (nonatomic, strong) UILabel *itemLabel;
@property (nonatomic, strong) UILabel *_titleSiteTop1;
@property (nonatomic, strong) UILabel *_titleSiteTop2;
@property (nonatomic, strong) UILabel *_titleSiteTop3;
@property(nonatomic,assign)     BOOL   _isSiteTop;


@property (nonatomic, strong) SourceModel *_sourcemoder;

-(id)initWithTitle:(NSString *)_title image:(NSString *)_image target:(NSString *)_targetControllerStr deletable:(BOOL)_deletable;
-(id)initWithSourceModel:(SourceModel*)model;
-(void)layoutItem;
-(void)setDragging:(BOOL)flag;
-(BOOL)dragging;
-(BOOL)deletable;
-(void)resetFrameItem;
-(void)reloadViewData:(SourceModel *)model;
 
- (void)showActivityIndicator;
- (void)hideActivityIndicator;
-(void) reloadFontSize;
-(void)updateLatest;
-(void)reloadImage;
-(void)checkReload;


@end
