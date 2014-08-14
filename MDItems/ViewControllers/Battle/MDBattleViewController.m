//
//  MDFightViewController.m
//  MDItems
//
//  Created by Dickman, Mike on 7/23/14.
//  Copyright (c) 2014 Dickman, Mike. All rights reserved.
//

#import "MDBattleViewController.h"
#import "MDEnemy.h"
#import "MDPlayer.h"
#import "MDMessageTableViewCell.h"
#import "MDSharedPlayerData.h"
#import "MDVictoryViewController.h"
#import "MDItemFactory.h"
#import "MDWeapon.h"
#import "NSObject+Random.h"
#import "MDBattleMessage.h"
#import "MDGameEngine.h"

@interface MDBattleViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *enemyNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *enemyImageView;
@property (weak, nonatomic) IBOutlet UITableView *messagesTableView;
@property (weak, nonatomic) IBOutlet UILabel *enemyHealthLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerHealthLabel;

@property (nonatomic, strong) NSMutableArray *messageLog;
@property (nonatomic, strong) MDEnemy *currentEnemy;
@property (nonatomic, strong) MDSharedPlayerData *playerData;

@end

@implementation MDBattleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // A list of messages that displays the history of the battle to the player
    self.messageLog = [NSMutableArray array];
    
    [self setUpNewPlayer];
    
    // Style UI elements
    self.enemyImageView.layer.magnificationFilter = kCAFilterNearest; // Prevents blurry edges when scaling pixel art
    self.messagesTableView.layer.borderWidth = 1.0;
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.currentEnemy.currentHealth <= 0) {
        [self refreshEnemyToRandom];
    }
}

#pragma mark - Helpers

-(void)setUpNewPlayer {
    
    self.playerData = [MDSharedPlayerData sharedPlayerData];
    self.playerData.player = [[MDPlayer alloc] init];
    [self.messageLog removeAllObjects];
    [self.messagesTableView reloadData];
    [self refreshEnemyToEnemy:[MDEnemy slime]];
    [self refreshPlayerHealth];
}

-(void)refreshEnemyToRandom {
    [self refreshEnemyToEnemy:[MDEnemy randomEnemy]];
}

-(void)refreshEnemyToEnemy:(MDEnemy*)enemy {
    
    // Set a new enemy as the current enemy
    self.currentEnemy = enemy;
    self.enemyImageView.image = [UIImage imageNamed:self.currentEnemy.imageName];
    self.enemyNameLabel.text = self.currentEnemy.name;
    [self refreshEnemyHealth];
    
    [self.messageLog insertObject:[MDBattleMessage messageWithMessage:[NSString stringWithFormat:@"Wild %@ appeared!", self.currentEnemy.name]
                                 describesPlayerAction:NO]
                        atIndex:0];
    [self.messagesTableView reloadData];
}

-(void)refreshEnemyHealth {
    
    self.enemyHealthLabel.text = [NSString stringWithFormat:@"HP: %d/%d", self.currentEnemy.currentHealth, self.currentEnemy.maxHealth];
    
    // Handle the enemy's death
    if (self.currentEnemy.currentHealth <= 0) {
        
        // Don't segue to the victory screen if the player has also died
        if (self.playerData.player.currentHealth > 0) {
            [self performSegueWithIdentifier:@"SegueToVictory" sender:self];
        }
        
        [self.messageLog insertObject:[MDBattleMessage messageWithMessage:[NSString stringWithFormat:@"%@ was defeated!", self.currentEnemy.name]
                                                    describesPlayerAction:YES]
                              atIndex:0];
        [self.messagesTableView reloadData];
        
        self.enemyImageView.image = nil;
        self.currentEnemy = nil;
    }
}

-(void)refreshPlayerHealth {
    
    // Handle the player's death
    if (self.playerData.player.currentHealth <= 0) {
        self.playerData.player.currentHealth = 0;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You died!"
                                   message:nil
                                  delegate:self
                         cancelButtonTitle:@"Restart"
                         otherButtonTitles:nil];
        alert.delegate = self;
        [alert show];
    }
    
    self.playerHealthLabel.text = [NSString stringWithFormat:@"Player HP: %d/%d", self.playerData.player.currentHealth, self.playerData.player.maxHealth];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    // Player died and tapped "Restart"
    [self setUpNewPlayer];
}

#pragma mark - Actions

- (IBAction)attackPressed {

    // Allow the engine to run the turn logic (player and enemy attacks)
    [MDGameEngine takeTurnWithPlayer:self.playerData.player
                               enemy:self.currentEnemy
                          messageLog:self.messageLog];
    
    // Refresh the UI
    [self refreshEnemyHealth];
    [self refreshPlayerHealth];
    [self.messagesTableView reloadData];
}

#pragma mark - Table View Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.messageLog count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MDMessageTableViewCell *cell = (MDMessageTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"MessageCell"];

    MDBattleMessage *message = self.messageLog[indexPath.row];
    cell.messageLabel.text = message.messageString;
    
    // Make enemy actions red
    if (!message.describesPlayerAction) {
        cell.messageLabel.textColor = [UIColor redColor];
    } else {
        cell.messageLabel.textColor = [UIColor blackColor];
    }
    
    return cell;
}

#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"SegueToVictory"]) {
        UINavigationController *navController = (UINavigationController*)segue.destinationViewController;
        MDVictoryViewController *victoryVC = (MDVictoryViewController*)navController.viewControllers[0];
        
        // Reward the player with 0 - 3 items
        int numberOfItems = [self randomFromMin:0 max:3];
        NSMutableArray *droppedItems = [NSMutableArray arrayWithCapacity:3];
        
        for (int i = 0; i < numberOfItems; i++) {
            [droppedItems addObject:[MDItemFactory randomItem]];
        }
        
        victoryVC.items = droppedItems;
    }
}

@end
