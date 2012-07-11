//
//  MovieInfo.h
//  Moviedb
//
//  Created by mohit sharma on 10/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieInfo : NSObject
@property (copy, nonatomic) NSString *imdbId;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSNumber *rating;
@property (copy, nonatomic) NSNumber *year;
@property (copy, nonatomic) NSString *country;
@property (copy, nonatomic) NSString *language;
@property (copy, nonatomic) NSNumber *userRating;
@property (copy, nonatomic) NSString *blurp;
@property (copy, nonatomic) NSString *genre;

- (id) initMovieInforWithName:(NSString *) name 
                   withImdbID:(NSString *) imdbId
                     withYear:(NSNumber *) year
                   withRating:(NSNumber *) rating;

- (id) initMovieWithImdbId: (NSString *) imdbId
                 withName : (NSString *) name
               withRating : (NSNumber *) rating
                 withYear : (NSNumber *) year
              withCountry : (NSString *) country
             withLanguage : (NSString *) language
           withUserRating : (NSNumber *) userRating
                withBlurp : (NSString *) blurp
                withGenre : (NSString *) genre;

- (id) initMovieWithDict : (NSDictionary *) dict;
- (id) initMovieWithName:(NSString *) name;
- (void) addMovie;

+ (void) getInitialDataToDisplay:(NSString *) dbPath;
+ (void) finalizeStatements;

@end
