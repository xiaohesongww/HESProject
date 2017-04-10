//
//  ExpertConsultViewController.m
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "ExpertConsultViewController.h"
#import "TimeCell.h"
#import "ReportConsultCell.h"
#import "DetailDescription.h"
#import "FooterView.h"
#import "ReportConsultViewController.h"
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
@interface ExpertConsultViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ExpertConsultViewController
{
    NSArray *imgArr;
    NSArray *sourceArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HESCOLOR_THEME;
    self.navigationItem.title = @"专家咨询";
    imgArr = @[@"报告分析",@"专家建议",@"参考处方"];
    
//    sourceArr = @[self.dataModel.analysis,self.dataModel.advice,self.dataModel.description];
    [self createUI];
}

#pragma mark -- CreateUI
-(void)createUI
{
    
    UITableView *consultTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,kScreenW, kScreenH-114) style:UITableViewStyleGrouped];
    consultTableView.estimatedRowHeight = 200;
    consultTableView.delegate = self
    ;
    consultTableView.dataSource = self;
    consultTableView.showsVerticalScrollIndicator = NO;
    [consultTableView registerNib:[UINib nibWithNibName:@"TimeCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    [consultTableView registerNib:[UINib nibWithNibName:@"DetailDescription" bundle:nil] forCellReuseIdentifier:@"cell2"];
    [consultTableView registerNib:[UINib nibWithNibName:@"ReportConsultCell" bundle:nil] forCellReuseIdentifier:@"cell3"];
    [self.view addSubview:consultTableView];
    
    FooterView *footview = [[NSBundle mainBundle] loadNibNamed:@"FooterView" owner:self options:nil].lastObject;
    [footview setFrame:CGRectMake(0, kScreenH-114, kScreenW, 50)];
    footview.DownloadDocument.backgroundColor = HESHEXCOLOR(@"00a652");
    [footview.DownloadDocument setTitleColor:HESHEXCOLOR(@"ffffff") forState:UIControlStateNormal];
    [footview.DownloadDocument setFont:[UIFont fontWithName:@"PingFang-SC-Regular" size:13]];
    footview.DownloadDocument.layer.masksToBounds = YES;
    footview.DownloadDocument.layer.cornerRadius = 3;
    [footview setTintColor:HESHEXCOLOR(@"ffffff")];
    [footview.DownloadDocument addTarget:self action:@selector(downloadAttachment) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:footview];
}
#pragma mark--UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 3) {
        return 1;
    }
    return 2;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    TimeCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    DetailDescription *cell2 = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
    ReportConsultCell *cell3 = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    cell2.selectionStyle = UITableViewCellSelectionStyleNone;
    cell3.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section==0||indexPath.section==1||indexPath.section==2) {
        if (indexPath.row == 0) {
            cell1.img.image = [UIImage imageNamed:imgArr[indexPath.section]];
            cell1.YYD.text = imgArr[indexPath.section];
            cell1.YYD.font = [UIFont fontWithName:@"PingFang-SC-Bold" size:16];
            cell1.YYD.textColor = HESHEXCOLOR(@"333333");
            return cell1;
        }
        
        if (indexPath.row == 1) {
//            cell2.descripLabel.text = sourceArr[indexPath.section];
            cell2.descripLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
            cell2.descripLabel.textColor = HESHEXCOLOR(@"333333");
            return cell2;
        }
    }else
    {
        cell3.messageRemind.hidden = YES;
        cell3.reportLabel.font = [UIFont fontWithName:@"PingFang-SC-Bold" size:16];
        return cell3;
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 40;
    }
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
       return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
#pragma mark -- UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
        ReportConsultViewController *vc = [ReportConsultViewController new];
        [self.navigationController pushViewController:vc animated:NO];
    }
}
#pragma mark -- Click
-(void)downloadAttachment
{
    //下载附件
    
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
