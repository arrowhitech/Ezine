//
//  FacebookListViewController.h
//  Ezine
//
//  Created by MAC on 10/15/12.
//
//

#import <UIKit/UIKit.h>
#import "FBFeedPost.h"
#import "FBRequestWrapper.h"
#import "FBObjectModel.h"
#import "LayoutViewExtention.h"
#import "HeaderView.h"
#import "FooterView.h"
#import "MPFlipViewController.h"
#import "FbHeaderView.h"
#import "FbFooterView.h"

@interface FacebookListViewController : UIViewController<FBFeedPostDelegate,FBRequestDelegate,FBSessionDelegate,MPFlipViewControllerDataSource,MPFlipViewControllerDelegate,FbHeaderViewDelegate,FbFooterViewDelegate>{
    
    NSInteger       currentAPI;
    NSMutableArray  *arrayDataNewFeed;
    NSMutableArray  *arrayDataNewFeedStatus;
    NSMutableArray              *arrayPage;
    int              activeIndex;
    BOOL            _isUpdateArticle;
    int                         _numberPage;

}

@property (nonatomic) int          lastTimeStatusUpdate;
@property (nonatomic) int          lastTimePostupdate;
@property (strong, nonatomic) MPFlipViewController *flipViewController;

-(void)getApifeedFacebook:(int)ApiGet;
-(void)pasteDataNewFeed:(id)result;
-(void) builtPage;

@end
