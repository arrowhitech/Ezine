//
//  SettingDownloadModel.h
//  Ezine
//
//  Created by Admin on 7/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingDownloadModel : NSObject{
    
    NSString*         titleUrl;
    BOOL              ischecked;
    NSInteger         IdofUrl;
}

@property(nonatomic,retain) NSString*  titleUrl;
@property(nonatomic,assign) BOOL        ischecked;
@property(nonatomic,assign) NSInteger   IdofUrl;
-(id)initwithURl:(NSString *)_url andSateCheck:(BOOL)_ischecked andIDofUrl:(NSInteger )_idurl;

@end
