//
//  UserModel.h
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "QZHModel.h"

@interface UserModel : QZHModel<NSCoding>
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *district;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *wechatOpenId;
@property (nonatomic, copy) NSString *iconUrl;
@property (nonatomic, copy) NSString *imuserId;
@property (nonatomic, copy) NSString *receiveActivityTrailer;
@property (nonatomic, copy) NSString *attentionItems;
@property (nonatomic, copy) NSString *wechatUnionId;
@end
