//
//  NewsModel.m
//  Ezine
//
//  Created by Admin on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ArticleModel.h"

@implementation ArticleModel
@synthesize icon =_icon;
@synthesize time_ago= _time_ago;
@synthesize titleFeed =_titleFeed;
@synthesize extraTitle =_extraTitle;
@synthesize _idLayout;
@synthesize _Zone;
@synthesize _ArticleID;
@synthesize _ArticleLandscape = ArticleLandscape;
@synthesize _ArticlePortrait = ArticlePortrait;
@synthesize DictForArticleDetail;
@synthesize nameSite;
@synthesize _numberComment;
-(id)initWithItemObject:(NSDictionary *)itemObject{
	if (self = [super init]) {
        self._ArticlePortrait = [itemObject objectForKey:@"ArticlePortrait"];
        self._ArticleLandscape = [itemObject objectForKey:@"ArticleLandscape"];
        self.DictForArticleDetail=[itemObject objectForKey:@"ArticleDetail"];
        self.icon =[itemObject objectForKey:@"SiteLogoUrl"];
        self.time_ago=[itemObject objectForKey:@"PublishTime"];
        self.titleFeed=[itemObject objectForKey:@"ZoneName"];
        self._ArticleID=[[itemObject objectForKey:@"ArticleID"] integerValue];
        self._Zone=[itemObject objectForKey:@"ZoneName"];
        self.extraTitle=@"FU DE Tieng Viet";
        self.nameSite=[itemObject objectForKey:@"SiteName"];
        self._numberComment=[[itemObject objectForKey:@"CommentCount"] integerValue];
	}
	return self;
}

-(void)dealloc{
    
    [_icon release];
    _icon = nil;
    
    
    [_time_ago release];
    _time_ago = nil;
    
    
    [_titleFeed release];
    _titleFeed = nil;

    [_extraTitle release];
    _extraTitle = nil;
    
    [super dealloc];

}

@end
