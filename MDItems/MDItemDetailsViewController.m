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
#import "UIColor+ItemColors.h"

@interface MDItemDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIView *propertiesContainerView;
@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *statLabel;
@property (weak, nonatomic) IBOutlet UILabel *sellsForLabel;
@property (weak, nonatomic) IBOutlet UILabel *requiredLevelLabel;

@end

@implementation MDItemDetailsViewController

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
    
    self.nameLabel.text = [self.item fullName];
    self.nameLabel.textColor = [UIColor colorForItem:self.item];
    self.statLabel.text = [self.item statDescription];
    self.itemImageView.layer.magnificationFilter = kCAFilterNearest; // Prevents blurry edges when scaling pixel art
    self.itemImageView.image = [UIImage imageNamed:self.item.imageName];
    self.sellsForLabel.text = [NSString stringWithFormat:@"Sells for %dg", self.item.sellingPrice];
    self.requiredLevelLabel.text = [NSString stringWithFormat:@"Required level: %d", self.item.requiredPlayerLevel];
    
    // Hide the properties table only if the item has none
    if ([self.item.propertyDescriptions count] == 0) {
        self.propertiesContainerView.hidden = YES;
    }
}

#pragma mark - Table View Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.item.propertyDescriptions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Set the cells to show the item property descriptions
    MDItemPropertyTableViewCell *cell = (MDItemPropertyTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"PropertyCell" forIndexPath:indexPath];
    
    cell.descriptionLabel.text = self.item.propertyDescriptions[indexPath.row];
    
    return cell;
}

@end
