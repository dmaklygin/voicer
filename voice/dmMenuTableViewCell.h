//
//  dmMenuTableViewCell.h
//  voice
//
//  Created by Дмитрий on 28.06.14.
//  Copyright (c) 2014 Дмитрий. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dmMenuTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *iconImage;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIButton *infoButton;
- (IBAction)onInfoButtonTapped:(id)sender;

@end
