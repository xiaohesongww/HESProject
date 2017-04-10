//
//  MeCardHeardView.h
//  huiErShi-iOS
//
//  Created by 杨森 on 2017/2/11.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MeCardHeadViewDelegate <NSObject>
@optional
- (void)switchToNextController;
- (void)switchToLastController;

@end

@interface MeCardHeardView : UIView

@property (nonatomic, strong) UILabel *alreadyBuyLab; ///< 已购买
@property (nonatomic, strong) UILabel *notBuyLab; ///< 未购买
@property (nonatomic, strong) UILabel *line; ///< 线

@property (nonatomic, assign) BOOL isAlreadyBuy; ///< 是不是已经买的

@property (nonatomic, weak) id<MeCardHeadViewDelegate>delegate;

@end
