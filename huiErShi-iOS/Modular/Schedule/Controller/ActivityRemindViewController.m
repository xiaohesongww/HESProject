//
//  ActivityRemindViewController.m
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "ActivityRemindViewController.h"
#import "RepeatTipViViewController.h"
#import "TipViewController.h"
#import "HealthTipTextFieldCell.h"
#import "HealthTipNormalCell.h"
#import "TipNormalCell.h"
#import "XHDatePickerView.h"

typedef NS_ENUM(NSInteger, AddTipStyle) {
    AddTipStyleHealth = 0,//健康提醒
    AddTipStyleMedicine,//用药提醒
};
@interface ActivityRemindViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSMutableDictionary *_healthDict;
    NSMutableDictionary *_medicineDict;
}
@property (nonatomic, strong) UITableView *HealthTableView;
@property (nonatomic, strong) UITableView *MedicineTableView;
@property (nonatomic, strong) UIView *titlesView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSMutableArray *titleButtons;
@property (nonatomic, strong) UIView *titleBottomView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong)  XHDatePickerView *datepicker;
@property (nonatomic, assign) AddTipStyle tipStyle;
/**
   提醒共同条件
 */
@property (nonatomic, copy) NSString *presetTime;//提醒提前时间
@property (nonatomic, copy) NSString *repeatRule;//提醒重复规则
@property (nonatomic, copy) NSString *starTime;  //开始时间

/**
   健康提醒设置条件
 */
@property (nonatomic, copy) NSString *itemId;//项目名称


/**
   用药提醒设置条件
 */
@property (nonatomic, copy) NSString *medicalName;//药名
@property (nonatomic, copy) NSString *quantity;   //药量
@property (nonatomic, copy) NSString *unit;       //药量单位

@end

@implementation ActivityRemindViewController
static NSString *healthNormalCell = @"healthNormalCell";

#pragma mark -- 添加健康提醒
- (void)AddhealthRemindRequest {
    if ([self.itemId isEqualToString:@""]||[self.starTime isEqualToString:@""]||[self.presetTime isEqualToString:@""]||[self.repeatRule isEqualToString:@""]) {
        [self showTitle:@"请先完善健康提醒设置..."];
        return;
    }
    NSDictionary *dict = @{@"itemId":self.itemId,
                           @"startAt":self.starTime,
                           @"presetTime":self.presetTime,
                           @"repeatRule":self.repeatRule,
                           @"userId":USER_ID,
                           @"remindType":@"1"};
    NSString *urlString = [TEST_URL stringByAppendingString:@"remind"];
    [[NetworkEngine sharedNetworkEngine] postWithURLString:urlString parameters:dict success:^(id response) {
        [self showTitle:@"药物提醒添加成功..."];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark -- 添加药物提醒
- (void)AddMedicineRemindRequest {
    if ([self.medicalName isEqualToString:@""]||[self.starTime isEqualToString:@""]||[self.unit isEqualToString:@""]||[self.repeatRule isEqualToString:@""]||[self.quantity isEqualToString:@""]||[self.presetTime isEqualToString:@""]) {
        [self showTitle:@"请先完善提醒设置..."];
        return;
    }
    NSDictionary *dict = @{@"medicalName":@"感冒药",
                           @"startAt":@"1008089892",
                           @"presetTime":@"10",
                           @"repeatRule":@"1",
                           @"userId":USER_ID,
                           @"remindType":@"2",
                           @"quantity":@"1",
                           @"unit":@"片"};
    NSString *urlString = [TEST_URL stringByAppendingString:@"remind"];
    [[NetworkEngine sharedNetworkEngine] postWithURLString:urlString parameters:dict success:^(id response) {
        [self showTitle:@"药物提醒添加成功..."];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark -- self.datePicker
- (XHDatePickerView *)datepicker {
    if (!_datepicker) {
        self.datepicker = [[XHDatePickerView alloc] initWithCurrentDate:[NSDate date] CompleteBlock:^(NSDate *startDate, NSDate *endDate) {
        }];
        _datepicker.datePickerStyle = DateStyleShowYearMonthDayHourMinuteSecond;
        _datepicker.dateType = DateTypeStartDate;
    }
    return _datepicker;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self setNav];
    // Do any additional setup after loading the view.
}

#pragma mark -- setNav
- (void)setNav {
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem barButtonItemWithTitle:@"确认" Font:14 TextColor:[UIColor whiteColor] target:self action:@selector(addTips:)];
}


//确认添加
- (void)addTips:(UIButton *)sender {
    switch (self.tipStyle) {
        case AddTipStyleHealth:
            [self AddhealthRemindRequest];
            break;
        case AddTipStyleMedicine:
            [self AddMedicineRemindRequest];
            break;
        default:
            break;
    }
}

#pragma mark -- UI
- (void)setUpUI {
    self.presetTime = @"";
    self.repeatRule = @"";
    self.starTime = @"";
    self.itemId = @"";
    self.medicalName = @"";
    self.quantity = @"";
    self.unit = @"";
    
    _healthDict = [NSMutableDictionary dictionaryWithCapacity:1];
    _medicineDict = [NSMutableDictionary dictionaryWithCapacity:1];

    self.titleButtons = [NSMutableArray arrayWithCapacity:1];
    //tableView
    [self setUpSliderView];
    [self setUpScrollView];
    
    [self creatHealthTableView];
    [self creatMedicineTableView];
    
}

- (void)creatHealthTableView {
    self.HealthTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.HealthTableView.delegate = self;
    self.HealthTableView.dataSource = self;
    self.HealthTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.HealthTableView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:self.HealthTableView];
}


- (void)creatMedicineTableView {
    self.MedicineTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight)];
    self.MedicineTableView.delegate = self;
    self.MedicineTableView.dataSource = self;
    self.MedicineTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.MedicineTableView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:self.MedicineTableView];
}

