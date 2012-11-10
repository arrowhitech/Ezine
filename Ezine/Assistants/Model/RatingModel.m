//
//  RatingCellJsonObj.m
//  Ezine
//
//  Created by Admin on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RatingModel.h"

@implementation RatingModel
@synthesize title,username,content,timeAgo,numOfStarRating,numOfChoise,numOfComment,url,urlWebIcon;

-(id) initWithTitle:(NSString *)ttl andUsername:(NSString *)usn andTimeAgo:(NSString *) tiago andContent:(NSString *)ctent andNumofStarRating:(NSInteger) numofStar
     andNumofComent:(NSInteger)numofcmd andNumofChoise:(NSInteger)numchoise andURL:
(NSString *)_url andURLWebIcon:(NSString *) urlwebicon{
    self =[super init];
    if(self){
        
        self.title =ttl;
        self.username =usn;
        self.timeAgo =tiago;
        self.content =ctent;
        self.numOfStarRating =numofStar;
        self.numOfChoise =numchoise;
        self.numOfComment =numofcmd;
        self.url =_url;
        self.urlWebIcon =urlwebicon;
    }
    
    return self;
}
@end
