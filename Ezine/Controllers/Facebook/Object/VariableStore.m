//
//  VariableStore.m
//  Ezine
//
//  Created by MAC on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VariableStore.h"

@implementation VariableStore
@synthesize arrayListFb;
@synthesize urlProlifeImage;
@synthesize prolifeImage,UrlImageFriends;
@synthesize _arrayItemToDelete;

+ (VariableStore *)sharedInstance
{
    // the instance of this class is stored here
    static VariableStore *myInstance = nil;
    
    // check to see if an instance already exists
    if (nil == myInstance) {
        myInstance  = [[[self class] alloc] init];
        // initialize variables here
    }
    // return the instance of this class
    return myInstance;
}
@end
