//
//  Database.m
//  Ezine
//
//  Created by MAC on 8/20/12.
//
//

#import "Database.h"
#import "Utils.h"
#import "SiteObject.h"

static sqlite3_stmt *query_statement1 = nil;
static sqlite3_stmt *query_statement2 = nil;
static sqlite3_stmt *query_statement3 = nil;
static sqlite3_stmt *query_statement4 = nil;
static sqlite3_stmt *query_statement5 = nil;
static sqlite3_stmt *query_statement6 = nil;
static sqlite3_stmt *query_statement7 = nil;

static NSString *DATABASE_PATH = nil;
NSString *DATABASE_NAME=@"data.db";


@implementation Database


// Open the database connection
- (sqlite3 *)openDatabase {
	
	
    // Open the database. The database was prepared outside the application.
    if (sqlite3_open([DATABASE_PATH UTF8String], &database) == SQLITE_OK) {
		return database;
        
    } else {
        // Even though the open failed, call close to properly clean up resources.
        sqlite3_close(database);
        NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
        // Additional error handling, as appropriate...
		return nil;
    }
}

+ (void)closeDatabase:(sqlite3 *)database{
    [Database finalizeStatements];
    // Close the database.
    if (sqlite3_close(database) != SQLITE_OK) {
        NSAssert1(0, @"Error: failed to close database with message '%s'.", sqlite3_errmsg(database));
    }
}

// Finalize (delete) all of the SQLite compiled queries.
+ (void)finalizeStatements {
	if (query_statement1) sqlite3_finalize(query_statement1);
	if (query_statement2) sqlite3_finalize(query_statement2);
	if (query_statement3) sqlite3_finalize(query_statement3);
	if (query_statement4) sqlite3_finalize(query_statement4);
	if (query_statement5) sqlite3_finalize(query_statement5);
	if (query_statement6) sqlite3_finalize(query_statement6);
	if (query_statement7) sqlite3_finalize(query_statement7);
	
}

- (void)setDatabasePath {
	NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DATABASE_NAME];
    DATABASE_PATH = [defaultDBPath copy];
}


// Creates a writable copy of the bundled default database in the application Documents directory.
- (void)createEditableCopyOfDatabaseIfNeeded {
    // First, test for existence.
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:DATABASE_NAME];
	if(!DATABASE_PATH)
		DATABASE_PATH = [writableDBPath copy];
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success) return;
    // The writable database does not exist, so copy the default to the appropriate location.
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DATABASE_NAME];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success) {
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}

#pragma mark--------
#pragma mark--- get all site in master page
+ (NSMutableArray*) getAllSiteInMasterPage:(sqlite3 *)db{
    sqlite3* database = db;
	sqlite3_stmt * statement = query_statement5;
	if (statement == nil) {
		static char *sql = "select ID,SiteName,SiteID from MasterPage";
		if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) != SQLITE_OK) {
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}
	}
	
	//declare the array of items
	NSMutableArray *items;
	items = [[NSMutableArray alloc] init];
	
	SiteObject* item = nil;
	while(sqlite3_step(statement) == SQLITE_ROW) {
		item = [[SiteObject alloc] init];
		item._id = sqlite3_column_int(statement, 0);
		item._title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)] ;
        item._siteID=sqlite3_column_int(statement, 2);
		// Add the object to the items Array
		[items addObject:item];
		[item autorelease];
	}
	sqlite3_reset(statement);
	[items autorelease];
	return items;
}

+ (void) saveAllSiteToDataBase:(NSMutableArray *)arrayAllSite Indatabas:(sqlite3 *)db{
    sqlite3* databaseHandle = db;
    int i=1;
    for (SiteObject *siteObject in arrayAllSite) {

        NSString *insertStatement = [NSString stringWithFormat:@"INSERT INTO MasterPage (ID, SiteName, SiteID) VALUES (\"%d\", \"%@\", \"%d\")", i, siteObject._title, siteObject._siteID];
        
        char *error;
        if ( sqlite3_exec(databaseHandle, [insertStatement UTF8String], NULL, NULL, &error) == SQLITE_OK)
        {
           
        }
        else
        {
            NSLog(@"Error: %s", error);
        }

        i++;
    }
    
}

+ (void) deleteAllSite:(sqlite3 *)db{
    NSLog(@"delete all site");
    
    sqlite3* database = db;
    //declare the array of items
    sqlite3_stmt * statement = query_statement5;
	if (statement == nil){
        NSString *deleteSQL = [NSString stringWithFormat:@"DELETE FROM MasterPage" ];
        
        char *errorMsg;
        
        if (database == nil) {
            NSLog(@"ERROR db not initialized but trying to delete record!!!");
        }else{
            if (sqlite3_exec(database, [deleteSQL UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK){
                NSAssert1(0, @"Error updating tables: %s", errorMsg);
                sqlite3_free(errorMsg);
            }
        }

    }
       sqlite3_finalize(statement);
}
@end
