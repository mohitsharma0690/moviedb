//
//  MovieDetailViewController.m
//  Moviedb
//
//  Created by mohit sharma on 11/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "MovieInfo.h"

@interface MovieDetailViewController ()

@end

@implementation MovieDetailViewController
@synthesize titleLabel = _titleLabel;
@synthesize movieDetailTableView = _movieDetailTableView;
@synthesize movieData = _movieData;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view.
    self.titleLabel.text = [self.movieData name];
}

- (void)viewDidUnload
{
    [self setTitleLabel:nil];
    [self setMovieDetailTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // movie name is declared earlier
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"MovieDetailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // configure the cell
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"IMDB id";
            cell.detailTextLabel.text = [self.movieData imdbId];
            break;
        case 1:
            cell.textLabel.text = @"Rating";
            cell.detailTextLabel.text = [[self.movieData rating] stringValue];
            break;
        case 2:
            cell.textLabel.text = @"Year";
            cell.detailTextLabel.text = [[self.movieData year] stringValue];
            break;
        case 3:
            cell.textLabel.text = @"Country";
            cell.detailTextLabel.text = [self.movieData country];
            break;
        case 4:
            cell.textLabel.text = @"Language";
            cell.detailTextLabel.text = [self.movieData language];
            break;
        case 5:
            cell.textLabel.text = @"Your Rating";
            cell.detailTextLabel.text = [[self.movieData userRating] stringValue];
            break;
        case 6:
            cell.textLabel.text = @"Genre";
            cell.detailTextLabel.text = [self.movieData genre];
            break;
        default:
            cell.textLabel.text = @"N/A";
            cell.detailTextLabel.text = @"N/A";
            break;
    }
    return cell;
}

- (void)dealloc {
    [_titleLabel release];
    [_movieDetailTableView release];
    [_movieData release];
    [super dealloc];
}
@end
