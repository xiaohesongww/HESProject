//
//  GuideViewController.m
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "GuideViewController.h"
#import "LoginViewController.h"

@interface GuideViewController ()<UIScrollViewDelegate>
{
    // 创建页码控制器
    UIPageControl *pageControl;
    // 判断是否是第一次进入应用
    BOOL flag;
}
@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIScrollView *myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    for (int i=0; i<3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"引导页-%d",i+1]];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH * i, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
        // 在最后一页创建按钮
        if (i == 2) {
            // 必须设置用户交互 否则按键无法操作
            imageView.userInteractionEnabled = YES;
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.frame = CGRectMake(kSCREEN_WIDTH / 3, kSCREEN_HEIGHT * 6 / 8, kSCREEN_WIDTH / 3, kSCREEN_HEIGHT / 16);
            button.backgroundColor = [UIColor colorWithHexString:@"45b20f"];
            [button setTitle:@"马上体验" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.layer.borderWidth = 2;
            button.layer.cornerRadius = 5;
            button.clipsToBounds = YES;
            button.layer.borderColor = [UIColor whiteColor].CGColor;
            [button addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:button];
        }
        imageView.image = image;
        [myScrollView addSubview:imageView];
    }
    myScrollView.bounces = NO;
    myScrollView.pagingEnabled = YES;
    myScrollView.showsHorizontalScrollIndicator = NO;
    myScrollView.contentSize = CGSizeMake(kSCREEN_WIDTH * 3, kSCREEN_HEIGHT);
    myScrollView.delegate = self;
    [self.view addSubview:myScrollView];
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH / 3, kSCREEN_HEIGHT * 14 / 16, kSCREEN_WIDTH / 3, kSCREEN_HEIGHT / 16)];
    // 设置页数
    pageControl.numberOfPages = 3;
    // 设置页码的点的颜色
    pageControl.pageIndicatorTintColor = [UIColor colorWithHexString:@"cccccb"];
    // 设置当前页码的点颜色
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"45b20f"];
    
    [self.view addSubview:pageControl];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 计算当前在第几页
    pageControl.currentPage = (NSInteger)(scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width);
}

// 点击按钮保存数据并切换根视图控制器
- (void) go:(UIButton *)sender{
    flag = YES;
    NSUserDefaults *useDef = [NSUserDefaults standardUserDefaults];
    // 保存用户数据
    [useDef setBool:flag forKey:@"notFirst"];
    [useDef synchronize];
    // 切换根视图控制器
    self.view.window.rootViewController = [[LoginViewController alloc] init];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
