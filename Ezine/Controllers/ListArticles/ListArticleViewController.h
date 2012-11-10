//
//  ListNewsViewController.h
//  Ezine
//
//  Created by Admin on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ArticleModel.h"
#import "FullScreenView.h"
#import "UIViewExtention.h"
#import "HeaderView.h"
#import "ListCategoriesOfSource.h"
#import "MKNetworkKit.h"
#import "MPFlipViewController.h"
#import "LayoutViewExtention.h"
#import "FooterView.h"
#import "SearchKeyWordViewController.h"
#import "Reachability.h"

@class CTView;
@class LastestOfSource;
@interface ListArticleViewController : UIViewController<HeaderViewDelegate,CategorySelectionDelegate,UIPopoverControllerDelegate,MPFlipViewControllerDelegate, MPFlipViewControllerDataSource,LayoutViewExtentionDelegate,FullScreenViewDelegate,MFMailComposeViewControllerDelegate,FooterViewDelegate,SearchKeyWordViewControllerDelegate>{
    
	
    NSMutableArray              *arrayData;
    NSMutableArray              *arrayPage;
    
	UIViewExtention*            viewToShowInFullScreen;
	FullScreenView*             fullScreenView;
    ListCategoriesOfSource *    listCatelogiesController;
    LastestOfSource *           lastestOfSourceController;
	UIView*                     fullScreenBGView;
    UIPopoverController *       popovercontroller;
    
    NSInteger                   activeIndex;
    BOOL                        isInFullScreenMode;
    NSString*                   wallTitle;
    BOOL                        _isUpdateArticle;
    NSString                   *_LastArticleTime;
    NSString                   *timeArticle;
    int                         _numberPage;
    // check if go to detail screen not show screen update list article
    BOOL                        _isgotoDetailArticle;
    // check if list article is search buy keyword all site
    BOOL                        _isSearchAllSite;
    BOOL                        _isSearchInSite;
    BOOL                        _isGetArticleInchanel;

    NSString                    *numberArticle;
    
    //Hieu Extra code ============
    NSString* siteNameforArticle;
    NSString* urlLOGoforArticle;
    //=========================
    UIImageView* imgFakeGifAnimation;
    
}

@property (nonatomic, retain) NSMutableArray *cachedDataAllArticle;
@property (nonatomic,assign) NSInteger siteId;
@property (nonatomic,assign) NSInteger chanelId;

@property (nonatomic, strong) MKNetworkOperation* imageLoadingOperation;
@property (nonatomic, assign) UIGestureRecognizer* gestureRecognizer;
@property (nonatomic, retain) NSString* wallTitle;
@property (nonatomic,retain)  UIPopoverController *popovercontroller;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) MPFlipViewController *flipViewController;
@property (assign, nonatomic) BOOL observerAdded;
////Extra code
@property(nonatomic,retain)   NSString* siteNameforArticle;
@property(nonatomic,retain)   NSString* urlLOGoforArticle;



- (NSMutableArray*) arrayArticleFromDic:(NSDictionary*)dic;
- (void) fetchedData:(NSMutableArray *)data;
- (void) buildPages:(NSMutableArray*) itemsArray;
- (void) showViewInFullScreen:(UIView*)viewToShow withModel:(ArticleModel*)model;
- (void) closeFullScreen;
- (void) loaddataFromSite;
- (void) loaddataFromSearchKeyWord:(NSString*)keyWord;
- (void) showActivityIndicator;
- (void) hideActivityIndicator;
- (void) updateListArticle;

- (void) loadDataFromSearchInSite:(NSString *)keyword;
- (void) loadDataFromChanel:(int)chanel;
-(void)shareEmailPlease;

//Hieu exatra code ===================
 -(BOOL)connected;

@end
