//
//  MovidbAppDelegate.h
//  Moviedb
//
//  Created by mohit sharma on 10/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoviedbAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (retain, nonatomic) NSMutableArray *movieArray;

- (void) copyDatabaseIfNeeded;
- (NSString *) getDBPath;

@end
