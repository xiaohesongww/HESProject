//
//  MeMemberDataViewController.m
//  huiErShi-iOS
//
//  Created by wanjianIOSMacMini on 2017/2/10.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#define SELF_WIDTH self.view.frame.size.width
#import "MeMemberDataViewController.h"
#import "MeItemHeardView.h"
#import "MeMyInfoViewController.h"
#import "NetworkEngine.h"

@interface MeMemberDataViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nullable, nonatomic, strong) UITableView *memberDataTableView;
@property (nonatomic, strong) NSDictionary *vipDetailsDict;
@end

@implementation MeMemberDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"会籍资料";
    
    self.memberDataTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.memberDataTableView.bounces = NO;
    self.memberDataTableView.dataSource = self;
    self.memberDataTableView.delegate = self;
    self.memberDataTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, LayOutH(316) + 10)];
    self.memberDataTableView.tableHeaderView.backgroundColor = HESCOLOR_THEME;
    
    MeItemHeardView *heardView=[[MeItemHeardView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, LayOutH(316))];
    @weakify(self);
    heardView.clickHeardBtn=^{
        @strongify(self);
        MeMyInfoViewController *myInfoVc=[[MeMyInfoViewController alloc]init];
        [self.navigationController pushViewController:myInfoVc animated:YES];
    };
    [self.memberDataTableView addSubview:heardView];
    
    self.memberDataTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, LayOutH(316) + 10)];
    self.memberDataTableView.tableFooterView.backgroundColor = HESCOLOR_THEME;
    
    UILabel *tipsLabel = [[UILabel alloc] init];
    tipsLabel.text = @"*会籍资料如有更改，请联系您的会籍顾问";
    tipsLabel.textColor = HESCOLOR(245, 47, 26);
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    tipsLabel.font = [UIFont systemFontOfSize:11.0f];
    [self.memberDataTableView.tableFooterView addSubview:tipsLabel];
    tipsLabel.sd_layout.leftEqualToView(self.memberDataTableView.tableFooterView).rightEqualToView(self.memberDataTableView.tableFooterView).heightIs(44).topSpaceToView(self.memberDataTableView.tableFooterView, 10);
    
    [self.view addSubview:self.memberDataTableView];
    
    // 获取会员资料 暂未用模型
    NSString *vipURL = @"http://60.205.170.209:8080/app/api/vip/1";
    NetworkEngine *networkEngine = [NetworkEngine sharedNetworkEngine];
    [networkEngine getWithURLString:vipURL parameters:nil success:^(id responseObject) {
        NSDictionary *vipDetailsDict = (NSDictionary *)responseObject;
        self.vipDetailsDict = vipDetailsDict;
        NSLog(@"%@", vipDetailsDict);
        [self.memberDataTableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - tableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"id"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"会员编号";
            cell.detailTextLabel.text = @"1";
            break;
        case 1:
            cell.textLabel.text = @"姓名";
            cell.detailTextLabel.text = self.vipDetailsDict[@"realName"];
            break;
        case 2:
            cell.textLabel.text = @"手机号码";
            cell.detailTextLabel.text = self.vipDetailsDict[@"mobile"];
            break;
        case 3:
            cell.textLabel.text = @"性别";
            cell.detailTextLabel.text = self.vipDetailsDict[@"gender"];;
            break;
        case 4:
            cell.textLabel.text = @"联系地址";
            cell.detailTextLabel.text = self.vipDetailsDict[@"contactAddress"];;
            break;
        case 5:
            cell.textLabel.text = @"会员有效期至";
            cell.detailTextLabel.text = self.vipDetailsDict[@"mobile"];;
            break;
        case 6:
            cell.textLabel.text = @"会籍顾问";
            cell.detailTextLabel.text = self.vipDetailsDict[@"mobile"];;
            break;
        case 7:
            cell.textLabel.text = @"会员类型";
            cell.detailTextLabel.text = self.vipDetailsDict[@"mobile"];;
            break;
        case 8:
            cell.textLabel.text = @"客服电话";
            cell.detailTextLabel.text = @"4008123123";
            break;
        default:
            break;
    }
    return cell;
}


//- (void)setVipDetailsDict:(NSDictionary *)vipDetailsDict {
//    _vipDetailsDict = vipDetailsDict;
//    for (int i = 0; i < 9; i++) {
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
//        UITableViewCell *cell = [self.memberDataTableView cellForRowAtIndexPath:indexPath];
//        cell.textLabel.text = vipDetailsDict[@"id"];
//    }
//    
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
