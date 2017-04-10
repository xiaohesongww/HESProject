//
//  MemberCardDetailsViewController.m
//  huiErShi-iOS
//
//  Created by 纪辰 on 2017/2/19.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "MemberCardDetailsViewController.h"
#import "MemberCardView.h"

@interface MemberCardDetailsViewController ()
@property (nonatomic, strong) MemberCardView *memberCardView;
@end

@implementation MemberCardDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"会员卡详情";
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.memberCardView.cardImageString = self.cardImageString;
}

- (void)setupUI {
    MemberCardView *memberCardView = [[MemberCardView alloc] init];
    self.memberCardView = memberCardView;
    [self.view addSubview:memberCardView];
    memberCardView.sd_layout.leftSpaceToView(self.view,LayOutW(20)).topSpaceToView(self.view,LayOutH(20)).widthIs(LayOutW(710)).heightIs(LayOutH(400));
    
    UIView *remarkView = [[UIView alloc] init];
    remarkView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:remarkView];
    remarkView.sd_layout.leftEqualToView(self.view).topSpaceToView(memberCardView, LayOutH(20)).rightEqualToView(self.view).heightIs(LayOutH(160));
    
    UIView *topLineView = [[UIView alloc] init];
    topLineView.backgroundColor = HESCOLOR(195, 195, 195);
    [remarkView addSubview:topLineView];
    topLineView.sd_layout.leftEqualToView(remarkView).rightEqualToView(remarkView).heightIs(1).topEqualToView(remarkView);
    
    UIView *midLineView = [[UIView alloc] init];
    midLineView.backgroundColor = HESCOLOR(195, 195, 195);
    [remarkView addSubview:midLineView];
    midLineView.sd_layout.leftSpaceToView(remarkView, LayOutW(20)).rightEqualToView(remarkView).heightIs(1).topSpaceToView(remarkView, LayOutH(80));
    
    UIView *bottomLineView = [[UIView alloc] init];
    bottomLineView.backgroundColor = HESCOLOR(195, 195, 195);
    [remarkView addSubview:bottomLineView];
    bottomLineView.sd_layout.leftEqualToView(remarkView).rightEqualToView(remarkView).heightIs(1).bottomEqualToView(remarkView);
    
    UILabel *tipsLabel = [[UILabel alloc] init];
    tipsLabel.text = @"备注";
    tipsLabel.textColor = HESCOLOR(51, 51, 51);
    [remarkView addSubview:tipsLabel];
    tipsLabel.sd_layout.leftSpaceToView(remarkView, LayOutW(20)).topSpaceToView(remarkView, LayOutH(24)).heightIs(LayOutH(36)).widthIs(LayOutW(180));
    
    UILabel *tipsContentLabel = [[UILabel alloc] init];
    tipsContentLabel.text = @"此卡只能个人使用，不得转借。此卡是您最贵身份的象征，请妥善保管，持此卡消费有6折优惠";
    tipsContentLabel.textColor = HESCOLOR(102, 102, 102);
    tipsContentLabel.numberOfLines = 0;
    tipsContentLabel.font = LayOutFont(20);
    [remarkView addSubview:tipsContentLabel];
    tipsContentLabel.sd_layout.leftSpaceToView(remarkView, LayOutW(20)).topSpaceToView(midLineView, LayOutH(10)).rightSpaceToView(remarkView, LayOutW(10)).bottomSpaceToView(remarkView, LayOutH(10));
    
    UIView *priceView = [[UIView alloc] init];
    priceView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:priceView];
    priceView.sd_layout.leftEqualToView(self.view).bottomEqualToView(self.view).rightEqualToView(self.view).heightIs(LayOutH(120));
    
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.text = @"价格：100元";
    priceLabel.textColor = [UIColor lightGrayColor];
    priceLabel.font = [UIFont systemFontOfSize:20];
    [priceView addSubview:priceLabel];
    priceLabel.sd_layout.leftSpaceToView(priceView, LayOutW(20)).topSpaceToView(priceView,LayOutH(20)).bottomSpaceToView(priceView, LayOutH(20)).widthIs(200);
    
    UIButton *buyButton = [[UIButton alloc] init];
    [buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
    buyButton.backgroundColor = HESCOLOR(250, 124, 11);
    buyButton.layer.cornerRadius = 2;
    buyButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [priceView addSubview:buyButton];
    buyButton.sd_layout.topSpaceToView(priceView, LayOutH(20)).rightSpaceToView(priceView, LayOutW(30)).bottomSpaceToView(priceView, LayOutH(20)).widthIs(120);
    
    [buyButton addTarget:self action:@selector(buyButtonPressed) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setCardImageString:(NSString *)cardImageString {
    _cardImageString = cardImageString;
    self.memberCardView.cardImageString = cardImageString;
}

- (void)buyButtonPressed {
    
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
