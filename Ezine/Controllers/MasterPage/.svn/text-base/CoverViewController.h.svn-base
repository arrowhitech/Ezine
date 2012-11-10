//
//  CoverViewController.h
//  Ezine
//
//  Created by PDG2 on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "CategoriesController.h"
#import "MKNetworkKit.h"
#import "SiteObject.h"
#import "FBFeedPost.h"
#import "IFNNotificationDisplay.h"
#import "GooglePlusShare.h"

@protocol CoverViewControllerDelegate <NSObject>

-(void)FlipbuttonClick;

@end

@interface CoverViewController : UIViewController<UIActionSheetDelegate,FBFeedPostDelegate,FBSessionDelegate,FBRequestDelegate,GooglePlusShareDelegate,MFMailComposeViewControllerDelegate>

{

    IBOutlet UIImageView             *coverImageView;
    UIImageView                      *ezineLogo;
    IBOutlet UILabel                 *sourceArticle1;
    IBOutlet UILabel                 *sourceArticle2;
    IBOutlet UILabel                 *sourceArticle3;
    IBOutlet UILabel                 *sourceArticle4;
    IBOutlet UILabel                 *sourceArticle5;
    UILabel                          *tilte;
    IBOutlet UILabel                 *logoSourceArticle;
    IBOutlet UILabel                 *nameSourceArticle;
    IBOutlet UIButton                *flipButton;
    UIButton                         *optionButton;
    

    UIImageView     *_coverImageView;
    UIImageView     *_ezineLogo;
    UIImageView     *_logoSite;
    UIImageView     *_loadingGif;
    
    UILabel         *_sourceArticle1;
    UILabel         *_sourceArticle2;
    UILabel         *_sourceArticle3;
    UILabel         *_sourceArticle4;
    UILabel         *_sourceArticle5;
    UILabel         *_sourceArticle6;// label : & More
    UILabel         *_tilte;
    UILabel         *_logoSourceArticle;
    UILabel         *_nameSourceArticle;
    UILabel         *_coverStatic;//@" Trang bia"
    
    UIButton        *_flipButton;
    UIButton        *_optionButton;
    CGRect        _showActionButton;
    
    
    NSMutableArray  *_arrayCoverImage;
    NSMutableArray  *_arrayCoverImageLandScape;
    
    NSMutableArray  *_arraySite;
    NSMutableArray  *_arraySiteLandScape;
    NSMutableArray  *_arraySiteLabel;

    BOOL isStartedSlideShow;
    
    SiteObject       *_siteObject;
    float       timechange;
    int         currentImage;
    int test;
    UIInterfaceOrientation  _currentOrientation;
    NSString *urlweb;
}
@property(nonatomic, assign)id<CoverViewControllerDelegate>delegate;
@property (nonatomic, strong) MKNetworkOperation*   imageLoadingOperation;
@property(nonatomic,retain) IBOutlet UIImageView     *coverImageView;
@property(nonatomic,retain) IBOutlet UILabel         *sourceArticle1;
@property(nonatomic,retain) IBOutlet UILabel         *sourceArticle2;
@property(nonatomic,retain) IBOutlet UILabel         *sourceArticle3;
@property(nonatomic,retain) IBOutlet UILabel         *sourceArticle4;
@property(nonatomic,retain) IBOutlet UILabel         *sourceArticle5;
@property(nonatomic,retain) UILabel                  *tilte;
@property(nonatomic,retain) IBOutlet UILabel         *logoSourceArticle;
@property(nonatomic,retain) IBOutlet UILabel         *nameSourceArticle;
@property(nonatomic,retain) IBOutlet UIButton        *flipButton;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@property (retain, nonatomic) GooglePlusShare *share;

-(void) receivedRotate;

- (void)showActivityIndicator;
- (void)hideActivityIndicator;

-(void)shareEmail;

-(void)shareFacebook;

-(void)closeFullScreen;
//-(void)shareTwitter;

//-(void)ReadItLater;

-(void)shareMessage;

-(void)ShareViaGooglePlus;

//-(void)ReadBaseOnWeb:(int)numberCover;

-(void) reloadFontSize;

@end



