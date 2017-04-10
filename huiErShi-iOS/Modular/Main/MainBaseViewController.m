//
//  MainBaseViewController.m
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "MainBaseViewController.h"

@interface MainBaseViewController ()

@end

@implementation MainBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=HESCOLOR_THEME;
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.tabBarController.hidesBottomBarWhenPushed = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tabBarController.hidesBottomBarWhenPushed = YES;
}
- (BOOL)hidesBottomBarWhenPushed
{
    return (self.navigationController.topViewController == self);
}
@end
