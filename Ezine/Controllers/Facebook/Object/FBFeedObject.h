//
//  FBFeedObject.h
//  Ezine
//
//  Created by MAC on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBFeedObject : NSObject{
    NSString        *idfeed;
    NSDictionary    *from;
    NSString        *message;
    NSString        *link;
    NSString        *picture;
    NSString        *name;
    NSString        *caption;
    NSDictionary    *actions;
    NSString        *type;
    NSString        *create_time;
    NSString        *update_time;
    NSDictionary    *likes;
    NSDictionary    *comments;
    NSDictionary    *paging;   
    NSString        *object_id;
    //video
    NSString        *description;  
    NSString        *source;
    NSString        *story;
}

@property (nonatomic, retain)   NSString    *idfeed;
@property (nonatomic, retain)   NSDictionary     *from;
@property (nonatomic, retain)   NSString    *message;
@property (nonatomic, retain)   NSString    *link;
@property (nonatomic, retain)   NSString    *picture;
@property (nonatomic, retain)   NSString    *name;
@property (nonatomic, retain)   NSString    *caption;
@property (nonatomic, retain)   NSDictionary     *actions;
@property (nonatomic, retain)   NSString    *type;
@property (nonatomic, retain)   NSString    *create_time;
@property (nonatomic, retain)   NSString    *update_time;
@property (nonatomic, retain)   NSDictionary     *likes;
@property (nonatomic, retain)   NSDictionary     *comments;
@property (nonatomic, retain)   NSDictionary     *paging;    
@property (nonatomic, retain)   NSString        *description;    
@property (nonatomic, retain)   NSString        *source;
@property (nonatomic, retain)   NSString        *story;
@property (nonatomic, retain)   NSString        *object_id;

@end
