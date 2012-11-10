//
//  UserEzineModel.m
//  Ezine
//
//  Created by Admin on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UserEzineModel.h"

@implementation UserEzineModel

@synthesize usernameEzine,passwordEzine,emailEzineRegister,fullNameEzine;
@synthesize imgeAvatar;

-(id)initWithUsernameEzin:(NSString *)username passWordEzin:(NSString *)password emailEzineRegister:(NSString *)email
            fullNameEzine:(NSString *)fullname andImageAvatar:(UIImage *)imgAvatar{
    if (self = [super init]) {
        self.usernameEzine = username;
        self.passwordEzine  = password;
        self.emailEzineRegister  = email;
        self.fullNameEzine =fullname;
        
        self.imgeAvatar =imgAvatar;
    }
    return self;    
    
}

-(void)dealloc{
    
    [super dealloc];
    [usernameEzine release];
    usernameEzine =nil;
    
    [passwordEzine release];
    passwordEzine =nil;
    
    [emailEzineRegister release];
    emailEzineRegister =nil;
    
    [fullNameEzine release];
    fullNameEzine =nil;

    [imgeAvatar release];
    imgeAvatar =nil;
}

@end
