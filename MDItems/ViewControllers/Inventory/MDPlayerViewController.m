//
//  MDPlayerViewController.m
//  MDItems
//
//  Created by Dickman, Mike on 8/11/14.
//  Copyright (c) 2014 Dickman, Mike. All rights reserved.
//

#import "MDPlayerViewController.h"
#import "MDSharedPlayerData.h"
#import "MDPlayer.h"
#import "MDItem.h"
#import "MDArmor.h"
#import "MDWeapon.h"
#import "MDInventoryTableViewController.h"

@interface MDPlayerViewController () <UITabBarControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bodyImageView;
@property (weak, nonatomic) IBOutlet UIImageView *handsImageView;
@property (weak, nonatomic) IBOutlet UIImageView *feetImageView;
@property (weak, nonatomic) IBOutlet UIImageView *weaponImageView;

@property (weak, nonatomic) IBOutlet UIButton *headButton;
@property (weak, nonatomic) IBOutlet UIButton *bodyButton;
@property (weak, nonatomic) IBOutlet UIButton *handsButton;
@property (weak, nonatomic) IBOutlet UIButton *feetButton;
@property (weak, nonatomic) IBOutlet UIButton *weaponButton;

@property (nonatomic, strong) MDSharedPlayerData *playerData;
@property (nonatomic, strong) NSArray *inventoryItemsToDisplay;

@end

@implementation MDPlayerViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Prevent blurry scaling for pixel art
    self.headImageView.layer.magnificationFilter = kCAFilterNearest;
    self.bodyImageView.layer.magnificationFilter = kCAFilterNearest;
    self.handsImageView.layer.magnificationFilter = kCAFilterNearest;
    self.feetImageView.layer.magnificationFilter = kCAFilterNearest;
    self.weaponImageView.layer.magnificationFilter = kCAFilterNearest;
    
    // Make a border with the same thickness as the border around item assets
    self.headImageView.layer.borderWidth = 3.0;
    self.bodyImageView.layer.borderWidth = 3.0;
    self.handsImageView.layer.borderWidth = 3.0;
    self.feetImageView.layer.borderWidth = 3.0;
    self.weaponImageView.layer.borderWidth = 3.0;
    
    self.playerData = [MDSharedPlayerData sharedPlayerData];
    
    // Populate images for items that are currently equipped
    if (self.playerData.player.equippedHead) {
        self.headImageView.image = [UIImage imageNamed:self.playerData.player.equippedHead.imageName];
        [self.headButton setTitle:@"" forState:UIControlStateNormal];
    } else {
        self.headImageView.image = nil;
        [self.headButton setTitle:@"Equip" forState:UIControlStateNormal];
    }
    
    if (self.playerData.player.equippedBody) {
        self.bodyImageView.image = [UIImage imageNamed:self.playerData.player.equippedBody.imageName];
        [self.bodyButton setTitle:@"" forState:UIControlStateNormal];
    } else {
        self.bodyImageView.image = nil;
        [self.bodyButton setTitle:@"Equip" forState:UIControlStateNormal];
    }
    
    if (self.playerData.player.equippedHands) {
        self.handsImageView.image = [UIImage imageNamed:self.playerData.player.equippedHands.imageName];
        [self.handsButton setTitle:@"" forState:UIControlStateNormal];
    } else {
        self.handsImageView.image = nil;
        [self.handsButton setTitle:@"Equip" forState:UIControlStateNormal];
    }
    
    if (self.playerData.player.equippedFeet) {
        self.feetImageView.image = [UIImage imageNamed:self.playerData.player.equippedFeet.imageName];
        [self.feetButton setTitle:@"" forState:UIControlStateNormal];
    } else {
        self.feetImageView.image = nil;
        [self.feetButton setTitle:@"Equip" forState:UIControlStateNormal];
    }
    
    if (self.playerData.player.equippedWeapon) {
        self.weaponImageView.image = [UIImage imageNamed:self.playerData.player.equippedWeapon.imageName];
        [self.weaponButton setTitle:@"" forState:UIControlStateNormal];
    } else {
        self.weaponImageView.image = nil;
        [self.weaponButton setTitle:@"Equip" forState:UIControlStateNormal];
    }

    self.tabBarController.delegate = self;
    
}

- (IBAction)equipPressed:(UIButton *)sender {
    
    // Buttons in the storyboard are tagged to indicate which inventory slot they apply to
    switch (sender.tag) {
        case 1000:
            self.inventoryItemsToDisplay = [[MDSharedPlayerData sharedPlayerData] allInventoryWeapons];
            break;
        case 1001:
            self.inventoryItemsToDisplay = [[MDSharedPlayerData sharedPlayerData] allInventoryArmorOfType:armorTypeHead];
            break;
        case 1002:
            self.inventoryItemsToDisplay = [[MDSharedPlayerData sharedPlayerData] allInventoryArmorOfType:armorTypeBody];
            break;
        case 1003:
            self.inventoryItemsToDisplay = [[MDSharedPlayerData sharedPlayerData] allInventoryArmorOfType:armorTypeHands];
            break;
        case 1004:
            self.inventoryItemsToDisplay = [[MDSharedPlayerData sharedPlayerData] allInventoryArmorOfType:armorTypeFeet];
            break;
        default:
            break;
    }
    
    [self performSegueWithIdentifier:@"SegueToInventory" sender:self];
}

#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"SegueToInventory"]) {
        MDInventoryTableViewController *inventoryVC = (MDInventoryTableViewController*)segue.destinationViewController;
        inventoryVC.items = self.inventoryItemsToDisplay;
    }
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    // When navigating to another tab, always pop to the root player view.
    [self.navigationController popToRootViewControllerAnimated:NO];
}


@end
