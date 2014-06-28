//
//  dmSlidingViewController.m
//  voice
//
//  Created by Дмитрий on 26.06.14.
//  Copyright (c) 2014 Дмитрий. All rights reserved.
//

#import "dmSlidingViewController.h"
#import "dmZoomAnimationController.h"

@interface dmSlidingViewController ()
@property (nonatomic, strong) id viewControllerDelegate;
@end

@implementation dmSlidingViewController

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
    
    self.topViewAnchoredGesture = ECSlidingViewControllerAnchoredGestureTapping | ECSlidingViewControllerAnchoredGesturePanning;
    
    self.delegate = self.viewControllerDelegate;
    self.customAnchoredGestures = @[];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)viewControllerDelegate
{
    if (_viewControllerDelegate) {
        return _viewControllerDelegate;
    }
    
    _viewControllerDelegate = [[dmZoomAnimationController alloc] init];
    
    return _viewControllerDelegate;
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

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


@end
