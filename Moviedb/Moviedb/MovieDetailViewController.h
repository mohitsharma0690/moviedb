//
//  MovieDetailViewController.h
//  Moviedb
//
//  Created by mohit sharma on 11/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieInfo.h"

@interface MovieDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (retain, nonatomic) MovieInfo *movieData;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UITableView *movieDetailTableView;

@end
