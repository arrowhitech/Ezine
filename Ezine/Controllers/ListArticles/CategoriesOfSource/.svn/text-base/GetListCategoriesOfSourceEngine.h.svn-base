//
//  ListCategoriesOfSourceEngine.h
//  Ezine
//
//  Created by PDG2 on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import "MKNetworkKit.h"
@interface GetListCategoriesOfSourceEngine :MKNetworkEngine

typedef void (^responeBlock)(NSMutableArray* array);
-(void) listCategoryForSource:(NSInteger) idSource onCompletion:(responeBlock) categoryBlock onError:(MKNKErrorBlock) errorBlock;
@end
