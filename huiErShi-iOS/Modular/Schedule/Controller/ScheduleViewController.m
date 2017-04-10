//
//  ScheduleViewController.m
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "ScheduleViewController.h"
#import "ActivityRemindViewController.h"
#import "ActivityEnrollViewController.h"
#import "SloganSettingViewController.h"
#import "ScheduleDetailViewController.h"
#import "SchedulelistCell.h"
#import "JHCustomMenu.h"
#import "ScheduleTopSectionView.h"

@interface ScheduleViewController ()<UITableViewDelegate,UITableViewDataSource,JHCustomMenuDelegate,ScheduleTopSectionViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) JHCustomMenu *menu;
@end

@implementation ScheduleViewController


#pragma mark -- 日程资源请求
- (void)ScheduleSourceRequest {
    NSDictionary *dict = @{@"userId":@"1"};
    NSString *urlString =  [TEST_URL stringByAppendingString:@"task"];
    [[NetworkEngine sharedNetworkEngine] getWithURLString:urlString parameters:dict success:^(id responseObject) {
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self ScheduleSourceRequest];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UILocalNotification *localNotifi = [UILocalNotification new];
    localNotifi.alertBody = @"该吃药了...";
    localNotifi.alertAction = @"温馨提示...";
    localNotifi.hasAction = YES;
    localNotifi.alertTitle = @"该吃药了...";
    localNotifi.fireDate = [NSDate dateWithTimeIntervalSinceNow:6];
    localNotifi.soundName = UILocalNotificationDefaultSoundName;
//    localNotifi.repeatInterval = 5;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotifi];

    [self setUpUI];
    [self setNav];
    // Do any additional setup after loading the view.
}
#pragma mark -- setNav
- (void)setNav {
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem barButtonItemWithImageName:@"添加" target:self action:@selector(addClick)];
}

//添加
-(void)addClick{
    __weak __typeof(self) weakSelf = self;
    if (!self.menu) {
        self.menu = [[JHCustomMenu alloc] initWithDataArr:@[@"活动提醒", @"活动报名", @"口号设置"] origin:CGPointMake(kScreenWidth - 145, 0) width:125 rowHeight:44];
        _menu.delegate = self;
        _menu.dismiss = ^() {
            weakSelf.menu = nil;
        };
        [self.view addSubview:_menu];
    } else {
        [_menu dismissWithCompletion:^(JHCustomMenu *object) {
            weakSelf.menu = nil;
        }];
    }
}

#pragma mark -- JHCustomMenuDelegate
- (void)jhCustomMenu:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {//活动提醒
            ActivityRemindViewController *remindVc = [[ActivityRemindViewController alloc] init];
            remindVc.navigationItem.title = @"提醒管理";
            [self.navigationController pushViewController:remindVc animated:YES];
            break;
    }
        case 1: {//活动报名
            ActivityEnrollViewController *enrollVc = [[ActivityEnrollViewController alloc] init];
            enrollVc.navigationItem.title = @"活动报名";
            [self.navigationController pushViewController:enrollVc animated:YES];
            break;
    }
        case 2: {//口号设置
            SloganSettingViewController *sloganVc = [[SloganSettingViewController alloc] init];
            sloganVc.navigationItem.title = @"口号设置";
            [self.navigationController pushViewController:sloganVc animated:YES];
            break;
    }
        default:
            break;
    }
}

#pragma mark -- UI
- (void)setUpUI {
    self.view.backgroundColor=HESCOLOR_THEME;
    [self creatTableView];
    
}

- (void)creatTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

#pragma mark -- tableView 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SchedulelistCell *cell = [SchedulelistCell loadNibCellWithTabelView:tableView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -- 区头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *plistPath1 = [paths objectAtIndex:0];
        NSString *filename=[plistPath1 stringByAppendingPathComponent:@"UserResource.plist"];
        NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
        ScheduleTopSectionView *topView = [[NSBundle mainBundle] loadNibNamed:@"ScheduleTopSectionView" owner:self options:nil].lastObject;
        topView.delegate = self;
        topView.frame = CGRectMake(0, 0, kScreenWidth, 150);
        topView.sloganlabel.text = dataDic[@"slogan"];
        return topView;
    } else {
        UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        sectionView.backgroundColor = HESCOLOR(238, 238, 238);
        UIView *sepView = [[UIView alloc] init];
        sepView.backgroundColor = [UIColor colorWithHexString:@"00a652"];
        [sectionView addSubview:sepView];
        sepView.sd_layout.leftSpaceToView(sectionView,90).topEqualToView(sectionView).bottomEqualToView(sectionView).widthIs(2);
        UIView *sepline = [[UIView alloc] init];
        sepline.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
        [sectionView addSubview:sepline];
        sepline.sd_layout.leftEqualToView(sectionView).rightEqualToView(sectionView).bottomEqualToView(sectionView).heightIs(0.5);
        return sectionView;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 150;
    } else {
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

//先要设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
//进入编辑模式，按下出现的编辑按钮后,进行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
    }
}
//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}


#pragma mark -- ScheduleTopSectionViewDelegate(查看日程详情)
- (void)scheduleDetail {
    ScheduleDetailViewController *scheduleDetailVc = [ScheduleDetailViewController new];
    [self.navigationController pushViewController:scheduleDetailVc animated:YES];
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
