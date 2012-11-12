//
//  SiteObject.m
//  Ezine
//
//  Created by MAC on 8/9/12.
//
//

#import "SiteObject.h"

@implementation SiteObject
@synthesize _logoUrl,_name,_siteID,_title,_id,_urlWeb,_articleID;


-(void)loadDataFrom:(NSDictionary*)data{
    self._logoUrl=[data   objectForKey:@"LogoUrl"];
    self._siteID=[[data objectForKey:@"SiteID"] intValue];
    self._title=[data objectForKey:@"Title"];
    self._name=[data objectForKey:@"Info"];
    if ((NSNull *)_logoUrl==[NSNull null]) {
        self._logoUrl=@"";
    }
    if ((NSNull *)_siteID==[NSNull null]) {
        self._siteID=-100;
    }
    if ((NSNull *)_title==[NSNull null]) {
        self._title=@"";
    }
    if ((NSNull *)_name==[NSNull null]) {
        self._name=@"";
    }
}

@end
