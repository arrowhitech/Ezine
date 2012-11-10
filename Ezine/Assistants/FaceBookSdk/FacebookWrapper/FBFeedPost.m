//
//  FBFeedPost.m
//  Facebook Demo
//
//  Created by Andy Yanok on 3/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FBFeedPost.h"
#import "FacebookListAccountViewController.h"

@implementation FBFeedPost

@synthesize message, caption, image, url, postType, delegate,name;
@synthesize lastTimePost,lastTimeStatus ;

- (id) initWithLinkPath:(NSString*) _url caption:(NSString*) _caption {
	self = [super init];
	if (self) {
		postType = FBPostTypeLink;
		url = [_url retain];
		caption = [_caption retain];
	}
	return self;
}

- (id) initWithPostMessage:(NSString*) _message {
	self = [super init];
	if (self) {
		postType = FBPostTypeStatus;
		message = [_message retain];
	}
	return self;
}

-(id)initWithCreateNewAlbum:(NSString *)_name{
    self = [super init];
	if (self) {
        postType = FBPostTypeNewAlbum;
		name=_name;
        message=@"";
	}
	return self;
}

- (id) initWithPhoto:(UIImage*) _image name:(NSString*) _name {
	self = [super init];
	if (self) {
		postType = FBPostTypePhoto;
		image = [_image retain];
		caption = [_name retain];
	}
	return self;
}

- (id) initWithGetUserPermissions:(UIViewController *)view{
    self = [super init];
	if (self) {
		postType = kAPIGraphUserPermissions;
		//faceview=view;
	}
	return self;

}
//------ get feed facebook 
- (id) initWithGetUserFeed:(FacebookDetailViewController *)view withApi:(int)ApiGet{
    self = [super init];
	if (self) {
		postType = ApiGet;
		feedview=view;
	}
	return self;}
- (BOOL) fbhasLogin:(id) _delegate{
    self.delegate=_delegate;
    return [[FBRequestWrapper defaultManager] isLoggedIn];
}
- (void) publishPostWithDelegate:(id) _delegate {
	
	//store the delegate incase the user needs to login
	self.delegate = _delegate;
	
	// if the user is not currently logged in begin the session
	BOOL loggedIn = [[FBRequestWrapper defaultManager] isLoggedIn];
    NSLog(@"logged in= %d",loggedIn);
	if (!loggedIn) {
		[[FBRequestWrapper defaultManager] FBSessionBegin:self];
	}
	else {
		//NSMutableDictionary *params = [[[NSMutableDictionary alloc] init] autorelease];
		
		//Need to provide POST parameters to the Facebook SDK for the specific post type
        NSMutableDictionary *params = [[[NSMutableDictionary alloc] init] autorelease];
		NSString *graphPath = @"me/feed";
		
		switch (postType) {
                
            case kAPIUSerNewFeedStatus:{
                NSString *queryStatus=[[NSString alloc] initWithFormat:@"SELECT actor_id, comments,likes,message, attachment, permalink, type ,created_time FROM stream WHERE filter_key in (SELECT filter_key FROM stream_filter WHERE uid=me() AND type='newsfeed') AND is_hidden = 0 AND type =46 AND created_time < %d LIMIT 50 ",lastTimeStatus];
                NSMutableDictionary *paramsStatus = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                queryStatus, @"query",
                                                nil];
                
                [[[FBRequestWrapper defaultManager] facebook] requestWithMethodName:@"fql.query"
                                                                          andParams:paramsStatus
                                                                      andHttpMethod:@"POST"
                                                                        andDelegate:_delegate];
            }
                break;
            case kAPIGraphUserPermissions:{
                NSMutableDictionary *params1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                @"SELECT pic,name,uid FROM user WHERE uid=me()", @"query",
                                                nil];
                
                [[[FBRequestWrapper defaultManager] facebook] requestWithMethodName:@"fql.query"
                                                                          andParams:params1
                                                                      andHttpMethod:@"POST"
                                                                        andDelegate:_delegate];
                break;
            }
            case FBPostTypeStatus:
            {
                [params setObject:@"status" forKey:@"type"];
				[params setObject:self.message forKey:@"message"];
				break;
            }
            case FBPostTypeLink:
			{
				[params setObject:@"link" forKey:@"type"];
				[params setObject:self.url forKey:@"link"];
				[params setObject:self.caption forKey:@"description"];
                [[FBRequestWrapper defaultManager] sendFBRequestWithGraphPath:graphPath params:params andDelegate:self.delegate];
				break;
			}
			case kAPIUSerNewFeed:
			{
                NSString *queryKey=[[NSString alloc] initWithFormat:@"SELECT actor_id ,comments,likes, message, attachment, permalink, type ,created_time FROM stream WHERE filter_key in (SELECT filter_key FROM stream_filter WHERE uid=me() AND type='newsfeed') AND is_hidden = 0 AND (type= 80 OR type = 128 OR type= 247) AND created_time < %d LIMIT 25 ",lastTimePost];
                NSMutableDictionary *params1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                queryKey, @"query",
                                                nil];
                
                [[[FBRequestWrapper defaultManager] facebook] requestWithMethodName:@"fql.query"
                                                                          andParams:params1
                                                                      andHttpMethod:@"POST"
                                                                        andDelegate:_delegate];  				break;
			}
			case kAPIUserImageWall:
			{
				graphPath=@"me/feed";
                [[[FBRequestWrapper defaultManager] facebook] requestWithGraphPath:graphPath andDelegate:feedview];
				break;
			}
			
            case kAPIUserImage:{
                graphPath=@"me/photos";
                [[[FBRequestWrapper defaultManager] facebook] requestWithGraphPath:graphPath andDelegate:feedview];
                break;
            
            }
            case kAPIGroup:   {
                graphPath=@"me/groups";
                [[[FBRequestWrapper defaultManager] facebook] requestWithGraphPath:graphPath andDelegate:feedview];
                break;
            } 
            case kAPIUserFriendsList:{
                graphPath=@"me/friends";
                [[[FBRequestWrapper defaultManager] facebook] requestWithGraphPath:graphPath andDelegate:feedview];
                break;
            }
            case kAPIGraphMe:
                graphPath=@"me";
                break;
			default:
				break;
		}
       // [[FBRequestWrapper defaultManager] getFBRequestWithGraphPath:graphPath andDelegate:self];
        
	}	
}

