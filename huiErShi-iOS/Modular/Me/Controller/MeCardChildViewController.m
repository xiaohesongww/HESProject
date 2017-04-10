//
//  MeCardChildViewController.m
//  huiErShi-iOS
//
//  Created by 杨森 on 2017/2/11.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "MeCardChildViewController.h"
#import "MemberCardDetailsViewController.h"
#import "MemberCardView.h"

@interface MeCardChildViewController ()
@property (nonatomic, strong) UIScrollView *cardScrollView;
@end

@implementation MeCardChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    self.view.backgroundColor=_type==MeCardChildItemTypeAlreadyBuy ?[UIColor redColor]:[UIColor greenColor];
    
    UIScrollView *cardScrollView = [[UIScrollView alloc] init];
    self.cardScrollView = cardScrollView;
    //初始化最底部的scrollView
    cardScrollView.backgroundColor = [UIColor clearColor];
    cardScrollView.pagingEnabled = YES;
    cardScrollView.bounces = NO;
    cardScrollView.showsHorizontalScrollIndicator = NO;
    cardScrollView.delegate = (id<UIScrollViewDelegate>)self;
    [self.view addSubview:cardScrollView];
    
    cardScrollView.sd_layout.leftEqualToView(self.view).topEqualToView(self.view).rightEqualToView(self.view).bottomEqualToView(self.view);
    
    if (self.type == MeCardChildItemTypeAlreadyBuy) {
        NetworkEngine *sharedNetworkEngine = [NetworkEngine sharedNetworkEngine];
        NSString *urlString = @"http://60.205.170.209:8080/app/api/vipCard?userId=1";
        [sharedNetworkEngine getWithURLString:urlString parameters:nil success:^(id responseObject) {
            
            NSLog(@"%@", responseObject);
            NSArray *userVipCardArray = responseObject[@"UserVipCard"];
            [self showBuyCardWithArray:userVipCardArray];
            
        } failure:^(NSError *error) {
            
            NSLog(@"%@", error);
        }];
        
    } else if (self.type == MeCardChildItemTypeNotBuy) {
        
        
        NetworkEngine *sharedNetworkEngine = [NetworkEngine sharedNetworkEngine];
        NSString *urlString = @"http://60.205.170.209:8080/app/api/vipCard?userId=1";
        [sharedNetworkEngine getWithURLString:urlString parameters:nil success:^(id responseObject) {
            
            NSLog(@"%@", responseObject);
            NSArray *vipCardArray = responseObject[@"VipCard"];
            [self showSellCardWithArray:vipCardArray];
            
        } failure:^(NSError *error) {
            
            NSLog(@"%@", error);
        }];
    }
    
}

// 展示已经购买会员
- (void)showBuyCardWithArray:(NSArray *)array {
    
    for (int i = 0; i < array.count ; i++) {
        NSDictionary *userVipCard = array[i];
        NSNumber *activated = userVipCard[@"activated"];
        
        MemberCardView *memberCard = [[MemberCardView alloc] init];
        memberCard.cardImageString = [NSString stringWithFormat:@"card%d", i];
        
        if (activated.intValue == 0) {
            memberCard.buyString = @"未激活";
        } else if (activated.intValue == 1) {
            memberCard.buyString = @"已激活";
        }
        
        [self.cardScrollView addSubview:memberCard];
        
        memberCard.sd_layout.leftSpaceToView(self.cardScrollView,LayOutW(20)).topSpaceToView(self.cardScrollView,LayOutH(20) * (i +1) + LayOutH(400) * i).widthIs(LayOutW(710)).heightIs(LayOutH(400));
    }
    
    self.cardScrollView.contentSize = CGSizeMake(0, LayOutH(420) * array.count +LayOutH(200));
}

/**
 显示可购买的会员卡
 */
- (void)showSellCardWithArray:(NSArray *)array {
    
    for (int i=0; i < array.count; i++) {
        MemberCardView *memberCard = [[MemberCardView alloc] init];
        memberCard.buyString = @"立即购买";
        memberCard.cardImageString = [NSString stringWithFormat:@"card%d", i];
        memberCard.tag = 100 + i;
        UITapGestureRecognizer*tapGesture1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actiondo:)];
        [memberCard addGestureRecognizer:tapGesture1];
        [self.cardScrollView addSubview:memberCard];
        
        memberCard.sd_layout.leftSpaceToView(self.cardScrollView,LayOutW(20)).topSpaceToView(self.cardScrollView,LayOutH(20) * (i +1) + LayOutH(400) * i).widthIs(LayOutW(710)).heightIs(LayOutH(400));
    }
    
    UILabel *servicePhone = [[UILabel alloc] init];
    servicePhone.text = @"客服电话：4008123123";
    servicePhone.font=LayOutBOLDFont(26);
    servicePhone.textColor = HESHEXCOLOR(@"fe30000");
    servicePhone.textAlignment=NSTextAlignmentCenter;
    [self.cardScrollView addSubview:servicePhone];
    servicePhone.sd_layout.leftEqualToView(self.cardScrollView).topSpaceToView(self.cardScrollView, LayOutH(20) * (array.count +1) + LayOutH(400) * array.count + LayOutH(60)).rightEqualToView(self.cardScrollView).heightIs(LayOutH(44));
    
    self.cardScrollView.contentSize = CGSizeMake(0, LayOutH(420) * array.count +LayOutH(200));
}

-(void)actiondo:(UITapGestureRecognizer*)recognizer{
    MemberCardView *memberCardView = (MemberCardView *)recognizer.self.view;
    MemberCardDetailsViewController *memberCardDetailsVC = [[MemberCardDetailsViewController alloc] init];
    memberCardDetailsVC.cardImageString = memberCardView.cardImageString;
    [self.navigationController pushViewController:memberCardDetailsVC animated:YES];
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
