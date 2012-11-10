//
//  NewListArticleItemView3.h
//  Ezine
//
//  Created by MAC on 8/28/12.
//
//

#import "UIViewExtention.h"
#import "MKNetworkKit.h"
#import <CoreText/CoreText.h>

@class ArticleModel;
@interface NewListArticleItemView3 : UIViewExtention{
    UIView*          contentView;
    UIImageView*     imageView;
    UIImageView*     imageIconView;
    UILabel*         title;
    UILabel*         titleFeed;
    UILabel*         time_ago;
    UILabel*         text_content;
    UILabel*         extraTitle;
    UIInterfaceOrientation currentOrientation;
}
@property (nonatomic, strong) MKNetworkOperation* imageLoadingOperation;
@property                   NSInteger        _idLayout;

- (id) initWithMessageModel:(ArticleModel*) _itemModel andViewoder:(NSInteger)oderview;
- (void) initializeFields;

-(void) ChangertoLanscape;

@property (nonatomic,retain) ArticleModel* itemModel;



@end
