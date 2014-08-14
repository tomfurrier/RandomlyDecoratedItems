//
//  MDMainTableViewController.m
//  MDItems
//
//  Created by Dickman, Mike on 7/1/14.
//  Copyright (c) 2014 Dickman, Mike. All rights reserved.
//

#import "MDInventoryTableViewController.h"
#import "MDItemTableViewCell.h"
#import "MDItemDetailsViewController.h"
#import "MDItemFactory.h"
#import "MDItem.h"
#import "MDWeapon.h"
#import "UIColor+ItemColors.h"
#import "MDPlayer.h"

@interface MDInventoryTableViewController ()

@property (nonatomic, strong) NSIndexPath *lastSelectedIndexPath;

@end

@implementation MDInventoryTableViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

#pragma mark - Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MDItemTableViewCell *cell = (MDItemTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
    
    MDItem *item = self.items[indexPath.row];
    cell.itemImageView.layer.magnificationFilter = kCAFilterNearest; // Prevents blurry edges when scaling pixel art
    cell.itemImageView.image = [item imageToDisplay];
    cell.nameLabel.text = [item fullName];
    cell.nameLabel.textColor = [UIColor colorForItem:item];
    cell.statLabel.text = [item statDescription];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 61;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Keep track of this to get the respective item in prepareForSegue:
    self.lastSelectedIndexPath = indexPath;
    
    // When a row is tapped, we'll segue to a view that shows more detail about the item at indexPath.row
    [self performSegueWithIdentifier:@"SegueToDetailsFromInventory" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"SegueToDetailsFromInventory"]) {
        MDItemDetailsViewController *detailsVC = (MDItemDetailsViewController*)segue.destinationViewController;
        detailsVC.allowInteraction = YES;
        detailsVC.item = self.items[self.lastSelectedIndexPath.row];
    }
}


@end
