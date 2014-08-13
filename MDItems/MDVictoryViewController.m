//
//  MDVictoryViewController.m
//  MDItems
//
//  Created by Dickman, Mike on 8/5/14.
//  Copyright (c) 2014 Dickman, Mike. All rights reserved.
//

#import "MDVictoryViewController.h"
#import "MDItemTableViewCell.h"
#import "MDItem.h"
#import "UIColor+ItemColors.h"
#import "MDSharedPlayerData.h"
#import "MDPlayer.h"
#import "MDItemDetailsViewController.h"

@interface MDVictoryViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSIndexPath *lastSelectedIndexPath;

@end

@implementation MDVictoryViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Return a tableView cell with UI elements set based on the item at indexPath.row
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

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    
    // Segue to the item details view if the info button on the row is tapped
    self.lastSelectedIndexPath = indexPath;
    [self performSegueWithIdentifier:@"SegueToItemDetails" sender:self];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Pick up the item when the item's row is tapped
    [[MDSharedPlayerData sharedPlayerData].player.inventoryItems insertObject:self.items[indexPath.row] atIndex:0];
    [self.items removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
}

#pragma mark - Actions

- (IBAction)donePressed {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"SegueToItemDetails"]) {
    
        // Interaction (identify/equip) won't be allowed in item details from the victory view (since the items are still on the "ground")
        MDItemDetailsViewController *detailsVC = (MDItemDetailsViewController*)segue.destinationViewController;
        detailsVC.allowInteraction = NO;
        detailsVC.item = self.items[self.lastSelectedIndexPath.row];
    }
}

@end
