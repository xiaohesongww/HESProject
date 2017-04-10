//
//  UIViewController+HUD.h
//  LiveStar
//
//  Created by 漪珊 on 2016/12/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^Determine)();
@interface UIViewController (HUD)
- (MBProgressHUD *)HUD;

- (void)bringToFont;

/**
 *  显示提示框 没有限定时间
 *
 */
- (void)showHUDInView:(UIView *)view title:(NSString *)title;

/**
 *  提示框显示1.5秒
 *
 *  @param title 提示的文字
 */
- (void)showTitle:(NSString *)title;

/**
 *  提示框
 *
 *  @param title 展示的文字
 *  @param layer 控件
 */
- (void)showTitle:(NSString *)title
           shaker:(CALayer *)layer;

/**
 *  隐藏提示框
 */
- (void)hideHUD;

- (void)hideHUDWithTitle:(NSString *)titie;

/**
 *  去登陆
 */
- (void)pushToLogin;

/**
 *  退出登录
 */
- (void)outLoginCustomer;

/**
   Alert
 */
- (void)creatAlertViewWithTitle:(NSString *)title Message:(NSString *)message Determine:(Determine)determine;
@end
