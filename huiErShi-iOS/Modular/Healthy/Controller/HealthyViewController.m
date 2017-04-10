//
//  HealthyViewController.m
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "HealthyViewController.h"
#import "HealthyHeadView.h"
#import "KanbanViewController.h"
#import "ReportViewController.h"
#import "AddMedicineViewController.h"
#import "MedicineViewController.h"
#import "DiaryTableViewController.h"
#import "SelfRatedController.h"

@interface HealthyViewController ()<HealthyHeadViewDelegate>
@property (nonatomic, strong) HealthyHeadView *healthyHeadView;
@property (nonatomic, strong) UIScrollView *backgroundScrollView;
@end

@implementation HealthyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self setNav];
}

#pragma mark -- setUpUI
- (void)setUpUI {
    [self selectTopView];
    [self setControllers];
    self.view.backgroundColor=HESCOLOR_THEME;
}

//设置顶部选择器
- (void)selectTopView {
    self.healthyHeadView = [[HealthyHeadView alloc] init];
    self.healthyHeadView.delegate = self;
    [self.view addSubview:self.healthyHeadView];
    self.healthyHeadView.sd_layout
    .topSpaceToView(self.view,0)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(LayOutH(88));
    
    //初始化最底部的scrollView
    self.backgroundScrollView = [[UIScrollView alloc] init];
    self.backgroundScrollView.backgroundColor = [UIColor clearColor];
    self.backgroundScrollView.pagingEnabled = YES;
    self.backgroundScrollView.bounces = NO;
    self.backgroundScrollView.showsHorizontalScrollIndicator = NO;
    self.backgroundScrollView.delegate = (id<UIScrollViewDelegate>)self;
    
    [self.view addSubview:self.backgroundScrollView];
    
    self.backgroundScrollView.sd_layout.topSpaceToView(self.healthyHeadView,LayOutH(20))
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .bottomSpaceToView(self.view, LayOutH(98));
}

//添加子控制器
- (void)setControllers {
    KanbanViewController *kanbanVC = [[KanbanViewController alloc] init];
    ReportViewController *reportVC = [ReportViewController new];
    MedicineViewController *medicineVC = [MedicineViewController new];
    DiaryTableViewController *diaryVC = [DiaryTableViewController new];
    [self addChildViewController:kanbanVC];
    [self addChildViewController:reportVC];
    [self addChildViewController:medicineVC];
    [self addChildViewController:diaryVC];
    
    NSInteger viewCounts = self.childViewControllers.count;
    self.backgroundScrollView.contentSize = CGSizeMake(kScreenWidth * viewCounts, 0);
    
    // 添加默认控制器
    UIViewController *vc = [self.childViewControllers firstObject];
    vc.view.frame = self.backgroundScrollView.bounds;
    [self.backgroundScrollView addSubview:vc.view];
    
    [self.backgroundScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
}

#pragma mark -- setNav
- (void)setNav {
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem barButtonItemWithImageName:@"添加" target:self action:@selector(addClick)];
}
//添加
-(void)addClick{
    CGFloat currentOffestScale = self.backgroundScrollView.contentOffset.x / self.view.bounds.size.width;
    NSLog(@"%f", currentOffestScale);
    switch ((int)currentOffestScale) {
        case 0:{
            SelfRatedController *selfRatedVC = [[SelfRatedController alloc] init];
            [self.navigationController pushViewController:selfRatedVC animated:YES];
        }
            break;
        case 2:{
            AddMedicineViewController *medicineVc = [[AddMedicineViewController alloc] init];
            [self.navigationController pushViewController:medicineVc animated:YES];
        }
            break;
        case 3:{
            UIViewController *vc = [[UIViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark -- HealthyHeadViewDelegate(切换选择控制器)
- (void)changeControllerWithSenderType:(SenderType)senderType {
    
    [self.backgroundScrollView setContentOffset:CGPointMake(kSCREEN_WIDTH * senderType, 0) animated:NO];
    int index = self.backgroundScrollView.contentOffset.x / self.backgroundScrollView.width;
    UIViewController *willShowChildVc = self.childViewControllers[index];
    // 如果控制器的view已经被创建过，就直接返回
    if (willShowChildVc.isViewLoaded) return;
    // 添加子控制器的view到scrollView身上
    willShowChildVc.view.frame = CGRectMake(index * kSCREEN_WIDTH, 0, kSCREEN_WIDTH, self.backgroundScrollView.frame.size.height);
    [self.backgroundScrollView addSubview:willShowChildVc.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
