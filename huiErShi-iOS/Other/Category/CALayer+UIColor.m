//
//  CALayer+UIColor.m
//  huiErShi-iOS
//
//  Created by 纪辰 on 2017/3/16.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "CALayer+UIColor.h"

@implementation CALayer (UIColor)
- (void)setBorderColorFromUIColor:(UIColor *)color {
    self.borderColor = color.CGColor;
}
@end
