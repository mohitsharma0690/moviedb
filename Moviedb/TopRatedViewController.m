//
//  TopRatedViewController.m
//  Moviedb
//
//  Created by mohit sharma on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TopRatedViewController.h"
#import "MovieInfo.h"
#import "WebViewController.h"

@interface TopRatedViewController ()

@end

@implementation TopRatedViewController
@synthesize sortedMovies = _sortedMovies;
@synthesize tableView = _tableView;


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
    self.title = @"Favorites";
    appDelegate = [[UIApplication sharedApplication] delegate];
    NSSortDescriptor *sortDesc = [[[NSSortDescriptor alloc] initWithKey:@"userRating" ascending:NO] autorelease];
    NSArray *sortDescs = [NSArray arrayWithObject:sortDesc];
    self.sortedMovies = [NSMutableArray arrayWithArray:[appDelegate.movieArray sortedArrayUsingDescriptors:sortDescs]];    
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc] initWithKey:@"userRating" ascending:NO];
    NSArray *sortDescs = [NSArray arrayWithObject:sortDesc];
    self.sortedMovies = [NSMutableArray arrayWithArray:[appDelegate.movieArray sortedArrayUsingDescriptors:sortDescs]];
    [self.tableView reloadData];
    [sortDesc release];
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sortedMovies count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"TopMovieCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell.textLabel.text = [[self.sortedMovies objectAtIndex:indexPath.row] name];
    if([[[self.sortedMovies objectAtIndex:indexPath.row] userRating] intValue] == 3) {
        cell.detailTextLabel.text = @"AWESOME";
    } else if([[[self.sortedMovies objectAtIndex:indexPath.row] userRating] intValue] == 2) {
        cell.detailTextLabel.text = @"So So ..";
    } else {
        cell.detailTextLabel.text = @"Sucks";
    }
    return cell;    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"topMovieDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        WebViewController *destViewController = [segue destinationViewController];
        destViewController.imdbId = [[self.sortedMovies objectAtIndex:indexPath.row] imdbId];
        destViewController.name = [[self.sortedMovies objectAtIndex:indexPath.row] name];
    }
}

- (void)dealloc {
    [_tableView release];
    [_sortedMovies release];
    [super dealloc];
}

@end
