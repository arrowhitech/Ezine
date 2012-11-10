//
//  ListCategoriesOfSource.h
//  Ezine
//
//  Created by PDG2 on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "CategoryModel.h"
@protocol CategorySelectionDelegate
@optional
- (void)categorySelectionChanged:(CategoryModel *)curSelection;
@end

@interface ListCategoriesOfSource : UITableViewController{
    id<CategorySelectionDelegate> _delegate;
    
}
@property NSInteger _idSite;
@property (nonatomic, assign) id<CategorySelectionDelegate> delegate;
@property (strong, nonatomic) NSMutableArray *listCategories;
-(void)fetchedData:(NSMutableArray*)data;
@end
