//
//  MeItemHeardView.m
//  huiErShi-iOS
//
//  Created by 杨森 on 2017/2/10.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "MeItemHeardView.h"

@implementation MeItemHeardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView*bgImgView=[UIImageView new];
        bgImgView.image=GETIMG(@"me_bg");
        [self addSubview:bgImgView];
        bgImgView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
        
        _heardBtn=[UIButton new];
        _heardBtn.backgroundColor = [UIColor redColor];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if ([userDefaults objectForKey:@"iconPhoto"]) {
            NSData *iconPhoto = [userDefaults objectForKey:@"iconPhoto"];
            UIImage *icon = [UIImage imageWithData:iconPhoto];
            [_heardBtn setBackgroundImage:icon forState:UIControlStateNormal];
        } else {
            [_heardBtn setBackgroundImage:GETIMG(@"heard") forState:UIControlStateNormal];
        }
        
        _heardBtn.layer.masksToBounds=YES;
        _heardBtn.layer.cornerRadius=LayOutW(120);
        
        [self addSubview:_heardBtn];
        _heardBtn.sd_layout
        .centerXEqualToView(self)
        .topSpaceToView(self,0)
        .widthIs(LayOutW(240))
        .heightIs(LayOutW(240));
        
        
        _nikeNameLab=[UILabel new];
        _nikeNameLab.textColor=[UIColor whiteColor];
        _nikeNameLab.textAlignment=NSTextAlignmentCenter;
        _nikeNameLab.font=LayOutFont(36);
    
        if ([userDefaults objectForKey:@"nickname"]) {
            _nikeNameLab.text = [userDefaults objectForKey:@"nickname"];
        } else {
            _nikeNameLab.text=@"loongcrown";
        }
        
        [self addSubview:_nikeNameLab];
        
        _nikeNameLab.sd_layout.centerXEqualToView(self)
        .topSpaceToView(_heardBtn,0)
        .bottomSpaceToView(self,0)
        .widthIs(kScreenWidth);
        
        @weakify(self);
        [_heardBtn tapWithEvent:UIControlEventTouchUpInside withTapBlock:^{
            @strongify(self);
            self.clickHeardBtn();
        }];
        
    }
    return self;
}

@end
