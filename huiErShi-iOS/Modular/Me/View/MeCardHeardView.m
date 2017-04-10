//
//  MeCardHeardView.m
//  huiErShi-iOS
//
//  Created by 杨森 on 2017/2/11.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "MeCardHeardView.h"

@implementation MeCardHeardView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        
        _isAlreadyBuy=YES;
        
        _alreadyBuyLab=[UILabel new];
        _alreadyBuyLab.tag=101;
        _alreadyBuyLab.text=@"已购买会员";
        _alreadyBuyLab.textColor=HESCOLOR_WORD_BLACK;
        _alreadyBuyLab.textAlignment=NSTextAlignmentCenter;
        _alreadyBuyLab.font=LayOutBOLDFont(32);
        _alreadyBuyLab.userInteractionEnabled=YES;
        [self addSubview:_alreadyBuyLab];
        _alreadyBuyLab.sd_layout
        .topSpaceToView(self,0)
        .bottomSpaceToView(self,0)
        .leftSpaceToView(self,LayOutW(135))
        .widthIs(LayOutW(180));
        
        
        
        _notBuyLab=[UILabel new];
        _notBuyLab.tag=102;
        _notBuyLab.font=LayOutBOLDFont(32);
        _notBuyLab.textColor=HESHEXCOLOR(@"999999");
        _notBuyLab.text=@"可购买会员";
        _notBuyLab.textAlignment=NSTextAlignmentCenter;
        _notBuyLab.userInteractionEnabled=YES;
        [self addSubview:_notBuyLab];
        _notBuyLab.sd_layout
        .topSpaceToView(self,0)
        .bottomSpaceToView(self,0)
        .rightSpaceToView(self,LayOutW(135))
        .widthIs(LayOutW(180));
        
        _line=[UILabel new];
        _line.backgroundColor=HESHEXCOLOR(@"00a652");
        [self addSubview:_line];
        _line.sd_layout
        .bottomSpaceToView(self,0)
        .centerXEqualToView(_alreadyBuyLab)
        .widthIs(LayOutW(180))
        .heightIs(2);
        UITapGestureRecognizer*tapGesture1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actiondo:)];
        [_alreadyBuyLab addGestureRecognizer:tapGesture1];
        
        UITapGestureRecognizer*tapGesture2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actiondo:)];
        [_notBuyLab addGestureRecognizer:tapGesture2];
    }
    return self;
}

-(void)actiondo:(UITapGestureRecognizer*)recognizer{
    
    if (self.isAlreadyBuy) {
        if (recognizer.view.tag==101) {
            return;
        }
    }else{
        if (recognizer.view.tag==102) {
            
            return;
        }
    }
    
    self.isAlreadyBuy=!self.isAlreadyBuy;
}
-(void)setIsAlreadyBuy:(BOOL)isAlreadyBuy{
    _isAlreadyBuy=isAlreadyBuy;
    
    if (isAlreadyBuy) {
        if ([self.delegate respondsToSelector:@selector(switchToLastController)]) {
            [self.delegate switchToLastController];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(switchToNextController)]) {
            [self.delegate switchToNextController];
        }
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        if (isAlreadyBuy) {
            _line.sd_layout
            .centerXEqualToView(_alreadyBuyLab);
            
        }else{
            _line.sd_layout
            .centerXEqualToView(_notBuyLab);
            
        }
        [_line updateLayout];
    } completion:^(BOOL finished) {
        
        _alreadyBuyLab.textColor=isAlreadyBuy?HESCOLOR_WORD_BLACK:HESHEXCOLOR(@"999999");
        _notBuyLab.textColor=isAlreadyBuy?HESHEXCOLOR(@"999999"):HESCOLOR_WORD_BLACK;
    }];
}
@end
