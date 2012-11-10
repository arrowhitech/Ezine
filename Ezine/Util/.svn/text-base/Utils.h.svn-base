//
//  Utils.h
//  Taksee
//
//  Created by Created by Lemonadestand.com.au on 2/11/09.
//  Copyright 2009 zxZX. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "EzineAppDelegate.h"
#import <CommonCrypto/CommonDigest.h>


@interface Utils : NSObject {
	
	
}
+(EzineAppDelegate*)appDelegate;
+(NSString*)stringFromFileNamed:(NSString*)name;
+(NSString*)getAppVersion;
+(UIColor*)colorFromDict:(NSDictionary*)dict;
+(NSString*)appDocDir;
+ (NSString *) getMD5Sum:(NSString *)str;
+(void)showSubViewWithNameNoAnimation:(NSString*)name withDelegate:(id)delegate;
+(void)showSubViewWithName:(NSString*)name withDelegate:(id)delegate;
+(float)calculateHeightOfMultipleLineText:(NSString*)text withFont:(UIFont*)font withWidth:(float)width;
+(void)alertMessage:(NSString*)msg;
+(void)alertMessage:(NSString*)msg withSecondButtonTitle:(NSString*)title delegate:(id)delegate;
+(NSDateComponents*)getCurrentDateComponent;
+(NSString*)getCurrentDate;
+(NSString*)toSlashDate:(NSString*)date;
+(NSString*)dateStringFromTimestamp:(NSString*)timestamp;
// time from int
+(NSString*)dateStringFromTimeNumber:(int)timestamp;
+(void) handleError:(NSError*)error;
@end
