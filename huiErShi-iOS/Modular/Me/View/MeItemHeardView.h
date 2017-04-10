//
//  MeItemHeardView.h
//  huiErShi-iOS
//
//  Created by 杨森 on 2017/2/10.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeItemHeardView : UIView

@property (nonatomic, strong) UIButton *heardBtn; ///< 头像按钮
@property (nonatomic, strong) UILabel *nikeNameLab; ///< 昵称
@property (nonatomic, copy) void(^clickHeardBtn)(); ///< 点击头像


@end
