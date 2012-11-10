//
//  SiteDownloadModel.h
//  Ezine
//
//  Created by MrKien on 11/1/12.
//
//

#import <Foundation/Foundation.h>

@interface SiteDownloadModel : NSObject{
    NSInteger       siteID;
    NSString        *nameSite;
}
@property (nonatomic)    NSInteger       siteID;
@property (nonatomic, retain)      NSString        *nameSite;

-(id)initWithSiteID:(NSInteger )siteID andNameSite:(NSString*) namesite;
@end
