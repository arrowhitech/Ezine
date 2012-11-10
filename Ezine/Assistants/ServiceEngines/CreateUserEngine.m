//
//  CreateUserEngine.m
//  Ezine
//
//  Created by MAC on 8/13/12.
//
//

#import "CreateUserEngine.h"

@implementation CreateUserEngine
-(MKNetworkOperation*) CreateUserWithUSerName:(NSString*) UserName Password:(NSString *)password FullName:(NSString *)fullname Email:(NSString *)email AvatarFileName:(NSString *)avatarName AvatarBase64Code:(NSString *)avatarBase64Code
                                 onCompletion:( CreateUser) completionBlock
                                      onError:(MKNKErrorBlock) errorBlock{
    
    MKNetworkOperation *op = [self operationWithPath:@"user/CreateUser"
                                              params:[NSDictionary dictionaryWithObjectsAndKeys:
                                                      UserName, @"UserName",
                                                      password, @"Password",
                                                      fullname, @"FullName",
                                                      email, @"Email",
                                                      @"image/jpeg", @"AvatarContentType",
                                                      avatarName, @"AvatarFileName",
                                                      avatarBase64Code, @"AvatarBase64Code",

                                                      nil]
                                          httpMethod:@"POST"];
    
    
    // setFreezable uploads your images after connection is restored!
    [op setFreezable:YES];
    
    [op onCompletion:^(MKNetworkOperation* completedOperation) {
        
        completionBlock([completedOperation responseJSON]);
            
        }
             onError:^(NSError* error) {
                 
                 errorBlock(error);
             }];
    
    [self enqueueOperation:op];
    
    
    return op;

}


@end
