//
//  ExpertViewController.m
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "ExpertViewController.h"
#import "JudgeVip.h"
#import "HeadView.h"
#import "TimeCell.h"
#import "ExpertCell.h"
#import "ReportConsultCell.h"
#import "FeiVipIntroduceCell.h"
#import "FeiVipSecondCell.h"
#import "MeMemberCardViewController.h"
#import "MeViewController.h"
#import "VIPReportSource.h"
#import "ExpertConsultViewController.h"
#import "ReportConsultViewController.h"
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
@interface ExpertViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ExpertViewController
{
    UITableView *vipTableView;
    UITableView *feiVipTableView;
    HeadView *headView;
    NSMutableArray *vipConsultArr;
    NSMutableArray *_sourceArr;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    _sourceArr = [NSMutableArray arrayWithCapacity:1];
    self.view.backgroundColor=HESCOLOR_THEME;
    self.tabBarItem.title=@"专家指导";
    [self judgeVIP];
   
}
#pragma mark-- DataManager
-(void)judgeVIP
{
    NSString *vipURL = @"http://60.205.170.209:8080/app/api/vip/8";
    NetworkEngine *networkEngine = [NetworkEngine sharedNetworkEngine];
    [networkEngine getWithURLString:vipURL parameters:nil success:^(id responseObject) {
        NSLog(@"判断是不是会员返回的数据＝＝%@",responseObject);
        if ([responseObject objectForKey:@"vipCard"]!=nil) {
            JudgeVip *model = [[JudgeVip alloc]initWithDictionary:[responseObject objectForKey:@"vipCard"] error:nil];
            NSLog(@"model = %@",model);
            if (model.activated && [model.vipCard objectForKey:@"canConsult"]) {
                //为会员
                vipConsultArr = [[NSMutableArray alloc]init];
                [self VIPReportSource];
                [self createVipUI];
            }else
            {
                //非会员
                [self CreateNoVipUI];
            }
        }
        else
        {
            //非会员
            
            [self CreateNoVipUI];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    

}
-(void)VIPReportSource
{
    NSString *urlStr = @"http://60.205.170.209:8080/app/api/report?userId=8&page=0&pageNum=10";
    NetworkEngine *networkengine = [NetworkEngine sharedNetworkEngine];
    [networkengine getWithURLString:urlStr parameters:nil success:^(id responseObject) {
        NSLog(@"会员资源报告返回的数据＝＝ %@",responseObject);
       
        NSArray *content = [responseObject objectForKey:@"content"];
        
        for(NSDictionary *dic in content)
        {
            VIPReportSource *reportsource = [[VIPReportSource alloc]initWithDictionary:dic error:nil];
            [_sourceArr addObject:reportsource];
            NSMutableArray *consultArr = [[NSMutableArray alloc]init];
            for(NSDictionary *dic in reportsource.consults)
            {
                ConsultModel *model = [[ConsultModel alloc]initWithDictionary:dic error:nil];
                [consultArr addObject:model];
            }
            [vipConsultArr addObject:consultArr];//分为几个区
        }
        NSLog(@"有%ld分区",vipConsultArr.count);
        [vipTableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"error == %@",error.domain);
    }];
}
#pragma mark - CreateUI
-(void)createVipUI
{
    vipTableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 0, kScreenW-20, kScreenH-114) style:UITableViewStyleGrouped];
    vipTableView.delegate = self;
    vipTableView.dataSource = self;
    [vipTableView registerNib:[UINib nibWithNibName:@"TimeCell" bundle:nil] forCellReuseIdentifier:@"TimeCell"];
    [vipTableView registerNib:[UINib nibWithNibName:@"ExpertCell" bundle:nil] forCellReuseIdentifier:@"ExpertCell"];
    [vipTableView registerNib:[UINib nibWithNibName:@"ReportConsultCell" bundle:nil] forCellReuseIdentifier:@"ReportConsultCell"];
    vipTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:vipTableView];
}
-(void)CreateNoVipUI
{
    
    feiVipTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-64) style:UITableViewStyleGrouped];
    feiVipTableView.showsVerticalScrollIndicator = NO;
    feiVipTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    feiVipTableView.delegate = self;
    feiVipTableView.dataSource = self;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 40)];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((kScreenW-300)/2, 0, 300, 40)];
    [view addSubview:btn];
    view.backgroundColor = HESCOLOR_THEME;
    btn.backgroundColor = HESHEXCOLOR(@"fa7c0b");
    [btn setTitle:@"购买会员卡" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goToBuyVIP) forControlEvents:UIControlEventTouchUpInside];
    btn.clipsToBounds = YES;
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 3;
    feiVipTableView.tableFooterView = view;
    
    [feiVipTableView registerNib:[UINib nibWithNibName:@"FeiVipIntroduceCell" bundle:nil] forCellReuseIdentifier:@"FeiVipCell"];
    [feiVipTableView registerNib:[UINib nibWithNibName:@"FeiVipSecondCell" bundle:nil]forCellReuseIdentifier:@"feiVipSecondCell"];
    [self.view addSubview:feiVipTableView];
    
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == feiVipTableView) {
          return 3;
    }
    return vipConsultArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == feiVipTableView) {
        if (section==1) {
            return 3;
        }
        return 0;
    }
    return 5;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cellnil
    = nil;
    if (tableView == feiVipTableView) {
        FeiVipIntroduceCell *cell = [feiVipTableView dequeueReusableCellWithIdentifier:@"FeiVipCell"];
        FeiVipSecondCell *secondCell = [feiVipTableView dequeueReusableCellWithIdentifier:@"feiVipSecondCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        secondCell.selectionStyle = UITableViewCellSelectionStyleNone;
        secondCell.backgroundColor = HESCOLOR_THEME;
        secondCell.back.backgroundColor = [UIColor whiteColor];
        cell.backgroundColor = HESCOLOR_THEME;
        cell.back.backgroundColor = [UIColor whiteColor];
        secondCell.clipsToBounds = YES;
        secondCell.layer.masksToBounds = YES;
        secondCell.layer.cornerRadius = 3;
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                
                secondCell.imageView.image = [UIImage imageNamed:@"个人健康风险"];
                secondCell.img1.image = secondCell.img2.image = secondCell.img3.image = [UIImage imageNamed:@"项目1"];
                secondCell.headTitle.text = @"个人健康风险评估与干预";
                secondCell.title1.text = @"个人健康数据档案";
                secondCell.title2.text = @"评估个人健康危险因素";
                secondCell.title3.text = @"个性化指导方案及效果跟踪";
            }
            if (indexPath.row == 1) {
                cell.headImg.image = [UIImage imageNamed:@"慢病治疗"];
                cell.headTitle.text = @"慢性治疗与监测";
                cell.image1.image = cell.image2.image = cell.image3.image = cell.image4.image = [UIImage imageNamed:@"项目2"];
                cell.title1.text = @"慢病日程管理";
                cell.title2.text = @"定期专项深度检查";
                cell.title3.text = @"在线调整治疗方案";
                cell.title4.text = @"分组咨询沙龙";
                return cell;
            }
            if (indexPath.row == 2) {
                secondCell.headImg.image = [UIImage imageNamed:@"线下活动"];
                secondCell.headTitle.text = @"线下活动与健康教育";
                secondCell.img1.image = secondCell.img2.image = secondCell.img3.image = [UIImage imageNamed:@"项目3"];
                secondCell.title1.text = @"活动信息发布, 报名";
                secondCell.title2.text = @"线下讲座, 健康宣教";
                secondCell.title3.text = @"将康知识资讯";
            }
            return secondCell;
            
        }

    }
    else if (tableView == vipTableView)
    {
        
        if (indexPath.row == 0) {
            TimeCell *timecell = [tableView dequeueReusableCellWithIdentifier:@"TimeCell"];
            timecell.selectionStyle = UITableViewCellSelectionStyleNone;
            [timecell.YYD setFont:[UIFont fontWithName:@"PingFang-SC-Regular" size:16]];
            timecell.YYD.textColor = HESHEXCOLOR(@"00a652");
            
            return timecell;
        }
        if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3) {
            
            ExpertCell *expertcell = [tableView dequeueReusableCellWithIdentifier:@"ExpertCell"];
            expertcell.name.textColor =   expertcell.professionalTitle.textColor = HESHEXCOLOR(@"333333");
            expertcell.name.font = [UIFont fontWithName:@"PingFang-SC-Bold" size:16];
            expertcell.professionalTitle.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:16];
            
            expertcell.selectionStyle = UITableViewCellSelectionStyleNone;
