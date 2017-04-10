//
//  AppDelegate.m
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "LoginViewController.h"
#import "GuideViewController.h"
@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = NO;
    manager.shouldResignOnTouchOutside = YES;//这个是点击空白区域键盘收缩的开关
    manager.enableAutoToolbar = NO;
    
    [self registLoacalNotifacation];
    [self setUpOptions];
    NSUserDefaults *useDef = [NSUserDefaults standardUserDefaults];
    // 使用 NSUserDefaults 读取用户数据
    if (![useDef boolForKey:@"notFirst"]) {
        // 如果是第一次进入引导页
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.window.rootViewController = [[GuideViewController alloc] init];
        [self.window makeKeyAndVisible];
    }
    else{
        [self PushtoLog];
//        [self setUpGuideControllers];
    }
    return YES;
}

#pragma mark -- 注册本地通知
- (void)registLoacalNotifacation {
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
}

#pragma mark -- 设置视图控制器
- (void)setUpGuideControllers {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    MainTabBarController *tabBarVC = [[MainTabBarController alloc] init];
    self.window.rootViewController = tabBarVC;
    [self.window makeKeyAndVisible];
    return;
}

- (void)PushtoLog {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    LoginViewController *loginVc = [[LoginViewController alloc] init];
    self.window.rootViewController = loginVc;
    [self.window makeKeyAndVisible];
}

#pragma mark -- 配置友盟
- (void)setUpOptions {
    //注册微信
    [WXApi registerApp:@"wxb53ab81910ea6378"];
}


#pragma mark -- 第三方登录授权起调
//#define __IPHONE_10_0    100000
#if __IPHONE_OS_VERSION_MAX_ALLOWED > 100000
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{        // 其他如支付等SDK的回调
    BOOL result = [WXApi handleOpenURL:url delegate:self];
    return result;
}

#endif

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [WXApi handleOpenURL:url delegate:self];
    return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [WXApi handleOpenURL:url delegate:self];
    return result;
}

#pragma mark -- WXApiDelegate

-(void) onReq:(BaseReq*)req {
    
}

- (void)onResp:(BaseResp *)resp {
    NSString *code;
    SendAuthResp *aresp = (SendAuthResp *)resp;
    if (aresp.errCode == 0 && [aresp.state isEqualToString:@"huiErShi_test"]) {
        code = aresp.code;
        NSLog(@"%@",code);
        [self SendRequestWithAuthcode:code];
    }
}

- (void)SendRequestWithAuthcode:(NSString *)code {
    NSDictionary *dic = @{@"code":code};
    NSString *UrlString = [TEST_URL stringByAppendingString:@"token"];
    [[NetworkEngine sharedNetworkEngine] postWithURLString:UrlString parameters:dic success:^(id response) {
        NSString *imUserSign = response[@"im"][@"imUserSign"];
        NSDictionary *userDic = response[@"user"];
        if ([[LSUserInfoManager sharedManager] didLoginInWithUserInfo:userDic]&&[LSFileCacheManager saveObject:imUserSign byFileName:kIMUserSign]) {
            [self setUpGuideControllers];
        }
     } failure:^(NSError *error) {
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
