//
//  LSUserInfoManager.h
//  LiveStar
//
//  Created by 漪珊 on 2016/12/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSUserInfoManager : NSObject
+ (instancetype)sharedManager;
/**
 *  登录成功
 */
- (BOOL)didLoginInWithUserInfo:(id)userInfo;

/**
 *  退出
 */
- (void)didLoginOut;

/**
 *  获取用户信息
 */
- (UserModel *)currentUserInfo;

/**
   获取IM登录签名
 */
- (NSString *)getUserSign;
/**
 *  更新缓存中的用户信息
 */
- (void)resetUserInfoWithUserInfo:(UserModel *)userInfo;

/**
 *  用来记录是否是登陆状态
 */
@property (nonatomic, assign) BOOL isLogin;
@end
