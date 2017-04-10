//
//  ScheduleDetailViewController.m
//  huiErShi-iOS
//
//  Created by 漪珊 on 2017/3/5.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "ScheduleDetailViewController.h"
#import "SZCalendarPicker.h"

@interface ScheduleDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *CanlendarView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *CanlendarHeightConstraint;

@end

@implementation ScheduleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"日程";
    [self setUpUI];
    // Do any additional setup after loading the view from its nib.
}


#pragma mark -- setUpUI
- (void)setUpUI {
    [self setCanlendar];
    [self setTableView];
}

//设置日历
- (void)setCanlendar {
    SZCalendarPicker *calendarPicker = [SZCalendarPicker showOnView:self.CanlendarView];
    calendarPicker.today = [NSDate date];
    calendarPicker.date = calendarPicker.today;
    //    calendarPicker.frame = CGRectMake(0, 0, 330, 352);
    calendarPicker.sd_layout.topEqualToView(self.CanlendarView).rightEqualToView(self.CanlendarView).leftEqualToView(self.CanlendarView).bottomEqualToView(self.CanlendarView);
    calendarPicker.calendarBlock = ^(NSInteger weekDay, NSInteger day, NSInteger month, NSInteger year){
        
        NSLog(@"%li年%li月%li日 星期%li", (long)year,(long)month,day,weekDay);
    };
}

//tableView
- (void)setTableView {
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
}

#pragma mark -- tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
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
