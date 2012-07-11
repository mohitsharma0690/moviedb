//
//  MovieInfoDatabase.m
//  Moviedb
//
//  Created by mohit sharma on 10/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "MovieInfoDatabase.h"

@implementation MovieInfoDatabase

static MovieInfoDatabase *_database;

+ (MovieInfoDatabase *) database {
    if(_database == nil) {
        _database = [[MovieInfoDatabase alloc] init];
    }
    return _database;
}

- (id) init {
    self = [super init];
    if(self) {
        NSString *sqLiteDb = [[NSBundle mainBundle] pathForResource:@"moviedb" ofType:@"sqlite"];
        if(sqlite3_open([sqLiteDb UTF8String], &(_database)) != SQLITE_OK) {
            NSLog(@"Failed to open database");
        }
    }
    return self;
}

- (NSArray *) movieNames {
    NSMutableArray *retVal = [[[NSMutableArray alloc] init] autorelease];
    NSString *query = @"SELECT imdbId, name, rating, country, year FROM userData";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while(sqlite3_step(statement) == SQLITE_ROW) {
        char *imdbId = (char *) sqlite3_column_text(statement, 0);
        char *name = (char *) sqlite3_column_text(statement, 1);
        printf("imdbID : %s name : %s\n",imdbId, name);
        }
        sqlite3_finalize(statement);
    }
    return nil;
}

- (void) dealloc {
    sqlite3_close(_database);
    [super dealloc];
}

@end
