//
//  MeMyDeviceViewController.m
//  huiErShi-iOS
//
//  Created by wanjianIOSMacMini on 2017/2/10.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "MeMyDeviceViewController.h"
#import "MyDeviceCell.h"

@interface MeMyDeviceViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MeMyDeviceViewController
static NSString *myDivceCellID = @"myDivceCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    self.navigationItem.title=@"我的设备";
}

#pragma mark -- UI
- (void)setUpUI {
    
    //tableView
    [self creatTableView];
    
}

- (void)creatTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

#pragma mark -- tableView 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyDeviceCell *cell = [MyDeviceCell loadNibCellWithTabelView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        cell.iconImgView.image = [UIImage imageNamed:@"card0"];
        cell.deviceName.text = @"Fibit手环";
        cell.state.text = @"已连接";
    } else if (indexPath.section == 1) {
        cell.iconImgView.image = [UIImage imageNamed:@"card1"];
        cell.deviceName.text = @"iHealth血压仪";
        cell.state.text = @"已连接";
    } else if (indexPath.section == 2) {
        cell.iconImgView.image = [UIImage imageNamed:@"card2"];
        cell.deviceName.text = @"iHealth血糖仪";
        cell.state.text = @"已连接";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark -- 区头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sepView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    sepView.backgroundColor = HESCOLOR(238, 238, 238);
    return sepView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
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
