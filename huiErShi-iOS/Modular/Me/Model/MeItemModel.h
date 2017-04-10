//
//  MeItemModel.h
//  huiErShi-iOS
//
//  Created by wanjianIOSMacMini on 2017/2/10.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeItemModel : NSObject

@property (nonatomic, copy) NSString *item_img; ///< icon

@property (nonatomic, copy) NSString *item_title; ///< title

@property (nonatomic, assign) BOOL  isGet; ///< 状态

@end
