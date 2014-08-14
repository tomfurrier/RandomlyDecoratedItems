//
//  MDItemTableViewCell.h
//  MDItems
//
//  Created by Dickman, Mike on 7/1/14.
//  Copyright (c) 2014 Dickman, Mike. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDItemTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *statLabel;
@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;

@end
