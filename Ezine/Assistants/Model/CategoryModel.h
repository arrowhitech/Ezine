//
//  CategoryModel.h
//  Ezine
//
//  Created by PDG2 on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//



@interface CategoryModel : NSObject{
    NSInteger   _sourceId;
    NSInteger   _categoryId;
    NSString    *_image;
    NSString    *_title;
    
}
@property( nonatomic, assign) NSInteger   categoryId;
@property( nonatomic, assign) NSInteger   sourceId;
@property( nonatomic, retain) NSString    *image;
@property( nonatomic, retain) NSString    *title;

-(id) initWithId:(NSInteger) cId andSourceId:(NSInteger) sId andImage:(NSString*) image andTitle:(NSString*) title;
@end
