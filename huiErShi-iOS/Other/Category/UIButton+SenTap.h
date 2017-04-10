//
//  UIButton+SenTap.h
//  EastGateOrders_Buyers
//
//  Created by 八戒科技-Mr_Sen on 16/7/13.
//  Copyright © 2016年 Mr_Yangsen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapBlock)();

@interface UIButton (SenTap)

-(void)tapWithEvent:(UIControlEvents)controlEvent withTapBlock:(TapBlock)block;

@end
