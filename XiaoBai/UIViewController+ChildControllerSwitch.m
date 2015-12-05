//
//  UIViewController+ChildSwitch.m
//  segmentSwitch
//
//  Created by wangyang on 5/13/15.
//  Copyright (c) 2015 IGIU. All rights reserved.
//

#import "UIViewController+ChildControllerSwitch.h"
#import <objc/runtime.h>

@implementation UIViewController (ChildControllerSwitch)

/**
 *  set方法是为了适应IB,如果纯代码可以不用set方法
 */
- (void)setChildContainer:(UIView *)childContainer{
    objc_setAssociatedObject(self, @selector(childContainer), childContainer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)childContainer{
    
    UIView *childContainer = objc_getAssociatedObject(self, _cmd);
    if (!childContainer) {
        childContainer = [UIView new];
        objc_setAssociatedObject(self, _cmd, childContainer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return childContainer;
}

- (void)setCurrentController:(UIView *)currentController{
    objc_setAssociatedObject(self, NSSelectorFromString(@"currentController"), currentController, OBJC_ASSOCIATION_ASSIGN);
}

- (UIViewController *)currentController{
    return objc_getAssociatedObject(self, NSSelectorFromString(@"currentController"));
}

- (void)setFirstController:(UIViewController *)controller{
    controller.view.frame = self.childContainer.bounds;
    [self.childContainer addSubview:controller.view];
    self.currentController = controller;
    [self addChildViewController:controller];
    [self.currentController didMoveToParentViewController:self];

}

//- (void)setFirstController:(UIViewController *)controller otherController:(NSArray *)otherControllers;{
//    
//    NSAssert(controller, @"不能设置nil为第一个controller");
//    NSAssert(self.childContainer.superview, @"self.childContainer must have a superview");
//    
//    [self setFirstController:controller];
//
//    for (UIViewController *other in otherControllers) {
//        [self addChildViewController:other];
//    }
//}

- (void)addChildViewControllers:(NSArray *)controllers {
    NSAssert(self.childContainer.superview, @"self.childContainer must have a superview");
    [self setFirstController:controllers[0]];

    for (NSInteger i = 1; i < controllers.count; i++) {
        [self addChildViewController:controllers[i]];
    }
}

- (void)switchToChildControllerAtIndex:(NSUInteger)index completion:(void (^)(void))completionBlock
{
    UIViewController *to  = self.childViewControllers[index];
    UIViewController *from = self.currentController;
    
    if (to == from) {
        if (completionBlock) {
            completionBlock();
        }
        return;
    }
    
    [self.currentController willMoveToParentViewController:nil];
    to.view.frame = self.childContainer.bounds;
    to.view.alpha = 0;
    
    [self transitionFromViewController:from toViewController:to duration:0.1 options:UIViewAnimationOptionCurveLinear animations:^{
        from.view.alpha = 0;
        to.view.alpha = 1;
    } completion:^(BOOL finished) {
        
        // didMoveToParentViewController必须在transition completion之后
        [to didMoveToParentViewController:self];
        self.currentController = to;
        
        if (completionBlock) {
            completionBlock();
        }
    }];
    
}
@end
