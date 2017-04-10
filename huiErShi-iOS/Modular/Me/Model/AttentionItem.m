//
//  AttentionItem.m
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "AttentionItem.h"

@implementation AttentionItem
/**
 初始化
 
 @param dict 字典
 @return 用户模型
 */
- (instancetype)initWithNSDictionary:(NSDictionary *)dict {
    if (self == [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
@end
