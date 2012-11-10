//
//  JsonFBNewFeed.h
//  Ezine
//
//  Created by MAC on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonFBNewFeed : NSObject{
    NSString    *urlPicture;
    NSString    *title;
    NSString    *urlProlifeIcon;
    NSString    *nameProlife;
    NSString    *dateCreate;
    NSString    *idFeed;
    NSString    *userLike;
    NSString    *linkLikeFeed;
    
    int         numberUserLike;
    int         timeCreate;
    
    
}
@property (nonatomic, retain)    NSString    *urlPicture;
@property (nonatomic, retain)    NSString    *title;
@property (nonatomic, retain)    NSString    *urlProlifeIcon;
@property (nonatomic, retain)    NSString    *nameProlife;
@property (nonatomic, retain)    NSString    *dateCreate;
@property (nonatomic, retain)    NSString    *idFeed;
@property (nonatomic, retain)    NSString    *userLike;
@property (nonatomic, retain)    NSString    *linkLikeFeed;


@property                       int         numberUserLike;
@property                       int         timeCreate;

@end
