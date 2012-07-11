//
//  MovieInfo.h
//  Moviedb
//
//  Created by mohit sharma on 10/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieInfo : NSObject
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *imdbId;
@property (copy, nonatomic) NSNumber *year;
@property (copy, nonatomic) NSNumber *rating;
- (id) initMovieInforWithName:(NSString *) name 
                   withImdbID:(NSString *) imdbId
                     withYear:(NSNumber *) year
                   withRating:(NSNumber *) rating;

- (id) initMovieWithName:(NSString *) name;

+ (void) getInitialDataToDisplay:(NSString *) dbPath;
+ (void) finalizeStatements;

@end
