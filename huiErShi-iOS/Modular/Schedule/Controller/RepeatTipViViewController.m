//
//  RepeatTipViViewController.m
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "RepeatTipViViewController.h"
#import "ProjectCell.h"

@interface RepeatTipViViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_StateArr;
}
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation RepeatTipViViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableView];
    self.navigationItem.title = @"重复";
    _StateArr = [NSMutableArray arrayWithCapacity:1];
    for (int i = 0; i<8; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:@"0" forKey:@"state"];
        [_StateArr addObject:dic];
    }
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
    
    return _StateArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProjectCell *cell = [ProjectCell loadNibCellWithTabelView:tableView];
    cell.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:15];

    if (indexPath.row == 0) {
        cell.titleLabel.text = @"永不";
    } else if (indexPath.row == 1) {
        cell.titleLabel.text = @"每周一";
    } else if (indexPath.row == 2) {
        cell.titleLabel.text = @"每周二";
    } else if (indexPath.row == 3) {
        cell.titleLabel.text = @"每周三";
    } else if (indexPath.row == 4) {
        cell.titleLabel.text = @"每周四";
    } else if (indexPath.row == 5) {
        cell.titleLabel.text = @"每周五";
    } else if (indexPath.row == 6) {
        cell.titleLabel.text = @"每周六";
    } else {
        cell.titleLabel.text = @"每周日";
    }
    NSString *str = _StateArr[indexPath.row][@"state"];
    cell.isSelected = [str integerValue];
    if (cell.isSelected) {
        cell.selectBtn.hidden = NO;
    } else {
        cell.selectBtn.hidden = YES;
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ProjectCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    NSString *str;
//    cell.isSelected = !cell.isSelected;
    if (!cell.isSelected) {
        str = @"1";
    } else {
        str = @"0";
    }
    [_StateArr[indexPath.row] setValue:str forKey:@"state"];
    if (indexPath.row == 0 && !cell.isSelected) {
        for (int i = 0; i<8; i++) {
            if (i!=0) {
                [_StateArr[i] setValue:@"0" forKey:@"state"];
            }
        }
    } else if (indexPath.row != 0 && !cell.isSelected) {
        for (int i = 0; i<8; i++) {
            if (i==0) {
                [_StateArr[i] setValue:@"0" forKey:@"state"];
                
           }
        }
    }
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
