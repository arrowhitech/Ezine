//
//  DetailArticleView.h
//  Ezine
//
//  Created by MAC on 9/17/12.
//
//

#import <UIKit/UIKit.h>
#import "CTColumnView.h"
#import "ArticleDetailModel.h"
#import "MKNetworkKit.h"
#import "DTAttributedTextView.h"

@interface DetailArticleView : UIScrollView<UIScrollViewDelegate,DTAttributedTextContentViewDelegate>{
    

    float frameXOffset;
    float frameYOffset;

    NSAttributedString* attString;

    NSMutableArray* frames;
    NSArray* images;
    ArticleDetailModel*   articleModel;
    NSInteger   _idLayout;
    int   _numberPage;
    UIView*          contentView;
    UIImageView*     imageView;
    UIImageView*     imageIconView;
    UILabel*         title;
    UILabel*         titleFeed;
    UILabel*         time_ago;
    UILabel*         extraTitle;
    UILabel*         caption;
    UIImageView*     imageViewSecondView1;
    UIImageView*     imageViewSecondView2;
    DTAttributedTextView *_textView;
    int                  _secondPageImage;
}
@property (nonatomic,assign) ArticleDetailModel* articleModel;
@property (retain, nonatomic) NSAttributedString* attString;
@property (retain, nonatomic) NSMutableArray* frames;
@property (retain, nonatomic) NSArray* images;
@property (nonatomic, strong) MKNetworkOperation* imageLoadingOperation;

@property  int _textPost;
@property  int   _numberPage;

-(id)initWithArticleDetailModel:(ArticleDetailModel*)model;

-(void)buildFrames;
- (void)buildFramesArticle:(UIInterfaceOrientation )interfaceOrientation;
-(void)setAttString:(NSAttributedString *)attString withImages:(NSArray*)imgs;
-(void)attachImagesWithFrame:(CTFrameRef)f inColumnView:(CTColumnView*)col;
-(void)setAttString:(NSAttributedString *)attString1;

-(void) builtPageLandScape;
-(void) builtPagePoitrait;
-(void) builtFirstPageLandScape;
-(void) builtFirstPagePoitrait;
-(void) builtSecondPageLandScape;
-(void) builtSecondPagePortrait;
- (void)reAdjustLayout:(UIInterfaceOrientation)interfaceOrientation;
- (void)reAdjustLayoutSecondView:(UIInterfaceOrientation)interfaceOrientation;
-(void) reAdjustLayoutLandScape;

-(void) fetchedData:(NSDictionary*)data;

@end
