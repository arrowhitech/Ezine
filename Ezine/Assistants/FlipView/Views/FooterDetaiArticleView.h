//
//  FooterDetaiArticleView.h
//  Ezine
//
//  Created by MAC on 9/19/12.
//
//

#import <UIKit/UIKit.h>
#import "MKNetworkKit.h"
#import "ArticleDetailModel.h"
#import "SiteObject.h"
#import "FBFeedPost.h"
#import "IFNNotificationDisplay.h"
#import "MessageUI/MessageUI.h"
#import "GooglePlusShare.h"

@protocol FooterDetaiArticleView

-(void) shareEmail;
-(void) ReadBaseOnWeb;

@end

@interface FooterDetaiArticleView : UIView<UIActionSheetDelegate,FBFeedPostDelegate,FBSessionDelegate,FBRequestDelegate,GooglePlusShareDelegate,MFMailComposeViewControllerDelegate>{
    
    UILabel *_titleFeed;
    UILabel *_time_ago;
    UILabel *_pageNumber;
    UIButton    *_comment;
    UIButton    *_reload;
    UIButton    *_like;
    UIButton    *_move;
    UIImageView *_logoSite;
    UIImageView *_line1;
    UIImageView *_line2;
    
    UIInterfaceOrientation  _currentOrientation;
    UIActionSheet* actioncover;
    UIActionSheet *actionshare;
    
    id<FooterDetaiArticleView> delegate;
    
    NSString* urlLogo;
    NSString* sitename;
    BOOL    isbookmark;
}
@property   int   _curentPage;
@property   int   _allpage;
@property   int   _articleID;
@property (nonatomic, strong) MKNetworkOperation* imageLoadingOperation;
@property(nonatomic,retain)GooglePlusShare *share;

@property(nonatomic,retain)  NSString* urlLogo;
@property(nonatomic,retain)  NSString* sitename;


@property(nonatomic,retain) id<FooterDetaiArticleView> delegate;

-(void) setdataWithModel:(ArticleDetailModel *)articleDetailModerl;
-(void) reAdjustLayout:(UIInterfaceOrientation) interfaceOrientation;
-(void) fetchedData:(NSDictionary*)data;

//===================== ActionSheet Method

//-(void) ReadItLater;
-(void) shareFacebook;
//-(void) shareTwitter;


-(void)ShareViaGooglePlus;


@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

- (void)showActivityIndicator;
- (void)hideActivityIndicator;

-(BOOL)connected;


@end
