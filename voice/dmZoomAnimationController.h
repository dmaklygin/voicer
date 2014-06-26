//
//  dmZoomAnimationController.h
//  voice
//
//  Created by Дмитрий on 27.06.14.
//  Copyright (c) 2014 Дмитрий. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECSlidingViewController.h"

@interface dmZoomAnimationController : NSObject <UIViewControllerAnimatedTransitioning,ECSlidingViewControllerDelegate, ECSlidingViewControllerLayout>

@end
