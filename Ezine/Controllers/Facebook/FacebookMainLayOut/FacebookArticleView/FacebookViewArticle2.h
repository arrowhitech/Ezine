//
//  FacebookViewArticle1.h
//  Ezine
//
//  Created by MAC on 10/15/12.
//
//

#import "UIViewExtention.h"
#import "MKNetworkKit.h"
#import "OHAttributedLabel.h"
#import "ArticleModel.h"
#import "FacebookListViewController.h"

@interface FacebookViewArticle2 : UIViewExtention<FBSessionDelegate,FBRequestDelegate>{
    UIView*          contentView;
    UIImageView*     imageView;
    UIImageView*     imageIconView;
    UILabel*         title;
    UILabel*         titleFeed;
    UILabel*         time_ago;
    OHAttributedLabel *         text_content;
    UILabel*         extraTitle;
    UIInterfaceOrientation _orientation;
    UILabel*         nameActor;
    UILabel*         numbercomment;
    UILabel*         numberLike;
    NSString*        urlImage;
}

@property (nonatomic, strong)   MKNetworkOperation* imageLoadingOperation;
@property                       NSInteger        _idLayout;
@property  (nonatomic, assign)  NSString         *idActorPost;

@property                       NSInteger        _type;

@property (nonatomic,retain) FBObjectModel* itemModel;

- (id) initWithMessageModel:(FBObjectModel*) _itemModel andViewoder:(NSInteger)oderview;
- (void) initializeFields ;
@end
