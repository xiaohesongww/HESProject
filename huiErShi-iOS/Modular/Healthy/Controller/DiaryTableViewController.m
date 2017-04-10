//
//  DiaryTableViewController.m
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "DiaryTableViewController.h"
#import "AddFoodFootView.h"
#import "DiaryFooterView.h"
#import "DiarySportSectionHeaderView.h"
#import "DiarySportCell.h"
#import "AddDietController.h"
#import "AddSportController.h"

static NSString * const reuseIdentifierSport = @"SportCell";
static NSString * const reuseIdentifier = @"Cell";

@interface DiaryTableViewController ()<UITableViewDelegate,UITableViewDataSource, DiaryFooterDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation DiaryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    self.view.backgroundColor = [UIColor redColor];
}

#pragma mark -- UI
- (void)setUpUI {
    
    //tableView
    [self creatTableView];
    
}

- (void)creatTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    DiaryFooterView *diaryFooterView = [[NSBundle mainBundle] loadNibNamed:@"DiaryFooterView" owner:self options:nil].lastObject;
    diaryFooterView.footerDelegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"DiarySportCell" bundle:nil] forCellReuseIdentifier:reuseIdentifierSport];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    self.tableView.tableFooterView = diaryFooterView;
    [self.tableView addSubview:self.tableView.tableFooterView];
}

#pragma mark -- tableView 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 5) {
        DiarySportCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierSport forIndexPath:indexPath];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"DiarySportCell" owner:self options:nil].lastObject;
        }
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark -- 区头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 5) {
        DiarySportSectionHeaderView *sportSectionHeaderView = [[NSBundle mainBundle] loadNibNamed:@"DiarySportSectionHeaderView" owner:self options:nil].lastObject;
        return sportSectionHeaderView;
    }
    
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 30)];
    sectionView.backgroundColor = HESCOLOR(238, 238, 238);
    UILabel *titleLabel = [[UILabel alloc] init];
    switch (section) {
        case 0:
            titleLabel.text = @"早餐";
            break;
        case 1:
            titleLabel.text = @"午餐";
            break;
        case 2:
            titleLabel.text = @"晚餐";
            break;
        case 3:
            titleLabel.text = @"零食";
            break;
        case 4:
            titleLabel.text = @"备注(饮食)";
            break;
        case 5:
            titleLabel.text = @"运动";
            break;
        case 6:
            titleLabel.text = @"备注(运动)";
            break;
        default:
            break;
    }
    
    titleLabel.textColor = HESHEXCOLOR(@"333333");
    titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    UILabel *desc = [[UILabel alloc] init];
    desc.text = @"用餐标准时间";
    desc.textColor = HESHEXCOLOR(@"999999");
    desc.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
    
    [sectionView addSubview:titleLabel];
    [sectionView addSubview:desc];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sectionView.mas_left).offset(15);
        make.centerY.equalTo(sectionView);
    }];
    [desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(sectionView.mas_right).offset(-15);
        make.centerY.equalTo(sectionView);
    }];

    return sectionView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    AddFoodFootView *footView = [[NSBundle mainBundle] loadNibNamed:@"AddFoodFootView" owner:self options:nil].lastObject;
    footView.titleLabel.text = @"添加食物";
    if (section == 5) {
        footView.titleLabel.text = @"添加运动";
    }
    footView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, 44);
    footView.tag = 2000 + section;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [footView addGestureRecognizer:tapGesture];
    
    // 需要计算
    self.tableView.contentSize = CGSizeMake(kSCREEN_WIDTH, 1000);
    return footView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)handleTap:(UITapGestureRecognizer *)gesture {
    if (gesture.view.tag == 2005) {
        AddSportController *addSportVC = [[AddSportController alloc] init];
        [self.navigationController pushViewController:addSportVC animated:YES];
        return;
    }
    AddDietController *addDietVC = [[AddDietController alloc] init];
    [self.navigationController pushViewController:addDietVC animated:YES];
}

- (void)diaryFooterViewCheckNutrition {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
