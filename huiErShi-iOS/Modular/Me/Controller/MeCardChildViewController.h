//
//  MeCardChildViewController.h
//  huiErShi-iOS
//
//  Created by 杨森 on 2017/2/11.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 类型
 */

typedef NS_ENUM(NSUInteger, MeCardChildItemType) {
    MeCardChildItemTypeAlreadyBuy, ///< 已经购买
    MeCardChildItemTypeNotBuy, ///< 可购买
};

@interface MeCardChildViewController : UIViewController
@property (nonatomic, assign) MeCardChildItemType type; ///< 类型
@end
