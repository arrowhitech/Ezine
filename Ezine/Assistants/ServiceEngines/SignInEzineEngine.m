//
//  SignInEzineEngine.m
//  Ezine
//
//  Created by MAC on 8/14/12.
//
//

#import "SignInEzineEngine.h"

@implementation SignInEzineEngine
-(MKNetworkOperation*) SignInEzineUSerName:(NSString*) UserName Password:(NSString *)password onCompletion:( SignInEzine) completionBlock
                                   onError:(MKNKErrorBlock) errorBlock{
    MKNetworkOperation *op = [self operationWithPath:@"user/Authentication"
                                              params:[NSDictionary dictionaryWithObjectsAndKeys:
                                                      UserName, @"UserName",
                                                      password, @"Password",
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
