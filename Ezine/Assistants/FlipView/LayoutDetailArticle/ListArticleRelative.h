//
//  ListArticleRelative.h
//  Ezine
//
//  Created by NGUYỄN VĂN ĐẢNG on 11/12/12.
//
//

#import <UIKit/UIKit.h>
#import "MKNetworkEngine.h"
#import "ServiceEngine.h"

@protocol ListArticleRelativeDelegate <NSObject>

-(void) didSelectArticle:(int)arcticleId;

@end

@interface ListArticleRelative : UITableViewController{
    
    int _layoutID;
    NSMutableArray  *_arrayListNewArticle;
    NSMutableArray  *_arrayListArticle;
}
@property   int _siteId;
@property (strong, nonatomic) NSMutableArray *listLastest;
@property (nonatomic, assign) id <ListArticleRelativeDelegate> delegate;
-(void) getLastestSource;
@end
