//
//  SettingDownloadModel.m
//  Ezine
//
//  Created by Admin on 7/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingDownloadModel.h"

@implementation SettingDownloadModel
@synthesize ischecked;
@synthesize titleUrl;
@synthesize IdofUrl;
-(id)initwithURl:(NSString *)_url andSateCheck:(BOOL)_ischecked andIDofUrl:(NSInteger)_idurl{
    
    if (self =[super init]) {
        
        self.ischecked =_ischecked;
        self.titleUrl =_url;
        self.IdofUrl =_idurl;
    }
    return self;
}

@end
