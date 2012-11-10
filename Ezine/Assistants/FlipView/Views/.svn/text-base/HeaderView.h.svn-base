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
//  HeaderView.h
//  FlipView
//
//  Created by Reefaq Mohammed on 16/07/11.
 
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MKNetworkKit.h"
#define SEARCHBAR_BORDER_TAG 1337

@protocol HeaderViewDelegate<NSObject>
@optional
- (void) ezineButtonClicked:(id)sender;
- (void) themButtonClicked:(id)sender;
- (void) listButtonClicked:(UIButton*)sender;
- (void) showCategoryOfSource:(UIButton*)sender inRect:(CGRect)frame;
@end

@interface HeaderView : UIView {
	UIInterfaceOrientation currrentInterfaceOrientation;
    UIButton    *ezineBtn;
    UIButton    *themBtn;
    UIButton    *listBtn;
    IBOutlet UIButton*    btnArticleType;
    
    IBOutlet UIImageView* imgViewWedIcon;     
    BOOL _islayout1;
    // check if list article is search buy keyword all site
    BOOL                        _isSearchAllSite;
    UISearchBar                 *searchKeyword;
    UIImageView* _lineImage;
    BOOL        isaddSiteFromKeyWord;
    UILabel     *numberArticle;
    
    //HIeu Extra code============
    NSString* nameSiteHeader;
    NSString* logoURlforhear;
}
@property  NSInteger _idSite;
@property (assign, nonatomic) id <HeaderViewDelegate>delegate;
@property (nonatomic,readonly) UIInterfaceOrientation currrentInterfaceOrientation;
@property (nonatomic,retain) NSString*                   wallTitleText;
@property (nonatomic,retain) IBOutlet UIImageView*       imgViewWedIcon;    
@property (nonatomic,retain)     IBOutlet UIButton*      btnArticleType;
@property (nonatomic, strong) MKNetworkOperation* imageLoadingOperation;
@property (nonatomic)    BOOL  _islayout1;
@property (nonatomic)    BOOL                        _isSearchAllSite;
@property (nonatomic, assign)   UILabel               *_namesite;
@property (nonatomic, assign)    UILabel     *numberArticle;

@property(nonatomic,retain)  NSString* nameSiteHeader;
@property(nonatomic,retain)  NSString* logoURlforhear;

-(void)rotate:(UIInterfaceOrientation)interfaceOrientation animation:(BOOL)animation;
-(void)ezineTouched:(id) sender;
-(void)themTouched:(id) sender;
-(void)listTouched:(id) sender;
-(IBAction)articleListType:(id)sender;
-(void)setAlpha:(CGFloat)alpha;
-(void)fetchedData:(NSDictionary *)data;
-(void)changeStyleHeader:(int) layoutId;
-(void)checkSite;

//Hieu extra code

 -(BOOL)connected;

@end
