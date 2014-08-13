//
//  MDItemDetailsViewController.m
//  MDItems
//
//  Created by Dickman, Mike on 7/2/14.
//  Copyright (c) 2014 Dickman, Mike. All rights reserved.
//

#import "MDItemDetailsViewController.h"
#import "MDItemPropertyTableViewCell.h"
#import "MDItem.h"
#import "MDWeapon.h"
#import "MDArmor.h"
#import "UIColor+ItemColors.h"
#import "MDSharedPlayerData.h"
#import "MDPlayer.h"

@interface MDItemDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIView *propertiesContainerView;
@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *statLabel;
@property (weak, nonatomic) IBOutlet UILabel *sellsForLabel;

@end

@implementation MDItemDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self refreshUI];
    
    // No interaction (identify/equip) will happen if we came from the victory view, only from the inventory view
    if (self.allowInteraction) {
        
        if (self.item.hasBeenIdentified) {
            [self createEquipButton];
        } else {
            [self createIdentifyButton];
        }
    }
}

#pragma mark - Helpers

-(void)refreshUI {
    
    self.nameLabel.text = [self.item fullName];
    self.nameLabel.textColor = [UIColor colorForItem:self.item];
    self.statLabel.text = [self.item statDescription];
    self.itemImageView.layer.magnificationFilter = kCAFilterNearest; // Prevents blurry edges when scaling pixel art
    self.itemImageView.image = [self.item imageToDisplay];
    self.sellsForLabel.text = [NSString stringWithFormat:@"Sells for %dg", self.item.sellingPrice];
    
    // Hide the properties table only if the item has none or it hasn't been identified
    if (!self.item.hasBeenIdentified) {
        self.propertiesContainerView.hidden = YES;
    } else {
        self.propertiesContainerView.hidden = NO;
    }
}

-(void)createIdentifyButton {
    
    // Add a button to the navigation bar to equip items
    UIBarButtonItem *identifyButton = [[UIBarButtonItem alloc] initWithTitle:@"Identify"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(identifyPressed:)];
    self.navigationItem.rightBarButtonItem = identifyButton;
}

-(void)createEquipButton {

    // The button will either equip or remove an item, based on whether or not it's currently equipped
    SEL selector;
    NSString *buttonTitle;
    
    if ([[MDSharedPlayerData sharedPlayerData] isItemEquipped:self.item]) {
        selector = @selector(unequipPressed);
        buttonTitle = @"Unequip";
    } else {
        selector = @selector(equipPressed);
        buttonTitle = @"Equip";
    }
    
    // Add a button to the navigation bar to equip items
    UIBarButtonItem *equipButton = [[UIBarButtonItem alloc] initWithTitle:buttonTitle
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:selector];
    self.navigationItem.rightBarButtonItem = equipButton;
}

#pragma mark - Actions

-(void)equipPressed{

    MDSharedPlayerData *playerData = [MDSharedPlayerData sharedPlayerData];
    
    // Set the item to the shared player instance's relevant item slot
    if ([self.item isKindOfClass:[MDWeapon class]]) {
        [playerData equipWeapon:(MDWeapon*)self.item];
    } else if ([self.item isKindOfClass:[MDArmor class]]) {
        [playerData equipArmor:(MDArmor*)self.item];
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)unequipPressed {
    
    MDSharedPlayerData *playerData = [MDSharedPlayerData sharedPlayerData];
    
    // Set the relevant item slot to nil
    if ([self.item isKindOfClass:[MDWeapon class]]) {
        [playerData unequipWeapon:(MDWeapon*)self.item];
    } else if ([self.item isKindOfClass:[MDArmor class]]) {
        [playerData unequipArmor:(MDArmor*)self.item];
    }

    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)identifyPressed:(UIBarButtonItem*)button {
    
    self.item.hasBeenIdentified = YES;
    
    // Refresh the relevant UI elements
    [self refreshUI];
    
    // Change identify button into an equip button
    self.navigationItem.rightBarButtonItem = nil;
    [self createEquipButton];
    
}

#pragma mark - Table View Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.item.modifierDescriptions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Set the cells to show the item property descriptions
    MDItemPropertyTableViewCell *cell = (MDItemPropertyTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"PropertyCell" forIndexPath:indexPath];
    cell.descriptionLabel.text = self.item.modifierDescriptions[indexPath.row];
    
    return cell;
}

@end