//            ConsultModel *model = vipConsultArr[indexPath.section][indexPath.row];
//            AdminModel *model2 = [[AdminModel alloc]initWithDictionary:model.admin error:nil];
//            expertcell.descLabel.text = model.analysis? :@"";
//            expertcell.name.text = model2.name? :@"";
//            expertcell.professionalTitle.text = model2.job? :@"";
//            [expertcell.headImg sd_setImageWithURL:[NSURL URLWithString:model2.iconUrl]];
//            
            return expertcell;
        }
        if (indexPath.row == 4) {
            ReportConsultCell *reportcell = [tableView dequeueReusableCellWithIdentifier:@"ReportConsultCell"];
            reportcell.textLabel.textColor = HESHEXCOLOR(@"333333");
            reportcell.textLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:16];
            reportcell.selectionStyle = UITableViewCellSelectionStyleNone;
            return reportcell;
        }
    }
        return cellnil;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 10)];
    if (tableView == feiVipTableView) {
        if (section == 0) {
            headView = [[NSBundle mainBundle] loadNibNamed:@"HeadView" owner:self options:nil].lastObject;
            headView.frame  = CGRectMake(0, 0, kScreenW, 120);
            headView.backgroundColor = HESHEXCOLOR(@"00a652");
            return headView;
        }
     
    }
       return view;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == feiVipTableView) {
        if (section == 0) {
            return 120;
        }
    }
        return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView == feiVipTableView) {
        if (section==1) {
            return 10;
        }
    }
   
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==feiVipTableView) {
        if (indexPath.section == 1) {
            if (indexPath.row == 1) {
                return 128;
            }
            return 105;
        }
    }
    if (tableView == vipTableView) {
       
        if (indexPath.row == 1 ||indexPath.row == 2 || indexPath.row == 3) {
            return 180;
        }
        return 44;
    }
    return 0.1;
}


#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == vipTableView) {
        if (indexPath.row == 4) {
            ReportConsultViewController *vc = [ReportConsultViewController new];
            [self.navigationController pushViewController:vc animated:NO];
        }
        if (indexPath.row == 1|| indexPath.row == 2|| indexPath.row == 3) {
            ExpertConsultViewController *vc = [ExpertConsultViewController new];
            ConsultModel *model = vipConsultArr[indexPath.section][indexPath.row];
            NSLog(@"model == %@",model);
            vc.dataModel = model;
            [self.navigationController pushViewController:vc animated:NO];
        }
        
    }
}
#pragma mark--click
-(void)goToBuyVIP
{
    MeMemberCardViewController *vc = [MeMemberCardViewController new];
    self.tabBarController.selectedIndex = 4;
  
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
