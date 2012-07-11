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

@implementation MovieInfo
@synthesize name = _name;
@synthesize imdbId = _imdbId;
@synthesize year = _year;
@synthesize rating = _rating;

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

- (id) initMovieWithName:(NSString *)name {
    self = [super init];
    if(self) {
        self.name = name;
        
    }
    return self;
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
}

- (void) dealloc {
    [_name release];
    [_imdbId release];
    [_year release];
    [_rating release];
    [super dealloc];
}

@end
