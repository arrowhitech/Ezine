//
//  ArticleDetailModel.h
//  Ezine
//
//  Created by MAC on 9/10/12.
//
//

#import <Foundation/Foundation.h>

@interface ArticleDetailModel : NSObject{
    
    NSInteger   _ArticleID;
    NSInteger   _SiteID;
    NSInteger   _commnetCount;
    NSString    *_title;
    NSString    *_content;
    NSString    *_publishTime;
    NSString    *_caption;
    NSString*   urlreadWed;
    
    NSDictionary    *_articlePortrait;
    NSDictionary    *_ArticleLandscape;
}
@property(nonatomic, assign)    NSInteger   _ArticleID;
@property(nonatomic, assign)    NSInteger   _SiteID;
@property(nonatomic, assign)    NSInteger   _commnetCount;
@property(nonatomic, retain)    NSString    *_title;
@property(nonatomic, retain)    NSString    *_content;
@property(nonatomic, retain)    NSString    *_publishTime;
@property(nonatomic, retain)    NSString    *_caption;

@property(nonatomic, retain)    NSDictionary    *_articlePortrait;
@property(nonatomic, retain)    NSDictionary    *_ArticleLandscape;
@property(nonatomic,retain)      NSString*      urlreadWed;

@end
