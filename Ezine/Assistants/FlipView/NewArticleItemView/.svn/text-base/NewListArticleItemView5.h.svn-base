//
//  NewListArticleItemView5.h
//  Ezine
//
//  Created by Hieu  on 8/29/12.
//
//

#import "UIViewExtention.h"
@class ArticleModel;

@interface NewListArticleItemView5 : UIViewExtention{
    
    UIView*          contentView;
    UIImageView*     imageView;
    UIImageView*     imageIconView;
    UILabel*         title;
    UILabel*         titleFeed;
    UILabel*         time_ago;
    OHAttributedLabel*         text_content;
    UILabel*         extraTitle;
    NSInteger        _idLayout;
    
}

@property (nonatomic, strong) MKNetworkOperation* imageLoadingOperation;
@property (nonatomic,retain) ArticleModel* itemModel;
@property                   NSInteger        _idLayout;

- (id) initWithMessageModel:(ArticleModel*) _itemModel andViewoder:(NSInteger)oderview;
- (void) initializeFields;

-(void) ChangetoLanscape;
@end
