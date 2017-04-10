//
//  UIViewController+HUD.m
//  LiveStar
//
//  Created by 漪珊 on 2016/12/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIViewController+HUD.h"

static const void *HttpRequestHUDKey = &HttpRequestHUDKey;
@implementation UIViewController (HUD)
- (MBProgressHUD *)HUD
{
    return objc_getAssociatedObject(self, HttpRequestHUDKey);
}

- (void)setHUD:(MBProgressHUD *)HUD
{
    objc_setAssociatedObject(self, HttpRequestHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -- 搁在最前面

- (void)bringToFont
{
    [self.view bringSubviewToFront:[self HUD]];
}


#pragma mark -- 显示提示框 没有限定时间

- (void)showHUDInView:(UIView *)view title:(NSString *)title
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.mode = MBProgressHUDModeIndeterminate;
    if (title == nil) {
        hud.labelText = NSLocalizedString(@"加载中...", @"HUD done title");
    } else {
        hud.labelText = title;
    }
    // Looks a bit nicer if we make it square.
    hud.square = YES;
    [view addSubview:hud];
    [hud show:YES];
    [self setHUD:hud];
}

#pragma mark -- 提示框显示1.5秒

- (void)showTitle:(NSString *)title
{
    //显示提示消息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.userInteractionEnabled = NO;
    HUD.mode = MBProgressHUDModeText;
    if (title == nil) {
        title = @"网络出现错误";
    }
    HUD.labelText = title;
    HUD.margin = 10.f;
    HUD.xOffset = 0;
    HUD.yOffset = 50;
    HUD.removeFromSuperViewOnHide = YES;
    [HUD hide:YES afterDelay:1.5];
}

- (void)showTitle:(NSString *)title
           shaker:(CALayer *)layer
{
    [self showTitle:title];
//    [AnyBoolCommonMethod shakeLayer:layer];
}

- (void)hideHUDWithTitle:(NSString *)titie
{
    [self HUD].mode = MBProgressHUDModeText;
    if (titie == nil) {
        titie = @"网络出现错误";
    }
    [self HUD].labelText = titie;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideHUD];
    });
}

#pragma mark -- 隐藏提示框

- (void)hideHUD
{
    [self HUD].removeFromSuperViewOnHide = YES;
    [[self HUD] hide:YES afterDelay:0];
}

#pragma mark -- 去登陆

- (void)pushToLogin
{
    //    if (![self isKindOfClass:[MyViewController class]]) {
    //        [self backToTabbarSelect:4];
    //        return;
    //    }
//    ABLoginController *login = [ABLoginController new];
//    [self.navigationController pushViewController:login animated:YES];
}

#pragma mark --  退出登录
- (void)outLoginCustomer {
    
}

- (void)creatAlertViewWithTitle:(NSString *)title Message:(NSString *)message Determine:(Determine)determine {
    UIAlertController *alertVc = [UIAlertController  alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert] ;
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        determine();
    }];
    [alertVc addAction:action1];
    [alertVc addAction:action2];
    [self presentViewController:alertVc animated:YES completion:nil];
}
@end
