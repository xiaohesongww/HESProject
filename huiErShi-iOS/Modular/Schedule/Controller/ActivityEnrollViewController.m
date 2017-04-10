//
//  ActivityEnrollViewController.m
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "ActivityEnrollViewController.h"
#import "ActivityDetailViewController.h"
#import "ActivityRemindCell.h"
#import "ProgressView.h"
#import "ActivityModel.h"

@interface ActivityEnrollViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_activityListArr;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *titlesView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSMutableArray *titleButtons;
@property (nonatomic, strong) UIView *titleBottomView;

/**
   设置当前工作状态 0:未开始 1:已结束
 */
@property (nonatomic, strong) NSString *state;
@end

@implementation ActivityEnrollViewController

- (void)ActivityRequestWithState:(NSString *)state {
    NSDictionary *dic = @{
                          @"isOver":state,
                          @"page":@"0",
                          @"pageNum":@"10"
                          };
    NSString *UrlString = [TEST_URL stringByAppendingString:@"activity"];
    [[NetworkEngine sharedNetworkEngine] getWithURLString:UrlString parameters:dic success:^(id responseObject) {
        if (_activityListArr.count>0) {
            [_activityListArr removeAllObjects];
        }
        NSArray *array = responseObject[@"content"];
        for (NSDictionary *dataDic in array) {
            ActivityModel *model = [[ActivityModel alloc] initWithDict:dataDic];
            [_activityListArr addObject:model];
        }
        self.tableView.contentSize = CGSizeMake(kScreenWidth, 215*_activityListArr.count) ;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.state = @"0";
    [self setUpUI];
    [self ActivityRequestWithState:self.state];
    // Do any additional setup after loading the view.
}

#pragma mark -- UI
- (void)setUpUI {
    _activityListArr = [NSMutableArray arrayWithCapacity:1];
    self.titleButtons = [NSMutableArray arrayWithCapacity:1];
    [self setUpSliderView];
    //tableView
    [self creatTableView];
    
}

- (void)setUpSliderView {
    // 标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [UIColor whiteColor];
    titlesView.frame = CGRectMake(0, 0, kScreenWidth, 44);
    self.titlesView = titlesView;
    [self.view addSubview:titlesView];
    CALayer * layer = [titlesView layer];
    [layer setShadowOffset:CGSizeMake(0, -0.5)];
    [layer setShadowRadius:2];
    [layer setShadowOpacity:0.7];
    [layer setShadowColor:[UIColor colorWithHexString:@"999999"].CGColor];

    
    self.titles = @[@"活动报名",@"过往活动"];
    NSUInteger count = self.titles.count;
    CGFloat titleButtonH = titlesView.height;
    CGFloat titleButtonW = kScreenWidth/2;
    for (int i = 0; i < count; i++) {
        // 创建
        
        UIButton *titleButton = [[UIButton alloc] init];
        titleButton.backgroundColor = [UIColor whiteColor];
        titleButton.titleLabel.font = [UIFont systemFontOfSize:14];
        titleButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
        titleButton.tag = 2000+i;
        [titleButton setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
       [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:titleButton];
        [self.titleButtons addObject:titleButton];
        [self.titlesView addSubview:titleButton];
        
        // 文字

        NSString *title = self.titles[i];
        [titleButton setTitle:title forState:UIControlStateNormal];
        
        // frame
        titleButton.frame = CGRectMake(i*titleButtonW, 0, titleButtonW, titleButtonH - 3);
    }
    
    // 标签栏底部的指示器控件
        UIView *titleBottomView = [[UIView alloc] init];
    titleBottomView.backgroundColor = HESHEXCOLOR(@"00a652");
        titleBottomView.height = 3;
        titleBottomView.mj_y = titlesView.height - titleBottomView.height;
        [titlesView addSubview:titleBottomView];
        self.titleBottomView = titleBottomView;
    UIButton *firstTitleButton = self.titleButtons.firstObject;
    [firstTitleButton.titleLabel sizeToFit];
    titleBottomView.width = firstTitleButton.titleLabel.width + 10;
    titleBottomView.centerX = firstTitleButton.centerX;
    [self titleClick:firstTitleButton];
}

- (void)titleClick:(UIButton *)sender {
    switch (sender.tag) {
        case 2000:
            self.state = @"0";
            [self ActivityRequestWithState:self.state];
            break;
        case 2001:
            self.state = @"1";
            [self ActivityRequestWithState:self.state];
            break;
            
        default:
            break;
    }
    // 底部控件的位置和尺寸
    [UIView animateWithDuration:0.25 animations:^{
        self.titleBottomView.width = sender.titleLabel.width + 10;
        self.titleBottomView.centerX = sender.centerX;
        [self.titleBottomView layoutIfNeeded];
    }];
    for (UIButton *btn in self.titleButtons) {
        if (btn.tag == sender.tag) {
            [btn setTitleColor:HESHEXCOLOR(@"333333") forState:UIControlStateNormal];
        } else {
            [btn setTitleColor:HESHEXCOLOR(@"cccccc") forState:UIControlStateNormal];
        }
    }
}

- (void)creatTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, kScreenWidth, kScreenHeight - 64 - 44) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

#pragma mark -- tableView 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _activityListArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ActivityRemindCell *cell = [ActivityRemindCell loadNibCellWithTabelView:tableView];
    cell.activityModel = _activityListArr[indexPath.section];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ActivityDetailViewController *detailVc = [[ActivityDetailViewController alloc] init];
    detailVc.navigationItem.title = @"活动详情";
    ActivityModel *model = _activityListArr[indexPath.section];
    detailVc.model = model;
    detailVc.activityId = KString(model.id);
    [self.navigationController pushViewController:detailVc animated:YES];
}

#pragma mark -- 区头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    sectionView.backgroundColor = HESCOLOR(238, 238, 238);
    UIView *sepline = [[UIView alloc] init];
    sepline.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
    [sectionView addSubview:sepline];
    sepline.sd_layout.leftEqualToView(sectionView).rightEqualToView(sectionView).bottomEqualToView(sectionView).heightIs(0.5);
    return sectionView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 215;
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
