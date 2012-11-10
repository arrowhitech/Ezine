/*
 This module is licensed under the MIT license.
 
 Copyright (C) 2011 by raw engineering
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */
//
//  FullScreenView.h
//  FlipView
//
//  Created by Reefaq Mohammed on 16/07/11.

//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "LTTextView.h"
#import "UIViewExtention.h"
#import "EzineAppDelegate.h"
#import "ArticleModel.h"
#import "ArticleDetailModel.h"
#import "CTView.h"
#import "MarkupParser.h"
#import "HeaderDetailArticle.h"
#import "MKNetworkKit.h"
#import "DetailArticleView.h"
#import "MPFlipViewController.h"
#import "FooterDetaiArticleView.h"

#import "LTTextView.h"
#import "DTAttributedTextView.h"
#import "DTLazyImageView.h"
#import "DTAttributedTextView.h"
#import "Reachability.h"
#import <SystemConfiguration/SystemConfiguration.h>

@class CTView;

@protocol FullScreenViewDelegate <NSObject>

-(void)shareEmail;
-(void)ReadBaseOnWeb:(NSString*)url;

@end

@interface FullScreenView : UIViewExtention <HeaderDetailArticleDelegate,MPFlipViewControllerDataSource,MPFlipViewControllerDelegate,FooterDetaiArticleView,DTAttributedTextContentViewDelegate,DTLazyImageViewDelegate> {
	ArticleModel*   articleModel;
    NSMutableArray *_arrayViewDetailArticle;
    NSMutableArray *_arrayViewDetailArticleLandScape;
	DetailArticleView*         contentView;
    UIImageView*    imageView;
    UIImageView*    imageIconView;
    UILabel*        title;
    UILabel*       titleFeed;
    UILabel*       time_ago;
    UILabel*       text_content;
    
	UIViewExtention* viewToOverLap;
	UIView* fullScreenBG;
	UIButton* closeButton;
	
	UIScrollView*  scrollView;
    ArticleDetailModel *articledetailModel;
    UIImageView *_imageMain;
    NSInteger   _textLenght;
    NSInteger                       activeIndex;
    UIInterfaceOrientation          _currentOrientation;
    
    id<FullScreenViewDelegate> deletate;
    
    DTAttributedTextView *_textView;
    NSMutableSet *mediaPlayers;
    BOOL        _iscache;
    
   // NSDictionary* dicForArticleDetail;
    NSString* siteNameforFullScr;
    NSString* urlLogoforFullSrc;
    
    // Hieu
    UIImageView* imgFakeGifAnimation;
    
}

-(id)initWithModel:(ArticleModel*)model;
-(void)showFields;
-(void)fetchedData:(NSDictionary *)data;
-(void) buildLayoutDetailArticle;
-(void)orientationChanged;

@property (strong, nonatomic) MPFlipViewController *flipViewController;
@property (nonatomic,assign) ArticleModel* articleModel;
@property (nonatomic,assign) UIViewExtention* viewToOverLap;
@property (nonatomic,assign) UIView* fullScreenBG;
@property (nonatomic, retain)    UIImageView *_imageMain;
@property (nonatomic, strong) MKNetworkOperation* imageLoadingOperation;

@property(nonatomic,retain)  id<FullScreenViewDelegate> deletate;
@property (nonatomic, retain)    NSDictionary                    *cachedDataDetailArtcile;


@property (nonatomic, strong) NSMutableSet *mediaPlayers;

@property(nonatomic,retain)  NSString* siteNameforFullScr;
@property(nonatomic,retain)  NSString* urlLogoforFullSrc;

// Extra code ===========

//@property(nonatomic,strong) NSDictionary* dicForArticleDetail;
-(BOOL)connected;

@end
