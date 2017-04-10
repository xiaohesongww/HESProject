//
//  TipViewController.m
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "TipViewController.h"
#import "ProjectCell.h"

@interface TipViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation TipViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableView];
    self.navigationItem.title = @"提醒";
    // Do any additional setup after loading the view.
}


- (void)creatTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 7;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProjectCell *cell = [ProjectCell loadNibCellWithTabelView:tableView];
    cell.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:15];
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"无";
    } else if (indexPath.row == 1) {
        cell.titleLabel.text = @"事件发生时";
    } else if (indexPath.row == 2) {
        cell.titleLabel.text = @"5分钟前";
    } else if (indexPath.row == 3) {
        cell.titleLabel.text = @"15分钟前";
    } else if (indexPath.row == 4) {
        cell.titleLabel.text = @"30分钟前";
    } else if (indexPath.row == 5) {
        cell.titleLabel.text = @"1个小时前";
    } else {
        cell.titleLabel.text = @"2个小时前";
    }
    if (cell.isSelected) {
        [cell.selectBtn setImage:GETIMG(@"单选") forState:UIControlStateNormal];
    } else {
        [cell.selectBtn setImage:GETIMG(@"单选框") forState:UIControlStateNormal];
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ProjectCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.isSelected = !cell.isSelected;
    [self.tableView reloadData];
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
