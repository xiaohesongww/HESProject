//
//  AddMedicineViewController.m
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "AddMedicineViewController.h"
#import "EatMedicineListCell.h"

@interface AddMedicineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *medicineNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (weak, nonatomic) IBOutlet UITextField *unitTextField;
@property (weak, nonatomic) IBOutlet UITextField *numTextField;

@end

@implementation AddMedicineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    [self setUpUI];
    
}

#pragma mark -- setUpUI
- (void)setUpUI {
    self.navigationItem.title = @"添加用药";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.unitTextField.keyboardType = UIKeyboardTypeNamePhonePad;
    self.numTextField.keyboardType = UIKeyboardTypeNumberPad;
}

#pragma mark -- tableView 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EatMedicineListCell *cell = [EatMedicineListCell loadNibCellWithTabelView:tableView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -- 区头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 30)];
    sectionHeaderView.backgroundColor = HESCOLOR(238, 238, 238);
    UILabel *label = [[UILabel alloc] init];
    label.text = @"最近用药情况";
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor grayColor];
    [sectionHeaderView addSubview:label];
//    label.sd_layout.centerYEqualToView(sectionHeaderView).leftSpaceToView(sectionHeaderView,15);
    label.frame = CGRectMake(15, 0, kSCREEN_WIDTH, 30);
    return sectionHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
