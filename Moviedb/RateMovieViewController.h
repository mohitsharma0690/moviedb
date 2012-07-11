//
//  RateMovieViewController.h
//  Moviedb
//
//  Created by mohit sharma on 10/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RateMovieViewController : UIViewController <UITextFieldDelegate, UITableViewDataSource, UIAlertViewDelegate>
@property (retain, nonatomic) IBOutlet UITextField *movieNameTextField;
@property (retain, nonatomic) IBOutlet UITableView *movieDataTableView;
@property (retain, nonatomic) NSString *movieName;
@property (retain, nonatomic) id movieData;
- (IBAction) getRatingMessage:(id)sender;

-(id) getDataFromJSON;

@end
