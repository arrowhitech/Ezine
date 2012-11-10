//
//  CreateUserEngine.h
//  Ezine
//
//  Created by MAC on 8/13/12.
//
//

#import "MKNetworkEngine.h"

@interface CreateUserEngine : MKNetworkEngine
typedef void (^ CreateUser)(NSDictionary *finishCreate);

-(MKNetworkOperation*) CreateUserWithUSerName:(NSString*) UserName Password:(NSString *)password FullName:(NSString *)fullname Email:(NSString *)email AvatarFileName:(NSString *)avatarName AvatarBase64Code:(NSString *)avatarBase64Code
                              onCompletion:( CreateUser) completionBlock
                                   onError:(MKNKErrorBlock) errorBlock;

@end
