//
//  UricAcidController.m
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "UricAcidController.h"
static NSString * const reuseIdentifier = @"Cell";

@interface UricAcidController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation UricAcidController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"尿酸";
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.view = self.tableView;
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarItemPressed)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"测量时间";
            cell.detailTextLabel.text = @"2016年 10月 28日 上午10:05";
            break;
        case 1:
            cell.textLabel.text = @"测量单位";
            cell.detailTextLabel.text = @"mg";
            break;
        case 2:
            cell.textLabel.text = @"测量值";
            cell.detailTextLabel.text = @"100";
            break;
        case 3:
            cell.textLabel.text = @"数据来源";
            cell.detailTextLabel.text = @"请输入测试设备名称";
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (void)rightBarItemPressed {
    
}

@end
