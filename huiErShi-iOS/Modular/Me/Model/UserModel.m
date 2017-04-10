//
//  UserModel.m
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
//编码
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.gender forKey:@"gender"];
    [aCoder encodeObject:self.district forKey:@"district"];
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.id forKey:@"id"];
    [aCoder encodeObject:self.wechatOpenId forKey:@"wechatOpenId"];
    [aCoder encodeObject:self.iconUrl forKey:@"iconUrl"];
    [aCoder encodeObject:self.imuserId forKey:@"imuserId"];
    [aCoder encodeObject:self.receiveActivityTrailer forKey:@"receiveActivityTrailer"];
    [aCoder encodeObject:self.attentionItems forKey:@"attentionItems"];
    [aCoder encodeObject:self.wechatUnionId forKey:@"wechatUnionId"];
}
//解码
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.gender = [aDecoder decodeObjectForKey:@"gender"];
        self.district = [aDecoder decodeObjectForKey:@"district"];
        self.userName = [aDecoder decodeObjectForKey:@"userName"];
        self.id = [aDecoder decodeObjectForKey:@"id"];
        self.wechatOpenId = [aDecoder decodeObjectForKey:@"wechatOpenId"];
        self.iconUrl = [aDecoder decodeObjectForKey:@"iconUrl"];
        self.imuserId = [aDecoder decodeObjectForKey:@"imuserId"];
        self.receiveActivityTrailer = [aDecoder decodeObjectForKey:@"receiveActivityTrailer"];
        self.attentionItems = [aDecoder decodeObjectForKey:@"attentionItems"];
        self.wechatUnionId = [aDecoder decodeObjectForKey:@"wechatUnionId"];
    }    return self;
}

- (NSString *)debugDescription
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        NSString *properName = @(property_getName(property));
        id value = [self valueForKey:properName] ?: @"nil"; //默认值为 nil 字符串
        [mutableDict setObject:value forKey:properName]; //装载到字典里
    }
    free(properties);
    
    return [NSString stringWithFormat:@"<%@: %p> -- %@", [self class], self, mutableDict];
}

@end