- (void)setUpSliderView {
    // 标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [UIColor whiteColor];
    titlesView.frame = CGRectMake(0, 0, kScreenWidth, 44);
    self.titlesView = titlesView;
    [self.view addSubview:titlesView];
    CALayer * layer = [titlesView layer];
    [layer setShadowOffset:CGSizeMake(0, -0.5)];
    [layer setShadowRadius:2];
    [layer setShadowOpacity:0.7];
    [layer setShadowColor:[UIColor colorWithHexString:@"999999"].CGColor];
    
    self.titles = @[@"健康提醒",@"用药提醒"];
    NSUInteger count = self.titles.count;
    CGFloat titleButtonH = titlesView.height;
    CGFloat titleButtonW = kScreenWidth/2;
    for (int i = 0; i < count; i++) {
        // 创建
        //        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        UIButton *titleButton = [[UIButton alloc] init];
        titleButton.backgroundColor = [UIColor whiteColor];
        titleButton.titleLabel.font = [UIFont systemFontOfSize:14];
        titleButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
        titleButton.tag = 2000+i;
        [titleButton setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:titleButton];
        [self.titleButtons addObject:titleButton];
        [self.titlesView addSubview:titleButton];
        
        // 文字
        NSString *title = self.titles[i];
        [titleButton setTitle:title forState:UIControlStateNormal];
        
        // frame
        titleButton.frame = CGRectMake(i*titleButtonW, 0, titleButtonW, titleButtonH - 3);
    }
    
    // 标签栏底部的指示器控件
    UIView *titleBottomView = [[UIView alloc] init];
    titleBottomView.backgroundColor = HESHEXCOLOR(@"00a652");
    titleBottomView.height = 3;
    titleBottomView.mj_y = titlesView.height - titleBottomView.height;
    [titlesView addSubview:titleBottomView];
    self.titleBottomView = titleBottomView;
    UIButton *firstTitleButton = self.titleButtons.firstObject;
    [firstTitleButton.titleLabel sizeToFit];
    titleBottomView.width = firstTitleButton.titleLabel.width + 10;
    titleBottomView.centerX = firstTitleButton.centerX;
    [self titleClick:firstTitleButton];
}

- (void)setUpScrollView {
    // 不要自动调整scrollView的contentInset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 44, kScreenWidth, self.view.bounds.size.height);
    scrollView.backgroundColor = [UIColor redColor];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.scrollEnabled = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(self.titles.count * self.view.width, 0);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    // 默认显示第0个控制器
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
}


- (void)titleClick:(UIButton *)sender {
    UIButton *firstTitleButton = self.titleButtons.firstObject;
    if (firstTitleButton == sender) {
        self.tipStyle = AddTipStyleHealth;
    } else {
        self.tipStyle = AddTipStyleMedicine;
    }
    // 底部控件的位置和尺寸
    [UIView animateWithDuration:0.25 animations:^{
        self.titleBottomView.width = sender.titleLabel.width + 10;
        self.titleBottomView.centerX = sender.centerX;
        [self.titleBottomView layoutIfNeeded];
    }];
    for (UIButton *btn in self.titleButtons) {
        if (btn.tag == sender.tag) {
            [btn setTitleColor:HESHEXCOLOR(@"333333") forState:UIControlStateNormal];
        } else {
            [btn setTitleColor:HESHEXCOLOR(@"cccccc") forState:UIControlStateNormal];
        }
    }
    
    CGPoint offset = CGPointMake(kScreenWidth * [self.titleButtons indexOfObject:sender], 0);
    [self.scrollView setContentOffset:offset animated:NO];
}


