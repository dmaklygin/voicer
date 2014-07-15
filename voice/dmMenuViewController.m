//
//  dmMenuViewController.m
//  voice
//
//  Created by Дмитрий on 28.06.14.
//  Copyright (c) 2014 Дмитрий. All rights reserved.
//

#import "dmMenuViewController.h"
#import "dmMenuTableViewCell.h"


@interface dmMenuViewController ()
@property (nonatomic, strong) NSMutableArray *menuItems;

@property (nonatomic, strong) UIColor *notSelectedColor;
@property (nonatomic, strong) UIColor *selectedColor;

@end

@implementation dmMenuViewController

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
    // Do any additional setup after loading the view.
    [self.tableView registerNib:[UINib nibWithNibName:@"dmMenuTableViewCell" bundle:nil] forCellReuseIdentifier:@"MenuTableViewCell"];
    
    self.notSelectedColor = UIColorFromRGB(0x222428);
    self.selectedColor = UIColorFromRGB(0xf08352);
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSMutableArray *)menuItems
{
    if (_menuItems) {
        return _menuItems;
    }
    
    _menuItems = [[NSMutableArray alloc] initWithArray:@[@"messages",
                                                         @"voxers",
                                                         @"myvoxers",
                                                         @"settings",
                                                         @"notifications",
                                                         @"search",
                                                         @"messages",
                                                         @"flows"
                                                         ]
                  ];
    
    return _menuItems;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.menuItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    dmMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuTableViewCell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"MenuTableViewCell"];
    }
    
    NSString *itemKey = self.menuItems[indexPath.row];
    NSString *titleKey = [NSString stringWithFormat:@"dm.voice.menu.item.%@", itemKey];
    // Configure the cell...
    cell.titleLabel.text = NSLocalizedString(titleKey, nil);
    
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"menu_%@.png", itemKey]];
    [cell.iconImage setImage:image];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 47;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *currentSelectedIndexPath = [tableView indexPathForSelectedRow];
    if (currentSelectedIndexPath != nil) {
        [[tableView cellForRowAtIndexPath:currentSelectedIndexPath] setBackgroundColor:self.notSelectedColor];
    }
    
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[tableView cellForRowAtIndexPath:indexPath] setBackgroundColor:self.selectedColor];
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (cell.isSelected == YES) {
        [cell setBackgroundColor:self.selectedColor];
    } else {
        [cell setBackgroundColor:self.notSelectedColor];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
