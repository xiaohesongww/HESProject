//
//  AttentionItem.h
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AttentionItem : NSObject
/*
 unit (string, optional): 项目单位，如 克,
 canAddByUser (boolean, optional): 是否可由用户自己添加项目记录,
 itemId (string, optional): 项目id，项目英文缩写,
 spell (string, optional): 项目名称拼音,
 minReference (number, optional): 最小参考值，数值型,
 maxReference (number, optional): 最大参考值，数值型,
 minInputCount (integer, optional): 最少输入字符数，文本型,
 maxInputCount (integer, optional): 最多输入字符数，文本型,
 selections (string, optional): 可选标签，多个标签用','分隔，选择型,
 radio (boolean, optional): 是否单选，0-可多选，1-只能单选，选择型,
 description (string, optional): 描述,
 name (string, optional): 项目名称,
 type (ItemType, optional) = ['None' or 'Numeric' or 'Text' or 'Selection']: 项目类型，1-数值型，2-文本型，3-选择型
 */

/**
 项目单位，如 克
 */
@property (nonatomic, copy) NSString *unit;

/**
 是否可由用户自己添加项目记录
 */
@property (nonatomic, assign) BOOL canAddByUser;

/**
 项目id，项目英文缩写
 */
@property (nonatomic, copy) NSString *itemId;

/**
 最小参考值，数值型
 */
@property (nonatomic, strong) NSNumber *minReference;

/**
 最大参考值，数值型
 */
@property (nonatomic, strong) NSNumber *maxReference;

/**
 最少输入字符数，文本型
 */
@property (nonatomic, assign) NSInteger minInputCount;

/**
 最多输入字符数，文本型
 */
@property (nonatomic, assign) NSInteger maxInputCount;

/**
 可选标签，多个标签用','分隔，选择型
 */
@property (nonatomic, copy) NSString *selections;

/**
 是否单选，0-可多选，1-只能单选，选择型
 */
@property (nonatomic, assign) BOOL radio;

/**
 描述
 */
@property (nonatomic, copy) NSString *description;

/**
 项目名称
 */
@property (nonatomic, copy) NSString *name;

/**
 ['None' or 'Numeric' or 'Text' or 'Selection']: 项目类型，1-数值型，2-文本型，3-选择型
 */
@property (nonatomic, copy) NSString *type;
@end
