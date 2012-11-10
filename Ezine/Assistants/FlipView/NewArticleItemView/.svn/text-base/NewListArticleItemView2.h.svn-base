//
//  NewListArticleItemView2.h
//  Ezine
//
//  Created by MAC on 8/28/12.
//
//

#import "UIViewExtention.h"
#import "MKNetworkKit.h"
#import "OHAttributedLabel.h"

@class ArticleModel;
@interface NewListArticleItemView2 : UIViewExtention{
    
    UIView*          contentView;
    UIImageView*     imageView;
    UIImageView*     imageIconView;
    UILabel*         title;
    UILabel*         titleFeed;
    UILabel*         time_ago;
    OHAttributedLabel *         text_content;
    UILabel*         extraTitle;
    UIInterfaceOrientation _orientation;
}
@property (nonatomic, strong) MKNetworkOperation* imageLoadingOperation;
@property                   NSInteger        _idLayout;
@property (nonatomic,retain) ArticleModel* itemModel;

- (id) initWithMessageModel:(ArticleModel*) _itemModel andViewoder:(NSInteger)oderview;
- (void) initializeFields;
- (void)changeLandScape;


@end
