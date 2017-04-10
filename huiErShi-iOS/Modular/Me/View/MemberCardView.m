//
//  MemberCardView.m
//  huiErShi-iOS
//
//  Created by 纪辰 on 2017/2/20.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "MemberCardView.h"

@interface MemberCardView ()
@property (nonatomic, strong) UILabel *buyLabel;
@property (nonatomic, strong) UIImageView *memberCardImageView;
@end

@implementation MemberCardView

- (instancetype)init {
    self = [super init];
    if (self) {
        UIImageView *memberCardImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"card0"]];
        self.memberCardImageView = memberCardImageView;
        [self addSubview:memberCardImageView];
        memberCardImageView.sd_layout.leftEqualToView(self).topEqualToView(self).rightEqualToView(self).bottomEqualToView(self);
        
        UILabel *buyLabel = [[UILabel alloc] init];
        buyLabel.text = self.buyString;
        buyLabel.textColor = [UIColor whiteColor];
        self.buyLabel = buyLabel;
        [memberCardImageView addSubview:buyLabel];
        buyLabel.sd_layout.leftSpaceToView(memberCardImageView,LayOutW(40)).topSpaceToView(memberCardImageView, LayOutH(30)).widthIs(LayOutW(200)).heightIs(LayOutH(44));
        
        UILabel *vipLabel = [[UILabel alloc] init];
        vipLabel.text = @"VIP";
        vipLabel.textColor = [UIColor whiteColor];
        [memberCardImageView addSubview:vipLabel];
        vipLabel.sd_layout.rightSpaceToView(memberCardImageView,LayOutW(40)).bottomSpaceToView(memberCardImageView, LayOutH(30)).widthIs(LayOutW(70)).heightIs(LayOutH(44));
    }
    return self;
}

- (void)setBuyString:(NSString *)buyString {
    _buyString = buyString;
    self.buyLabel.text = buyString;
}

- (void)setCardImageString:(NSString *)cardImageString {
    _cardImageString = cardImageString;
    self.memberCardImageView.image = [UIImage imageNamed:cardImageString];
}

@end
