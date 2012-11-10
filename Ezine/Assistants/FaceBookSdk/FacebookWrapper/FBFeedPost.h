//
//  FBFeedPost.h
//  Facebook Demo
//
//  Created by Andy Yanok on 3/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBRequestWrapper.h"
#import "FacebookListAccountViewController.h"
#import "FacebookDetailViewController.h"

@class FacebookListAccountViewController;
@class FacebookDetailViewController;

@protocol FBFeedPostDelegate;


typedef enum {
    kAPIUSerNewFeed,
    kAPIUSerNewFeedStatus,
    kAPIUserImageWall,
    kAPIUserImage,
    KAPINewImage,
    kAPINewLink,
    kAPIGroup,
    kAPIPage,
    kAPIUserFriendsList,
    kAPIUserFriends,
    kAPIFriendsForTargetDialogRequests,
    kDialogRequestsSendToTarget,
    kDialogFeedUser,
    kAPIFriendsForDialogFeed,
    kDialogFeedFriend,
    kAPIGraphUserPermissions,
    kAPIGraphMe,
    kAPIGraphUserFriends,
    kDialogPermissionsCheckin,
    kDialogPermissionsCheckinForRecent,
    kDialogPermissionsCheckinForPlaces,
    kAPIGraphSearchPlace,
    kAPIGraphUserCheckins,
    kAPIGraphUserPhotosPost,
    kAPIGraphUserVideosPost,
  FBPostTypeStatus = 100,
  FBPostTypePhoto = 101,
  FBPostTypeLink = 102,
  FBPostTypeNewAlbum=103,
} FBPostType;

@interface FBFeedPost : NSObject <FBRequestDelegate, FBSessionDelegate>
{
	NSString *url;
	NSString *message;
	NSString *caption;
	UIImage *image;
    NSString *name;
	FBPostType postType;
	id <FBFeedPostDelegate> delegate;
    FacebookListAccountViewController *faceview;
    FacebookDetailViewController       *feedview; 
}

@property (nonatomic, assign) FBPostType postType;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *message;
@property (nonatomic, retain) NSString *caption;
@property (nonatomic, retain) UIImage *image;

@property (nonatomic, assign) id <FBFeedPostDelegate> delegate;
//==============================  time get new post
@property (nonatomic) int  lastTimeStatus;
@property (nonatomic) int  lastTimePost;

- (id) initWithLinkPath:(NSString*) _url caption:(NSString*) _caption;
- (id) initWithPostMessage:(NSString*) _message;
- (id) initWithCreateNewAlbum:(NSString*) _name;
- (id) initWithPhoto:(UIImage*) _image name:(NSString*) _name;
- (void) publishPostWithDelegate:(id) _delegate;
- (void) createNewAlbumWithDelegate:(id) _delegate albumName:(NSString*) name;
- (id) initWithGetUserPermissions:(UIViewController *)view;

- (id) initWithGetUserFeed:(FacebookDetailViewController *)view withApi:(int)ApiGet;
- (BOOL) fbhasLogin:(id) _delegate;
@end


@protocol FBFeedPostDelegate <NSObject>
@required
- (void) failedToPublishPost:(FBFeedPost*) _post;
- (void) finishedPublishingPost:(FBFeedPost*) _post;
-(void)cancelFacebook;
@end