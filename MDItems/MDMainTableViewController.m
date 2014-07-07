//
//  MDMainTableViewController.m
//  MDItems
//
//  Created by Dickman, Mike on 7/1/14.
//  Copyright (c) 2014 Dickman, Mike. All rights reserved.
//

#import "MDMainTableViewController.h"
#import "MDItemTableViewCell.h"
#import "MDItemDetailsViewController.h"

@interface MDMainTableViewController ()

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSIndexPath *lastSelectedIndexPath;

@end

@implementation MDMainTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initialize an empty array
    self.items = [NSMutableArray array];
}

#pragma mark - Actions

- (IBAction)addItemPressed:(UIBarButtonItem *)sender {
    // Add a new item to self.items here, our array that will hold all generated items
}

#pragma mark - Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Keep track of this for transitioning to a new view
    self.lastSelectedIndexPath = indexPath;
    
    // Return a tableView cell with UI elements set based on the item at indexPath.row
    MDItemTableViewCell *cell = (MDItemTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // The height of each tableView cell's row
    return 61;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // When a row is tapped, we'll segue to a view that shows more detail about the item at indexPath.row
    [self performSegueWithIdentifier:@"SegueToItemDetails" sender:self];
}


@end
