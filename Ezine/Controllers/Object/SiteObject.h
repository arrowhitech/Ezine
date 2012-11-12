//
//  SiteObject.h
//  Ezine
//
//  Created by MAC on 8/9/12.
//
//

#import <Foundation/Foundation.h>

@interface SiteObject : NSObject{
    int         _siteID;
    NSString    *_name;
    NSString    *_logoUrl;
    NSString    *_title;
    int         _id;
    int         _articleID;
}

@property                       int     _siteID;
@property                       int     _id;
@property                       int     _articleID;
@property (nonatomic, retain)   NSString      *_name;
@property (nonatomic, retain)   NSString      *_logoUrl;
@property (nonatomic, retain)   NSString      *_title;
@property (nonatomic, retain)   NSString      *_urlWeb;

-(void)loadDataFrom:(NSDictionary*)data;
@end
