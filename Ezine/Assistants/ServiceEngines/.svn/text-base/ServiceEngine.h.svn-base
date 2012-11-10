//
//  ServiceEngine.h
//  Ezine
//
//  Created by Nguyen van phuoc on 8/30/12.
//
//

#import <Foundation/Foundation.h>
#import "MKNetworkEngine.h"
@interface ServiceEngine : MKNetworkEngine{

}
typedef void (^ResponeBlock)(NSDictionary* responseDict);
typedef void (^ResponeBlock1)(NSMutableArray* responseArr);

// service for topcover
-(void) listTopCoveronCompletion:(ResponeBlock1) responeBlock onError:(MKNKErrorBlock) errorBlock;
-(void) listTopSiteonCompletion:(ResponeBlock1) responeBlock onError:(MKNKErrorBlock) errorBlock;

// service for first page
-(void) listSiteMasterPage:(BOOL)reload OnCompletion:(ResponeBlock) responeBlock onError:(MKNKErrorBlock) errorBlock;


// service for list article page
-(void) GetListArticleInSitePagingID:(int) siteID  onCompletion:( ResponeBlock1) completionBlock
                             onError:(MKNKErrorBlock) errorBlock;

-(MKNetworkOperation*) getListArticleUpdateInSitePagingID:(int) siteID inchanelID:(int)chanelID FromTime:(NSString*) time numberOffPage:(int) numberPage onCompletion:( ResponeBlock) completionBlock
                                   onError:(MKNKErrorBlock) errorBlock;
// service for SiteDetail
-(void) listCategoryForSource:(NSInteger) idSource onCompletion:(ResponeBlock1) responeBlock onError:(MKNKErrorBlock) errorBlock;

// service for category
-(void) ListCategories:(ResponeBlock1) responeBlock onError:(MKNKErrorBlock) errorBlock;
-(void) listSiteByCategoryID:(int )CategoryID onCompletion:(ResponeBlock) responeBlock onError:(MKNKErrorBlock) errorBlock;
-(void) getLastestForSourceOnCompletion:(ResponeBlock1) responeBlock onError:(MKNKErrorBlock) errorBlock;
-(void) SearchSiteEngineSiteName:(NSString*) siteName  onCompletion:( ResponeBlock1) completionBlock
                         onError:(MKNKErrorBlock) errorBlock;


// service for account setting
-(void) changePass:(NSDictionary*)infor onCompletion:(ResponeBlock) responeBlock onError:(MKNKErrorBlock) errorBlock;

// service for a site
-(void) getDetailAsite:(int)site onCompletion:(ResponeBlock) responeBlock onError:(MKNKErrorBlock) errorBlock;

-(void) getChangeFromSite:(int)site onCompletion:(ResponeBlock1) responeBlock onError:(MKNKErrorBlock) errorBlock;
-(void) getLatestSourceNewSite:(int)idSite onCompletion:(ResponeBlock) responeBlock onError:(MKNKErrorBlock) errorBlock;

// service for a Article
-(void) GetArticleDetail:(int) ArticleDetailID  onCompletion:( ResponeBlock) completionBlock
                             onError:(MKNKErrorBlock) errorBlock;
//Service for sending comment===============
-(void) SentCommentwithSiteident:(int)SiteID userident:(int) userID withComment:(NSString*) commentText onCompletion:(ResponeBlock) responeBlock onError:(MKNKErrorBlock) errorBlock;

-(void) RatewithSiteID:(int)siteID anduserID:(int)userID andRateMark:(int)rateMark onCompletion:(ResponeBlock) responeBlock onError:(MKNKErrorBlock) errorBlock;

-(void) listRaringSite:(int )SiteID onCompletion:(ResponeBlock) categoryBlock onError:(MKNKErrorBlock) errorBlock;
// service for search keyword
    ///========== search all site
-(MKNetworkOperation*) getListArticleSearchInAllsite:(NSString*)keyWord FromTime:(NSString*) time numberOffPage:(int) numberPage onCompletion:( ResponeBlock) completionBlock
                                             onError:(MKNKErrorBlock) errorBlock;
    //=============seach in 1 site
-(MKNetworkOperation*) getListArticleSearchInSite:(int)siteID  inchanelID:(int)chanelID KeyWold:(NSString*)keyWord FromTime:(NSString*) time numberOffPage:(int) numberPage onCompletion:( ResponeBlock) completionBlock
                                             onError:(MKNKErrorBlock) errorBlock;

// service get list article for 1 site
-(MKNetworkOperation*) getListArticleInsite:(int)siteID FromTime:(NSString*) time numberOffPage:(int) numberPage onCompletion:( ResponeBlock) completionBlock
                                             onError:(MKNKErrorBlock) errorBlock;

-(MKNetworkOperation*) getListArticleChanelInsite:(int)siteID chanelID:(int)chanelID FromTime:(NSString*) time numberOffPage:(int) numberPage onCompletion:( ResponeBlock) completionBlock
                                    onError:(MKNKErrorBlock) errorBlock;

// service for get article  keyword of user
-(void) getListArticleUserKeyword:(ResponeBlock1) responeBlock onError:(MKNKErrorBlock) errorBlock;

-(void) UserAddKeyWord:(NSString*)keyword inSite:(int) siteID onCompletion:( ResponeBlock) completionBlock
               onError:(MKNKErrorBlock) errorBlock;
// service for bookmark
-(void) getListBookmarkFromtime:(NSString *)fromtime  numberPage:(int)numberpage onCompletion:( ResponeBlock) completionBlock onError:(MKNKErrorBlock) errorBlock;
//--------- add bookmark
-(void) userAddBookMarkArticleID:(int)articleID onCompletion:( ResponeBlock) completionBlock onError:(MKNKErrorBlock) errorBlock;

//---- service update list site user

-(void) updateListSiteUser:(NSString *)listSite onCompletion:( ResponeBlock) completionBlock onError:(MKNKErrorBlock) errorBlock;

//----- user remove a stie

-(void) userremoveStie:(int)siteID onCompletion:( ResponeBlock) completionBlock onError:(MKNKErrorBlock) errorBlock;
//----- service user add a site to list
-(void) userAddsiteToList:(int)siteID onCompletion:( ResponeBlock) completionBlock onError:(MKNKErrorBlock) errorBlock;

//---------- download offline data

-(void) downloadDataOfflineSite:(int)siteID reload:(BOOL)reload onCompletion:( ResponeBlock) completionBlock onError:(MKNKErrorBlock) errorBlock;
@end
