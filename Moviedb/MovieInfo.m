//
//  MovieInfo.m
//  Moviedb
//
//  Created by mohit sharma on 10/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MovieInfo.h"
#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "MoviedbAppDelegate.h"

static sqlite3 *database = nil;
static sqlite3_stmt *addStmt = nil;

@implementation MovieInfo
@synthesize name = _name;
@synthesize imdbId = _imdbId;
@synthesize year = _year;
@synthesize rating = _rating;
@synthesize country = _country;
@synthesize language = _language;
@synthesize userRating = _userRating;
@synthesize blurp = _blurp;
@synthesize genre = _genre;


- (id) initMovieInforWithName:(NSString *)name withImdbID:(NSString *)imdbId withYear:(NSNumber *)year withRating:(NSNumber *)rating {
    self = [super init];
    if(self) {
        self.name = name;
        self.imdbId =  imdbId;
        self.year = year;
        self.rating = rating;
    }
    return self;
}

- (id) initMovieWithImdbId:(NSString *)imdbId withName:(NSString *)name withRating:(NSNumber *)rating withYear:(NSNumber *)year withCountry:(NSString *)country withLanguage:(NSString *)language withUserRating:(NSNumber *)userRating withBlurp:(NSString *)blurp withGenre:(NSString *)genre {
    self = [super init];
    if(self) {
        self.imdbId = imdbId;
        self.name = name;
        self.rating = rating;
        self.year = year;
        self.country = country;
        self.language = language;
        self.userRating = userRating;
        self.blurp = blurp;
        self.genre = genre;
    }
    return self;
}

- (id) initMovieWithName:(NSString *)name {
    self = [super init];
    if(self) {
        self.name = name;
        
    }
    return self;
}
- (id) initMovieWithDict:(NSDictionary *)dict {
    self = [super init];
    if(self) {
        self.imdbId = [dict objectForKey:@"imdbid"];
        self.name = [dict objectForKey:@"title"];
        self.rating = [dict objectForKey:@"rating"];
        self.year = [dict objectForKey:@"year"];
        self.country = [dict objectForKey:@"country"];
        self.language = [dict objectForKey:@"languages"];
        self.userRating = [dict objectForKey:@"userRating"];
        self.blurp = @"some blurp";
        self.genre = [dict objectForKey:@"genres"];
    }
    return self;
}

- (void) addMovie {
    if(addStmt == nil) {
        // imdbID, name, rating, year, country, language, userRating, blurp, genre
        const char *sql = "insert into userData values(?,?,?,?,?,?,?,?,?)";
        if(sqlite3_prepare_v2(database, sql, -1, &addStmt, NULL) != SQLITE_OK) {
            NSLog(@"Error while creating add statment");
            sqlite3_errmsg(database);
        }
    }
    sqlite3_bind_text(addStmt, 1, [self.imdbId UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(addStmt, 2, [self.name UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_double(addStmt, 3, [self.rating doubleValue]);
    sqlite3_bind_int(addStmt, 4, [self.year intValue]);
    sqlite3_bind_text(addStmt, 5, [self.country UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(addStmt, 6, [self.language UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_int(addStmt, 7, [self.userRating intValue]);
    sqlite3_bind_text(addStmt, 8, [self.blurp UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(addStmt, 9, [self.genre UTF8String], -1, SQLITE_TRANSIENT);
    if(sqlite3_step(addStmt) != SQLITE_DONE) {
        NSLog(@"Error while inserting data");
        NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
    }
    sqlite3_reset(addStmt);
}

+ (void) getInitialDataToDisplay: (NSString *) dbPath {
    NSLog(@"in getInitialDataToDisplay");
    MoviedbAppDelegate *appDelegate = (MoviedbAppDelegate *) [[UIApplication sharedApplication] delegate];
    if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        const char *sql = "select name from userData";
        sqlite3_stmt *selectStmt;
        if(sqlite3_prepare_v2(database, sql, -1, &selectStmt, NULL) == SQLITE_OK) {
            NSLog(@"The query seems to be ok");
            while(sqlite3_step(selectStmt) == SQLITE_ROW) {
                char *name = (char *) sqlite3_column_text(selectStmt, 0);
                NSLog(@"we got a row ");
                printf("name : %s\n",name);
                NSString *movieName = [NSString stringWithUTF8String:name];
                MovieInfo *movieInfoObj = [[MovieInfo alloc] initMovieWithName:movieName];
                [appDelegate.movieArray addObject:movieInfoObj];
                
                [movieInfoObj release];
            }
        }
    } else {
        sqlite3_close(database);
    }
}

+ (void) finalizeStatements {
    if(database) {
        sqlite3_close(database);
    }
    if(addStmt) {
        sqlite3_finalize(addStmt);
    }
}

- (void) dealloc {
    [_name release];
    [_imdbId release];
    [_year release];
    [_rating release];
    [_country release];
    [_language release];
    [_userRating release];
    [_blurp release];
    [_genre release];
    [super dealloc];
}

@end
