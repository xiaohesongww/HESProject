//
//  MedicineViewController.m
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "MedicineViewController.h"
#import "MedicineCell.h"

static NSString * const reuseIdentifier = @"Cell";

@interface MedicineViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MedicineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = LayOutH(120);
//    [self.tableView registerClass:[MedicineCell class] forCellReuseIdentifier:reuseIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"MedicineCell" bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    self.view = self.tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MedicineCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"MedicineCell" owner:nil options:nil].lastObject;
    }
    cell.medicineNameLabel.text = @"维生素C";
    cell.medicineNameLabel.font = LayOutBOLDFont(32);
    
    cell.medicineDoseLabel.text = @"100mgx1";
    cell.medicineDoseLabel.font = LayOutFont(26);
    
    cell.medicneTimeLabel.text = @"下午01:24";
    cell.medicneTimeLabel.font = LayOutFont(26);
    
    return cell;
}

#pragma mark - TabelView Delegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *medicineSectionHeader = [[UIView alloc] init];
    medicineSectionHeader.backgroundColor = HESCOLOR_THEME;
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.text = @"2016年 10月 29日";
    timeLabel.font = LayOutFont(26);
    timeLabel.textColor = HESHEXCOLOR(@"333333");
    [medicineSectionHeader addSubview:timeLabel];
    timeLabel.sd_layout
    .leftSpaceToView(medicineSectionHeader, LayOutW(20))
    .topSpaceToView(medicineSectionHeader, LayOutH(20))
    .bottomSpaceToView(medicineSectionHeader, LayOutH(20))
    .widthIs(LayOutW(300));
    
    return medicineSectionHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return LayOutH(60);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

// 编辑cell
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [self.tableView deleteRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationAutomatic];
//    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

@end
