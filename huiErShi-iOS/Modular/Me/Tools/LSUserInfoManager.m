//
//  LSUserInfoManager.m
//  LiveStar
//
//  Created by 漪珊 on 2016/12/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LSUserInfoManager.h"
#import "LSFileCacheManager.h"

static LSUserInfoManager *_singleton = nil;
@implementation LSUserInfoManager

+ (instancetype)sharedManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleton = [[LSUserInfoManager alloc] init];
    });
    return _singleton;
}

// 当前用户信息
- (UserModel *)currentUserInfo {
    return [LSFileCacheManager getObjectByFileName:kUserPath];
}

//获取IM签名
- (NSString *)getUserSign {
    return [LSFileCacheManager getObjectByFileName:kIMUserSign];
}

// 重置用户信息
- (void)resetUserInfoWithUserInfo:(UserModel *)userInfo {
//    [userInfo archive];
}

// 登陆
- (BOOL)didLoginInWithUserInfo:(id)userInfo {
    
    UserModel *userModel = [[UserModel alloc] initWithDict:userInfo];
    if ([LSFileCacheManager saveObject:userModel byFileName:kUserPath]) {
        return YES;
    } else {
        return NO;
    }
}

// 退出登陆
- (void)didLoginOut {
    [LSFileCacheManager removeObjectByFileName:NSStringFromClass([UserModel class])];
}

// 判断是否是登陆状态
- (BOOL)isLogin {
    UserModel *model = [LSFileCacheManager getObjectByFileName:kUserPath];
    NSString *userid = model.id;
    if (userid!=nil&&userid>0) {
        //已登录
        return YES;
    }
    return NO;
}


@end
