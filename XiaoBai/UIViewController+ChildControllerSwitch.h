//
//  UIViewController+ChildSwitch.h
//  segmentSwitch
//
//  Created by wangyang on 5/13/15.
//  Copyright (c) 2015 IGIU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ChildControllerSwitch)
@property (nonatomic, strong) IBOutlet UIView *childContainer;
@property (nonatomic, strong) UIViewController *currentController;

- (void)addChildViewControllers:(NSArray *)controllers;

- (void)switchToChildControllerAtIndex:(NSUInteger)index completion:(void (^)(void))completionBlock;

@end
