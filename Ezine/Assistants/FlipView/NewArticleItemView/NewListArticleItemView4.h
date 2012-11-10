//
//  NewListArticleItemView4.h
//  Ezine
//
//  Created by Hieu  on 8/29/12.
//
//

#import "UIViewExtention.h"
@class CTView;
@class ArticleModel;
@class ContentViewforAc4;

@interface NewListArticleItemView4 : UIViewExtention{
    
    CTView*          contentView;
    UIImageView*     imageView;
    UIImageView*     imageIconView;
    UILabel*         title;
    UILabel*         titleFeed;
    UILabel*         time_ago;
    UILabel*         text_content;
    UILabel*         extraTitle;
    NSInteger        _idLayout;
    
    
    
}

@property (nonatomic, strong) MKNetworkOperation* imageLoadingOperation;
@property (nonatomic,retain) ArticleModel* itemModel;
@property                    NSInteger        _idLayout;
@property (nonatomic,retain)  CTView*          contentView;

- (id) initWithMessageModel:(ArticleModel*) _itemModel andViewoder:(NSInteger)oderview ;
- (void) initializeFields;


@end
