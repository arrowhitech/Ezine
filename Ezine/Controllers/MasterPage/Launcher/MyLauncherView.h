//
//  MyLauncherView.h
//  Ezine
//
//  Created by PDG2 on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyLauncherItem.h"
#import "EzineAppDelegate.h"

#define KDidDeleteSiteNotification @"KDidDeleteSiteNotification"
#define KDidBeginEdittingSiteNotification @"KDidBeginEdittingSiteNotification"
#define KDidEndEdittingSiteNotification @"KDidEndEdittingSiteNotification"
#define KDidChangeOrderSiteNotification @"KDidChangeOrderSiteNotification"
#define KDidAddSiteNotification @"KDidAddSiteNotification"
#define KNeedNextPageNotification @"KNeedNextPageNotification"
#define KDidMoveCell @"KDidMoveCell"
#define KDidFifnishMovecell @"KDidFifnishMovecell"

// reload 
#define KDidReloadSiteNotification @"KDidReloadSiteNotification"

@protocol MyLauncherViewDelegate <NSObject>
-(void)launcherViewItemSelected:(MyLauncherItem*)item;
-(void)itemInforClick:(id) item;
@end

@interface MyLauncherView : UIView<MyLauncherItemDelegate,UIGestureRecognizerDelegate>{
    id <MyLauncherViewDelegate> delegate;
	
	NSMutableArray *pages;
	NSTimer *itemHoldTimer;
	NSTimer *movePagesTimer;
	
	BOOL itemsAdded;
	BOOL editing;
	BOOL dragging;
    BOOL canEnEditing;
	MyLauncherItem *draggingItem;
	
	int columnCount;
	int rowCount;
	CGFloat itemWidth;
	CGFloat itemHeight;
    
    int     _currentPage;
    int     _numberPage;
    BOOL isLastpage;
    EzineAppDelegate *_ezineDelegate;
    NSMutableArray   *arraydataSite;
    int              countSiteDelete;
    
    UILongPressGestureRecognizer *longPressGestureRecognizer;
    UIPanGestureRecognizer       *panGestureRecognizer;
    UITapGestureRecognizer       *tapGestureRecognizer;
}
@property   BOOL isLastpage;
@property   BOOL editing;
@property (nonatomic, assign) id delegate;
@property (nonatomic, copy) NSMutableArray *pages;
@property (nonatomic,retain)	MyLauncherItem *draggingItem;

@property                   int _currentPage;
@property                   int _numberPage;
@property                   BOOL dragging;
@property                   BOOL itemsAdded;


-(void)layoutLauncher;
-(void)beginEditing;
-(void)endEditing;
-(void) reloadFontSize;
-(void)reloadAllsite;
- (void)checkReloadAllsite;
@end