//
//  NewListArticleItemView6.h
//  Ezine
//
//  Created by Hieu  on 8/28/12.
//
//

#import "UIViewExtention.h"
#import "MKNetworkKit.h"

@class ArticleModel;

@interface NewListArticleItemView6 : UIViewExtention{
        
        UIView*          contentView;
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
@property                   NSInteger        _idLayout;

- (id) initWithMessageModel:(ArticleModel*) _itemModel andViewoder:(NSInteger)oderview;
- (void) initializeFields;



@end
