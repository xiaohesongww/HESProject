//
//  ActivityDetailViewController.m
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "ActivityStateCell.h"
#import "ActivityAddressCell.h"
#import "ActivityDetailCell.h"
#import "ActivityMembersCell.h"
#import "JoinActivityModel.h"

@interface ActivityDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableDictionary *_activityDetailDict;//活动详情数据
    NSMutableArray *_membersArray;//参与人员
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSString *urlScheme;
@property (nonatomic, strong) NSString *appName;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@end

@implementation ActivityDetailViewController

#pragma mark -- 活动详情请求
- (void)sendActivityRequest {
//    NSDictionary *dict = @{@"id":@"4"};
    NSString *urlString = [[TEST_URL stringByAppendingString:@"activity/"] stringByAppendingString:@"1"];
    [[NetworkEngine sharedNetworkEngine] getWithURLString:urlString parameters:nil success:^(id responseObject) {
        _activityDetailDict = [NSMutableDictionary dictionaryWithDictionary:responseObject];
        NSArray *array = responseObject[@"members"];
        NSString *coordinate = responseObject[@"coordinate"];
        NSArray *coordinateArr = [coordinate componentsSeparatedByString:@","];
        self.coordinate = CLLocationCoordinate2DMake([coordinateArr[1] doubleValue],[coordinateArr[0] doubleValue]);
        for (NSDictionary *memberDic in array) {
            JoinActivityModel *model = [[JoinActivityModel alloc] initWithDict:memberDic];
            [_membersArray addObject:model];
        }
        [self setUpUI];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark -- 报名
- (void)SendApplyActivityRequest {
    NSString *urlString = [TEST_URL stringByAppendingString:@"activity/1/member/1"];
    [[NetworkEngine sharedNetworkEngine] postWithURLString:urlString parameters:nil success:^(id response) {
        
    } failure:^(NSError *error) {
        
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _membersArray = [NSMutableArray arrayWithCapacity:1];
    [self sendActivityRequest];
    // Do any additional setup after loading the view.
}

#pragma mark -- UI
- (void)setUpUI {
    
    //tableView
    [self creatTableView];
    [self bottomView];
    self.urlScheme = @"huiErShi://";
    self.appName = @"huiErShi";
}

- (void)creatTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight  - 64 - 49) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = [self creatTableHeaderView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.backgroundColor = HESCOLOR(242, 242, 243);
    [self.view addSubview:self.tableView];
}

- (UIView *)creatTableHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:headerView.bounds];
    if (!_activityDetailDict[@"iconUrl"]) {
        _activityDetailDict[@"iconUrl"] = @"";
    }
    [imgView sd_setImageWithURL:[NSURL URLWithString:_activityDetailDict[@"iconUrl"]] placeholderImage:[UIImage imageNamed:@"叹号1"]];
    [headerView addSubview:imgView];
    return headerView;
}

- (void)bottomView {
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 64 - 49, kScreenWidth, 50)];
    UIView *sepline = [[UIView alloc] init];
    [bottomView addSubview:sepline];
    sepline.backgroundColor = HESHEXCOLOR(@"cccccc");
    sepline.sd_layout.topEqualToView(bottomView).leftEqualToView(bottomView).rightEqualToView(bottomView).heightIs(0.5);
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    UILabel *titleLabel = [[UILabel alloc] init];
    NSString *applyCost = [NSString stringWithFormat:@"报名费 : %@元",_activityDetailDict[@"signUpCost"]];
    titleLabel.text = applyCost;
    titleLabel.textColor = HESHEXCOLOR(@"cccccc");
    titleLabel.font = GETFONT(18);
    UIButton *aplyBtn = [[UIButton alloc] init];
    [aplyBtn addTarget:self action:@selector(applyActivity:) forControlEvents:UIControlEventTouchUpInside];
    [aplyBtn setTitle:@"立即报名" forState:UIControlStateNormal];
    aplyBtn.backgroundColor = [UIColor orangeColor];
    aplyBtn.layer.cornerRadius = 5;
    aplyBtn.clipsToBounds = YES;
    [bottomView addSubview:titleLabel];
    [bottomView addSubview:aplyBtn];
    titleLabel.sd_layout.centerYEqualToView(bottomView).leftSpaceToView(bottomView,10).widthIs(kScreenWidth/2).heightIs(40);
    aplyBtn.sd_layout.centerYEqualToView(bottomView).rightSpaceToView(bottomView,10).widthIs(100).heightIs(35);
}

