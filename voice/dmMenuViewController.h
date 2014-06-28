//
//  dmMenuViewController.h
//  voice
//
//  Created by Дмитрий on 28.06.14.
//  Copyright (c) 2014 Дмитрий. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dmMenuViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
