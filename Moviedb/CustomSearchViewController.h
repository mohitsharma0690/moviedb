//
//  CustomSearchViewController.h
//  Moviedb
//
//  Created by mohit sharma on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomSearchViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDataSource, UITableViewDelegate , UIAlertViewDelegate>
@property (retain, nonatomic) IBOutlet UIPickerView *pickerView;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) NSMutableArray *movieData;
@property NSInteger selectedRow;

- (void) performSortBasedOnRow:(NSInteger) row;
- (void) showMessage:(NSString *)msg;

@end
