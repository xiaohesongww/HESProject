//
//  UIButton+BJTap.m
//  EastGateOrders_Buyers
//
//  Created by 八戒科技-Mr_Sen on 16/7/13.
//  Copyright © 2016年 Mr_Yangsen. All rights reserved.
//

#import "UIButton+SenTap.h"
#import <objc/runtime.h>
static const void*ButtonKey=&ButtonKey;

@implementation UIButton (SenTap)
-(void)tapWithEvent:(UIControlEvents)controlEvent withTapBlock:(TapBlock)block
{
    objc_setAssociatedObject(self, ButtonKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(btnClick:) forControlEvents:controlEvent];
}

-(void)btnClick:(UIButton*)sender
{
   TapBlock block= objc_getAssociatedObject(self, ButtonKey);
    block();
}
@end
