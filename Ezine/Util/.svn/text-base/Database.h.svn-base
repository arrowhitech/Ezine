//
//  Database.h
//  Ezine
//
//  Created by MAC on 8/20/12.
//
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface Database : NSObject{
    
    sqlite3* database;

}
// coppy and open database

- (sqlite3 *) openDatabase;
+ (void) closeDatabase:(sqlite3 *)database;
+ (void) finalizeStatements;
- (void) setDatabasePath;
- (void) createEditableCopyOfDatabaseIfNeeded;

// for master Page
+ (NSMutableArray*) getAllSiteInMasterPage:(sqlite3 *)db;
+ (void) saveAllSiteToDataBase:(NSMutableArray *)arrayAllSite Indatabas:(sqlite3 *)db;
+ (void) deleteAllSite:(sqlite3 *)db;
@end
