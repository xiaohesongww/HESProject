//
//  MainTabBarController.m
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "MainTabBarController.h"
#import "MainNavigationController.h"
#import "ScheduleViewController.h"
#import "ExpertViewController.h"
#import "HealthyViewController.h"
#import "MeViewController.h"
#import "RZPopupMenuView.h"

@interface MainTabBarController ()
@property (nonatomic, strong) UIButton *addBtn;
@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加所有的子控制器
    [self setupAllViewController];
    
    
    // 添加Add按钮
    [self addButton];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:HESHEXCOLOR(@"00a652"), NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
}

#pragma mark ---- <添加视频采集按钮>
- (void)addButton {
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addBtn setImage:GETIMG(@"添加按钮") forState:UIControlStateNormal];
    // 自适应,自动根据按钮图片和文字计算按钮尺寸
    [_addBtn sizeToFit];
    
    _addBtn.center = CGPointMake(self.tabBar.width * 0.5, self.tabBar.height * 0.5 + 5);
    [_addBtn addTarget:self action:@selector(clickAddBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tabBar addSubview:_addBtn];
}

#pragma mark ---- <点击了AddBtn>
- (void)clickAddBtn {
    [RZPopupMenuView showWithDelegate:self];
    NSLog(@"点击了添加按钮");
}

//自定义TabBar高度
- (void)viewWillLayoutSubviews {
    
    CGRect tabFrame = self.tabBar.frame;
    tabFrame.size.height = 58;
    tabFrame.origin.y = self.view.frame.size.height - 58;
    self.tabBar.frame = tabFrame;
}

#pragma mark ---- <添加所有的子控制>
- (void)setupAllViewController {
    
    ScheduleViewController *scheduleVC = [[ScheduleViewController alloc] init];
    scheduleVC.navigationItem.title=@"日程";
    scheduleVC.tabBarItem.title=@"日程";
    scheduleVC.tabBarItem.image = GETIMG(@"日程");
    scheduleVC.tabBarItem.selectedImage = [self imageWithOriginalRenderingMode:@"日程选中"];
    MainNavigationController *scheduleNav = [[MainNavigationController alloc] initWithRootViewController:scheduleVC];
    [self addChildViewController:scheduleNav];

    ExpertViewController *expertVC = [[ExpertViewController alloc] init];
    expertVC.navigationItem.title=@"专家指导";
    expertVC.tabBarItem.title=@"专家指导";
    expertVC.tabBarItem.image = GETIMG(@"专家指导");
    expertVC.tabBarItem.selectedImage = [self imageWithOriginalRenderingMode:@"专家指导选中"];
    MainNavigationController *expertNav = [[MainNavigationController alloc] initWithRootViewController:expertVC];
    [self addChildViewController:expertNav];
    
    UIViewController *addVc = [[UIViewController alloc] init];
    addVc.tabBarItem.enabled = NO;
    [self addChildViewController:addVc];
    

    HealthyViewController *healthyVC= [[HealthyViewController alloc] init];
    healthyVC.navigationItem.title=@"健康档案";
    healthyVC.tabBarItem.title=@"健康档案";
    healthyVC.tabBarItem.image = GETIMG(@"健康档案");
    healthyVC.tabBarItem.selectedImage = [self imageWithOriginalRenderingMode:@"健康档案选中"];
    MainNavigationController *healthyNav = [[MainNavigationController alloc] initWithRootViewController:healthyVC];
    [self addChildViewController:healthyNav];
    
    MeViewController *meVc = [[MeViewController alloc] init];
    meVc.tabBarItem.title=@"我";
    meVc.tabBarItem.image = GETIMG(@"我");
    meVc.tabBarItem.selectedImage = [self imageWithOriginalRenderingMode:@"我选中"];
    MainNavigationController *meNav = [[MainNavigationController alloc] initWithRootViewController:meVc];
    [self addChildViewController:meNav];
    
    
    UIEdgeInsets insets = UIEdgeInsetsMake(5, 0, -5, 0);
    
    scheduleVC.tabBarItem.imageInsets=insets;
    expertVC.tabBarItem.imageInsets=insets;
    addVc.tabBarItem.imageInsets=insets;
    healthyVC.tabBarItem.imageInsets=insets;
    meVc.tabBarItem.imageInsets = insets;
    
    
    UIImage *image = [UIImage imageNamed:@"tab_bg"];
    // 指定为拉伸模式，伸缩后重新赋值
    UIImage *TabBgImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20) resizingMode:UIImageResizingModeStretch];
    self.tabBar.backgroundImage = TabBgImage;
    self.tabBar.shadowImage = [UIImage new];

}
-(UIImage *)imageWithOriginalRenderingMode:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
