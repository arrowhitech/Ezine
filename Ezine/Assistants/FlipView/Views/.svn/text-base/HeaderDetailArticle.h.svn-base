//
//  HeaderDetailArticle.h
//  Ezine
//
//  Created by MAC on 9/10/12.
//
//

#import <UIKit/UIKit.h>
#import "MKNetworkKit.h"

@protocol HeaderDetailArticleDelegate<NSObject>
@optional
- (void) ezineButtonClicked:(id)sender;
- (void) themButtonClicked:(id)sender;
- (void) listButtonClicked:(UIButton*)sender;
- (void) showCategoryOfSource:(UIButton*)sender;
@end


@interface HeaderDetailArticle : UIView{
    UIButton    *ezineBtn;
    UIButton    *themBtn;
    UIImageView *_lineImage;
    UIImageView *_logoSite;
    
    NSString* urlLogo;
}
@property (assign, nonatomic) id <HeaderDetailArticleDelegate>delegate;
@property (nonatomic, strong) MKNetworkOperation* imageLoadingOperation;
@property(nonatomic,retain)    NSString* urlLogo;

-(void) setWallTitleText:(int )idSite;
- (void)reAdjustLayout:(UIInterfaceOrientation)interfaceOrientation;
-(void) fetchedData:(NSDictionary*)data;
-(BOOL)connected;
@end
