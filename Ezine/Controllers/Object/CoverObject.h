//
//  CoverObject.h
//  Ezine
//
//  Created by MAC on 8/8/12.
//
//

#import <Foundation/Foundation.h>

@interface CoverObject : NSObject{
    int             _articleID;
    NSString        *_mainHeadImageUrl_L;
    NSString        *_mainHeadImageUrl_P;
    NSString        *_title;
    NSDictionary    *_site;
}
@property                       int         _articleID;
@property (nonatomic,retain)    NSString        *_mainHeadImageUrl_L;
@property (nonatomic,retain)    NSString        *_mainHeadImageUrl_P;
@property (nonatomic,retain)    NSString        *_title;
@property (nonatomic,retain)    NSString        *_urlWeb;
@property (nonatomic,retain)    NSDictionary    *_site;


@end