#pragma mark -- tableView 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            ActivityStateCell *cell = [ActivityStateCell loadNibCellWithTabelView:tableView];
            cell.activityName.text = _activityDetailDict[@"name"];
            if ([_activityDetailDict[@"signByUser"] intValue]) {
                cell.signStateImg.image = GETIMG(@"已签到");
                cell.signStaeLabel.text = @"已签到";
            } else {
                cell.signStateImg.image = GETIMG(@"未签到");
                cell.signStaeLabel.text = @"未签到";
            }
            return cell;
        }
        ActivityAddressCell *cell = [ActivityAddressCell loadNibCellWithTabelView:tableView];
        cell.addressLabel.text = _activityDetailDict[@"location"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    } else if (indexPath.section == 1) {
            ActivityDetailCell *cell = [ActivityDetailCell loadNibCellWithTabelView:tableView];
            cell.detailLabel.text = _activityDetailDict[@"description"];
            return cell;
    } else {
        ActivityMembersCell *cell = [ActivityMembersCell loadNibCellWithTabelView:tableView];
        cell.memberArr  = [NSMutableArray arrayWithCapacity:1];
        cell.memberArr = _membersArray;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            [self gotoMap];
        }
    }
}

#pragma mark -- 区头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return nil;
    }
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    sectionView.backgroundColor = HESCOLOR(238, 238, 238);
    UIView *sepline = [[UIView alloc] init];
    sepline.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
    [sectionView addSubview:sepline];
    sepline.sd_layout.leftEqualToView(sectionView).rightEqualToView(sectionView).bottomEqualToView(sectionView).heightIs(0.5);
    return sectionView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return 0.01;
    }
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 80;
        }
        return 44;
    } else if (indexPath.section == 1) {
        return 100;
    } else {
        if (_membersArray.count) {
            return 60;
        }
        return 0.01;
        }
}

- (void)gotoMap {
    __block NSString *urlScheme = self.urlScheme;
    __block NSString *appName = self.appName;
    __block CLLocationCoordinate2D coordinate = self.coordinate;
    NSCharacterSet *chatSet = [NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择地图" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //这个判断其实是不需要的
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"http://maps.apple.com/"]])
    {
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"苹果地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
            MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil]];
            
            [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                           launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
        }];
        
        [alert addAction:action];
    }
    
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]])
    {
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"百度地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=目的地&mode=driving&coord_type=gcj02",coordinate.latitude, coordinate.longitude] stringByAddingPercentEncodingWithAllowedCharacters:chatSet];
            
            NSLog(@"%@",urlString);
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            
        }];
        
        [alert addAction:action];
    }
    
    
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]])
    {
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"高德地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%f&lon=%f&dev=0&style=2",appName,urlScheme,coordinate.latitude, coordinate.longitude] stringByAddingPercentEncodingWithAllowedCharacters:chatSet];
            
            NSLog(@"%@",urlString);
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            
        }];
        
        [alert addAction:action];
    }
    
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]])
    {
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"谷歌地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%f,%f&directionsmode=driving",appName,urlScheme,coordinate.latitude, coordinate.longitude] stringByAddingPercentEncodingWithAllowedCharacters:chatSet];
            
            NSLog(@"%@",urlString);
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            
        }];
        
        [alert addAction:action];
    }
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];

}


#pragma mark -- 活动报名
- (void)applyActivity:(UIButton *)sender {
    [self SendApplyActivityRequest];
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
