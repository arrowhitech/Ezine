//
//  LastestOfSource.h
//  Ezine
//
//  Created by PDG2 on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "MKNetworkEngine.h"
#import "ServiceEngine.h"

@interface LastestOfSource : UITableViewController{
    
    int _layoutID;
    NSMutableArray  *_arrayListNewArticle;
    NSMutableArray  *_arrayListArticle;
}
@property   int _siteId;
@property (strong, nonatomic) NSMutableArray *listLastest;

-(void) getLastestSource;
@end
