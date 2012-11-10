//
//  FacebookViewArticle3.h
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

@interface FacebookViewArticle3 : UIViewExtention<FBSessionDelegate,FBRequestDelegate>{
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


}

@property (nonatomic, strong) MKNetworkOperation* imageLoadingOperation;
@property                   NSInteger        _idLayout;
@property (nonatomic,retain) FBObjectModel* itemModel;
@property  (nonatomic, assign)  NSString         *idActorPost;

- (id) initWithMessageModel:(FBObjectModel*) _itemModel andViewoder:(NSInteger)oderview;
- (void) initializeFields ;
@end
