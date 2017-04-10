//
//  MeMemberCardViewController.m
//  huiErShi-iOS
//
//  Created by wanjianIOSMacMini on 2017/2/10.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "MeMemberCardViewController.h"
#import "MeCardChildViewController.h"
#import "MeCardHeardView.h"
#import "NetworkEngine.h"

@interface MeMemberCardViewController ()<MeCardHeadViewDelegate>

@property (nonatomic, strong) MeCardHeardView *heardView;
@property (nonatomic, strong) UIScrollView *backgroundScrollView;
@end

@implementation MeMemberCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"会员卡";
    MeCardChildViewController * alreadyBuyVc = [[MeCardChildViewController alloc] init];
    ;
    alreadyBuyVc.type=MeCardChildItemTypeAlreadyBuy;
    
    MeCardChildViewController * notBuyVc = [[MeCardChildViewController alloc] init];
    notBuyVc.type=MeCardChildItemTypeNotBuy;
    
    
    [self addChildViewController:alreadyBuyVc];
    [self addChildViewController:notBuyVc];
    
    NSInteger viewCounts = self.childViewControllers.count;
    
    _heardView=[[MeCardHeardView alloc]init];
    _heardView.delegate = self;
    [self.view addSubview:_heardView];
    _heardView.sd_layout
    .topSpaceToView(self.view,0)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(44);
    
    
    
    //初始化最底部的scrollView
    self.backgroundScrollView = [[UIScrollView alloc] init];
    self.backgroundScrollView.backgroundColor = [UIColor clearColor];
    self.backgroundScrollView.pagingEnabled = YES;
    self.backgroundScrollView.bounces = NO;
    self.backgroundScrollView.showsHorizontalScrollIndicator = NO;
    self.backgroundScrollView.delegate = (id<UIScrollViewDelegate>)self;
    self.backgroundScrollView.contentSize = CGSizeMake(kScreenWidth * viewCounts, 0);
    [self.view addSubview:self.backgroundScrollView];
    
    self.backgroundScrollView.sd_layout.topSpaceToView(_heardView,0)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0);
    
    // 添加默认控制器
    UIViewController *vc = [self.childViewControllers firstObject];
    vc.view.frame = self.backgroundScrollView.bounds;
    [self.backgroundScrollView addSubview:vc.view];
    
    [self.backgroundScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //
    NSUInteger index = scrollView.contentOffset.x / self.backgroundScrollView.frame.size.width;
    _heardView.isAlreadyBuy=!index;
    
    UIViewController *showVc = self.childViewControllers[index];
    if (showVc.view.superview) return;
    showVc.view.frame = scrollView.bounds;
    [self.backgroundScrollView addSubview:showVc.view];
}

- (void)switchToLastController {
    [self.backgroundScrollView.subviews.firstObject removeFromSuperview];
    
    UIViewController *showVc = self.childViewControllers.firstObject;
    showVc.view.frame = self.backgroundScrollView.bounds;
    [self.backgroundScrollView insertSubview:showVc.view atIndex:0];
}

- (void)switchToNextController {
    [self.backgroundScrollView.subviews.firstObject removeFromSuperview];
    
    UIViewController *showVc = self.childViewControllers.lastObject;
    showVc.view.frame = self.backgroundScrollView.bounds;
    [self.backgroundScrollView insertSubview:showVc.view atIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
