//
//  SignInEzineEngine.h
//  Ezine
//
//  Created by MAC on 8/14/12.
//
//

#import "MKNetworkEngine.h"

@interface SignInEzineEngine : MKNetworkEngine
typedef void (^ SignInEzine)(NSDictionary *finishCreate);

-(MKNetworkOperation*) SignInEzineUSerName:(NSString*) UserName Password:(NSString *)password onCompletion:( SignInEzine) completionBlock
                                      onError:(MKNKErrorBlock) errorBlock;
@end
