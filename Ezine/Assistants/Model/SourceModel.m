//
//  SourceModel.m
//  Ezine
//
//  Created by PDG2 on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SourceModel.h"

@implementation SourceModel
@synthesize isAddButton=_isAddButton,sourceId=_sourceId,image=_image,title=_title,isTopSource=_isTopSource,articleList=_articleList;

-(id)initWithId:(NSInteger)_id image:(NSString *)_img title:(NSString *)title isAddButton:(BOOL)_is isTop:(BOOL)_is1 articleList:(NSArray*)_arr{
    if (self = [super init]) {
        self.sourceId = _id;
        self.image  = _img;
        self.title  = title;
        self.isAddButton = _is;
        self.isTopSource = _is1;
        if (_arr!=nil) {
             self.articleList = [_arr retain];
        }
    }
    return self;
}

-(void)dealloc{
    [super dealloc];
    [_image release];
    [_title release];
    [_articleList release];
}
@end
