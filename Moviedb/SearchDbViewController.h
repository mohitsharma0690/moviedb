//
//  SearchDbViewController.h
//  Moviedb
//
//  Created by mohit sharma on 10/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoviedbAppDelegate.h"

@interface SearchDbViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate> {
    MoviedbAppDelegate *appDelegate;
}
@property (retain, nonatomic) IBOutlet UITableView *movieDbTableView;
@property (retain, nonatomic) NSString *movieName;

- (void) showErrorMessage:(NSString *)msg;

@end
