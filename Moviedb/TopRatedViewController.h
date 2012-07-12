//
//  TopRatedViewController.h
//  Moviedb
//
//  Created by mohit sharma on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieInfo.h"

@interface TopRatedViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate> {
    MoviedbAppDelegate *appDelegate;
}
@property (retain, nonatomic) NSMutableArray *sortedMovies;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
- (void) showMessage:(NSString *)msg;
@end
