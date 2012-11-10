//
//  SiteDownloadModel.m
//  Ezine
//
//  Created by MrKien on 11/1/12.
//
//

#import "SiteDownloadModel.h"

@implementation SiteDownloadModel
@synthesize siteID,nameSite;

-(id)initWithSiteID:(NSInteger )siteID andNameSite:(NSString*) namesite{
    if (self =[super init]) {
        
        self.siteID =siteID;
        self.nameSite =namesite;
    }
    return self;
}

@end
