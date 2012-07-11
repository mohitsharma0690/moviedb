//
//  MovieInfoDatabase.h
//  Moviedb
//
//  Created by mohit sharma on 10/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface MovieInfoDatabase : NSObject {
    sqlite3 *_database;
}
+ (MovieInfoDatabase *) database;
- (NSArray *) movieNames;

@end
