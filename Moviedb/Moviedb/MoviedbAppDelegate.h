//
//  MovidbAppDelegate.h
//  Moviedb
//
//  Created by mohit sharma on 10/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieInfo.h"

@interface MoviedbAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (retain, nonatomic) NSMutableArray *movieArray;
@property (retain, nonatomic) UITabBarController *tabController;
@property BOOL dbStatus;

- (BOOL) copyDatabaseIfNeeded;
- (NSString *) getDBPath;
- (BOOL) addMovie:(MovieInfo *) movieObj;

@end
