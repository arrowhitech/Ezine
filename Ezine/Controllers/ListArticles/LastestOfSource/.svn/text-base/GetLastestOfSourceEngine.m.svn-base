//
//  LastestOfSourceEngine.m
//  Ezine
//
//  Created by PDG2 on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GetLastestOfSourceEngine.h"

@implementation GetLastestOfSourceEngine
-(void)getLastestForSource:(NSInteger)idSource onCompletion:(lastestBlock)categoryBlock onError:(MKNKErrorBlock)errorBlock{
    
    MKNetworkOperation *op = [self operationWithPath:@"services/rest/?method=flickr.photos.search&api_key=210af0ac7c5dad997a19f7667e5779d3&tags=Singapore&per_page=200&format=json&nojsoncallback=1"];
    
    [op onCompletion:^(MKNetworkOperation *completedOperation) {
        NSDictionary *response = [completedOperation responseJSON];
        categoryBlock([[response objectForKey:@"photos"] objectForKey:@"photo"]);
        
    } onError:^(NSError *error) {
        
        errorBlock(error);
    }];
    
    [self enqueueOperation:op];
}

-(NSString*) cacheDirectoryName {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *cacheDirectoryName = [documentsDirectory stringByAppendingPathComponent:@"lastestOfSourceImage"];
    return cacheDirectoryName;
}
@end
