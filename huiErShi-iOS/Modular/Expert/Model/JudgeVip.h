//
//  JudgeVip.h
//  huiErShi-iOS
//
//  Created by apple on 17/3/3.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "JSONModel.h"

@interface JudgeVip : JSONModel
@property (nonatomic,strong) NSString *activated;
@property (nonatomic,strong) NSString *expiredAt;//会员过期时间
@property (nonatomic,strong) NSDictionary *vipCard;

@end