-(void)createNewAlbumWithDelegate:(id)_delegate albumName:(NSString *)name{
    //store the delegate incase the user needs to login
	self.delegate = _delegate;
	
	// if the user is not currently logged in begin the session
	BOOL loggedIn = [[FBRequestWrapper defaultManager] isLoggedIn];
	if (!loggedIn) {
		[[FBRequestWrapper defaultManager] FBSessionBegin:self];
	}
	else {
		NSMutableDictionary *params = [[[NSMutableDictionary alloc] init] autorelease];
		
		//Need to provide POST parameters to the Facebook SDK for the specific post type
		NSString *graphPath = @"me/albums";
		
		[params setObject:@"Test Create new album 50" forKey:@"name"];
        [params setObject:@"olala" forKey:@"message"];
		
		[[FBRequestWrapper defaultManager] sendFBRequestWithGraphPath:graphPath params:params andDelegate:self];
	}	


}

#pragma mark -
#pragma mark FacebookSessionDelegate

- (void)fbDidLogin {
    NSLog(@"Vao khong de bao ne");
	[[FBRequestWrapper defaultManager] setIsLoggedIn:YES];
	
	//after the user is logged in try to publish the post
	[self publishPostWithDelegate:self.delegate];
    
}

- (void)fbDidNotLogin:(BOOL)cancelled {
	[[FBRequestWrapper defaultManager] setIsLoggedIn:NO];
    if (self.delegate) {
        [delegate cancelFacebook];
    }
	
}

#pragma mark -
#pragma mark FBRequestDelegate

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	NSLog(@"ResponseFailed: %@", error);
	
	if ([self.delegate respondsToSelector:@selector(failedToPublishPost:)])
		[self.delegate failedToPublishPost:self];
}

- (void)request:(FBRequest *)request didLoad:(id)result {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	NSLog(@"Parsed Response FBRequest: %@", result);
    
 
}



- (void) dealloc {
	self.delegate = nil;
	[url release], url = nil;
	[message release], message = nil;
	[caption release], caption = nil;
	[image release], image = nil;
    [name release], name=nil;
	[super dealloc];
}

@end
