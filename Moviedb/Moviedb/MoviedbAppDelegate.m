//
//  MovidbAppDelegate.m
//  Moviedb
//
//  Created by mohit sharma on 10/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MoviedbAppDelegate.h"
#import "MovieInfo.h"

@implementation MoviedbAppDelegate

@synthesize window = _window;
@synthesize movieArray = _movieArray;
@synthesize tabController = _tabController;
@synthesize dbStatus = _dbStatus;

- (NSString *) getDBPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    NSLog(@"getDBPath is %@",[documentsDir stringByAppendingFormat:@"/moviedb.sqlite"]);
    return [documentsDir stringByAppendingFormat:@"/moviedb.sqlite"];
}

- (BOOL) copyDatabaseIfNeeded {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSString *dbPath = [self getDBPath];
    BOOL succ = [fileManager fileExistsAtPath:dbPath];
    if(!succ) {
        NSLog(@"File didn't exist going to copy");
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"moviedb.sqlite"];
        succ = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
        if(!succ) {
            NSLog(@"Failed to create writable database file");
            //NSAssert1(0, @"Failed to create writable database file with message '%@'",[error localizedDescription]);
        }
    }
    return succ;
}

- (BOOL) addMovie:(MovieInfo *)movieObj {
    // change genre, language of movieObj to primary genre
    // [movieObj setGenre:[[[movieObj genre] componentsSeparatedByString:@","] objectAtIndex:0]];
    // [movieObj setLanguage:[[[movieObj language] componentsSeparatedByString:@","] objectAtIndex:0]];
    
    // add to database
    BOOL status = [movieObj addMovie];
    // add to array
    if(status) {
        [self.movieArray addObject:movieObj];
    }
    return status;
}

- (void)dealloc
{
    [_window release];
    [_movieArray release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"in application:didFinishLaunching...");
    // copy database to user's phone if needed
    self.dbStatus = [self copyDatabaseIfNeeded];
    
    // initialize movieInfo Array
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    _movieArray = [temp retain];
    
    [temp release];
    // Once db is copied get Initial Data on Screen
    [MovieInfo getInitialDataToDisplay:[self getDBPath]];
    //NSLog(@"rating : %@",[[self.movieArray objectAtIndex:0] rating]);
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