#pragma mark -- tableView 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.HealthTableView) {
        return 4;
    } else {
        return 6;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.HealthTableView) {
        if (indexPath.row == 0||indexPath.row == 1) {
            if (indexPath.row == 0) {
                HealthTipTextFieldCell *cell = [HealthTipTextFieldCell loadNormalCellWithTabelView:tableView];
                cell.tipTextField.delegate = self;
                cell.titleLabel.text = @"项目";
                cell.tipTextField.placeholder = @"提醒事项名称";
                cell.tipTextField.tag = 2000;
                return cell;
            } else if (indexPath.row == 1) {
                HealthTipNormalCell *cell = [HealthTipNormalCell loadNormalCellWithTabelView:tableView];
                cell.titleLabel.text = @"开始";
                cell.detailLabel.text = @"提醒时间";
                return cell;
            }
        }
        TipNormalCell *cell = [TipNormalCell loadNibCellWithTabelView:tableView];
        if (indexPath.row == 2) {
            cell.titleLabel.text = @"重复";
        } else {
            cell.titleLabel.text = @"提醒";
        }
        return cell;
    } else {
        if (indexPath.row == 4 || indexPath.row == 5) {
            TipNormalCell *cell = [TipNormalCell loadNibCellWithTabelView:tableView];
            if (indexPath.row == 4) {
                cell.titleLabel.text = @"重复";
            } else {
                cell.titleLabel.text = @"提醒";
            }
            return cell;
        }
        HealthTipTextFieldCell *cell = [[HealthTipTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:healthNormalCell];
        cell.tipTextField.delegate = self;
        switch (indexPath.row) {
            case 0:
                cell.titleLabel.text = @"药名";
                cell.tipTextField.placeholder = @"请输入药名";
                cell.tipTextField.tag = 3000;

                break;
            case 1:
                cell.titleLabel.text = @"开始";
                cell.tipTextField.placeholder = @"请输入时间";
                cell.tipTextField.tag = 3001;
                break;
            case 2:
                cell.titleLabel.text = @"单位";
                cell.tipTextField.placeholder = @"请输入单位";
                cell.tipTextField.tag = 3002;
                break;
            case 3:
                cell.titleLabel.text = @"数量";
                cell.tipTextField.placeholder = @"请输入数量";
                cell.tipTextField.tag = 3003;
                break;
                
            default:
                break;
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == self.HealthTableView) {
        switch (indexPath.row) {
            case 1:
                [self.view addSubview:self.datepicker];
                break;
            case 2:{
                RepeatTipViViewController *repeatVc = [[RepeatTipViViewController alloc] init];
                [self.navigationController pushViewController:repeatVc animated:YES];
            }
                break;
            case 3:{
                TipViewController *tipVc = [[TipViewController alloc] init];
                [self.navigationController pushViewController:tipVc animated:YES];
            }
                break;
                
            default:
                break;
        }
    } else {
        switch (indexPath.row) {
            case 4:{
                RepeatTipViViewController *repeatVc = [[RepeatTipViViewController alloc] init];
                [self.navigationController pushViewController:repeatVc animated:YES];
            }
                break;
            case 5:{
                TipViewController *tipVc = [[TipViewController alloc] init];
                [self.navigationController pushViewController:tipVc animated:YES];
            }
                break;
                
            default:
                break;
        }
    }
}

#pragma mark -- 区头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    sectionView.backgroundColor = HESCOLOR(238, 238, 238);
    UIView *sepline = [[UIView alloc] init];
    sepline.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
    [sectionView addSubview:sepline];
    sepline.sd_layout.leftEqualToView(sectionView).rightEqualToView(sectionView).bottomEqualToView(sectionView).heightIs(0.5);
    return sectionView;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    switch (self.tipStyle) {
        case AddTipStyleHealth:
            switch (textField.tag) {
                case 2000:
                    self.itemId = textField.text;
                    break;
                default:
                    break;
            }
            break;
        case AddTipStyleMedicine:
            switch (textField.tag) {
                case 3000:
                    self.medicalName = textField.text;
                    break;
                case 3001:
                    self.starTime = textField.text;
                    break;
                case 3002:
                    self.unit = textField.text;
                    break;
                case 3003:
                    self.quantity = textField.text;
                    break;
                    
                default:
                    break;
            }
            break;
            
        default:
            break;
    }
    return YES;
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
