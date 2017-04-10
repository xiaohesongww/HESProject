//
//  User.h
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

/**
 用户id
 */
@property (nonatomic, copy) NSString *id;

/**
 用户名
 */
@property (nonatomic, copy) NSString *userName;

/**
 微信开放id
 */
@property (nonatomic, copy) NSString *wechatOpenId;

/**
 微信id
 */
@property (nonatomic, copy) NSString *wechatUnionId;

/**
 用户头像
 */
@property (nonatomic, copy) NSString *iconUrl;

/**
 性别，M:男，F:女
 */
@property (nonatomic, copy) NSString *gender;

/**
 地区
 */
@property (nonatomic, copy) NSString *district;

/**
 日程背景图链接
 */
@property (nonatomic, copy) NSString *agendaBackgroundImageUrl;

/**
 是否接收活动通知
 */
@property (nonatomic, assign) BOOL receiveActivityTrailer;

/**
 日程页面口号
 */
@property (nonatomic, copy) NSString *watchword;

/**
 关注项
 */
@property (nonatomic, strong) NSArray *attentionItems;

@end
