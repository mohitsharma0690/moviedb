//
//  SearchDbViewController.m
//  Moviedb
//
//  Created by mohit sharma on 10/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SearchDbViewController.h"
#import "MoviedbAppDelegate.h"
#import "MovieInfo.h"
#import "MoviedetailViewController.h"

@interface SearchDbViewController ()

@end

@implementation SearchDbViewController
@synthesize movieDbTableView = _movieDbTableView;
@synthesize movieName = _movieName;

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
    appDelegate = (MoviedbAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSLog(@"viewDidLoad for SearchDbViewController %@",[appDelegate description]);
    self.title = @"Your Movie Collection";
    // need to check
}

- (void)viewDidUnload
{
    [self setMovieDbTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void) viewDidAppear:(BOOL) animated {
    [super viewDidAppear:animated];
    [self.movieDbTableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

# pragma mark - Table view data source
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [appDelegate.movieArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"SearchCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if([appDelegate.movieArray count] > indexPath.row) {
        NSLog(@"displayed name : %@",[[appDelegate.movieArray objectAtIndex:indexPath.row] name]);
        cell.textLabel.text = [[appDelegate.movieArray objectAtIndex:indexPath.row] name];
    } else {
        NSLog(@"displayed name : n/a");
        cell.textLabel.text = @"n/a";
    }
    return cell;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"showMovieDetail"]) {
        NSIndexPath *indexPath = [self.movieDbTableView indexPathForSelectedRow];
        MovieDetailViewController *destViewController = segue.destinationViewController;
        destViewController.movieData = [appDelegate.movieArray objectAtIndex:indexPath.row];
        NSLog(@"name : %@",[destViewController.movieData name]);
        NSLog(@"rating : %@",[destViewController.movieData rating]);
    }
}
- (void)dealloc {
    [_movieDbTableView release];
    [_movieName release];
    [super dealloc];
}
@end
