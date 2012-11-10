//
//  SourceModel.h
//  Ezine
//
//  Created by PDG2 on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//



@interface SourceModel : NSObject{
    NSInteger   _sourceId;
    NSString    *_image;
    NSString    *_title;
    BOOL        _isAddButton;
    BOOL        _isTopSource;
    NSArray     *_articleList;
    
}
@property( nonatomic, retain) NSArray    *articleList;
@property( nonatomic, assign) NSInteger   sourceId;
@property( nonatomic, retain) NSString    *image;
@property( nonatomic, retain) NSString    *title;
@property( nonatomic, assign) BOOL        isAddButton;
@property( nonatomic, assign) BOOL        isTopSource;

-(id)initWithId:(NSInteger)_id image:(NSString *)_img title:(NSString *)title isAddButton:(BOOL)_is isTop:(BOOL)_is1 articleList:(NSArray*)_arr;
@end
