//
//  ReportViewController.m
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//
#define REUSE_IDENTIFIER [ReportCell description]

#import "ReportViewController.h"
#import "ReportCell.h"
#import "ReportDetailController.h"

@interface ReportViewController ()<UITableViewDelegate,UITableViewDataSource> {
    BOOL close[3];
}
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableView];
}

- (void)creatTableView {
    for (int i = 0; i < 3; i++) {
        close[i] = NO;
    }
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = LayOutH(180);
    self.view = self.tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (close[section]) {
        return 0;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReportCell *cell = [tableView dequeueReusableCellWithIdentifier:REUSE_IDENTIFIER];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ReportCell" owner:nil options:nil].lastObject;
    }
    
    cell.reportImageView.backgroundColor = [UIColor redColor];
    
    cell.reportTypeLabel.text = @"人体成分分析";
    
    cell.reportTimeLabel.text = @"2016年10月19日";
    cell.reportTimeLabel.textColor = HESHEXCOLOR(@"333333");
    
    cell.reportStatusLabel.text = @"已录入 15 项";
    cell.reportStatusLabel.textColor = HESHEXCOLOR(@"333333");
    
    return cell;
}

#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 根据cell的不同类型，跳转不同的报告单详细界面
    ReportDetailController *reportDetailVC = [[ReportDetailController alloc] init];
    [self.navigationController pushViewController:reportDetailVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return LayOutH(88);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *reportSectionHeaderView = [[UIView alloc] init];
    reportSectionHeaderView.backgroundColor = [UIColor whiteColor];
    
    UILabel *sectionTitleLabel = [[UILabel alloc] init];
    sectionTitleLabel.text = (section == 0) ? @"已录入报告" : @"待录入报告";
    sectionTitleLabel.font = LayOutFont(32);
    sectionTitleLabel.textColor = HESHEXCOLOR(@"333333");
    [reportSectionHeaderView addSubview:sectionTitleLabel];
    sectionTitleLabel.sd_layout
    .leftSpaceToView(reportSectionHeaderView, LayOutW(20))
    .topSpaceToView(reportSectionHeaderView, 0)
    .bottomSpaceToView(reportSectionHeaderView, 0)
    .widthIs(LayOutW(200));
    
    UIButton *foldButton = [[UIButton alloc] init];
    foldButton.tag = 100 + section;
    foldButton.backgroundColor = [UIColor redColor];
    [reportSectionHeaderView addSubview:foldButton];
    foldButton.sd_layout
    .rightSpaceToView(reportSectionHeaderView, LayOutW(20))
    .centerYEqualToView(reportSectionHeaderView)
    .widthIs(LayOutW(18))
    .heightIs(LayOutH(10));
    
    [foldButton addTarget:self action:@selector(foldButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *topLine = [[UIView alloc] init];
    topLine.backgroundColor = HESCOLOR(221, 220, 223);
    [reportSectionHeaderView addSubview:topLine];
    topLine.sd_layout
    .leftSpaceToView(reportSectionHeaderView, 0)
    .topSpaceToView(reportSectionHeaderView, 0)
    .rightSpaceToView(reportSectionHeaderView, 0)
    .heightIs(1);
    
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = HESCOLOR(221, 220, 223);
    [reportSectionHeaderView addSubview:bottomLine];
    bottomLine.sd_layout
    .leftSpaceToView(reportSectionHeaderView, 0)
    .bottomSpaceToView(reportSectionHeaderView, 0)
    .rightSpaceToView(reportSectionHeaderView, 0)
    .heightIs(1);
    
    return reportSectionHeaderView;
}

- (void)foldButtonPressed:(UIButton *)sender {
    // 获取 tag
    NSInteger buttonTag = sender.tag - 100;
    close[buttonTag] = !close[buttonTag];
    // 刷新列表
    [self.tableView reloadSection:buttonTag withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
