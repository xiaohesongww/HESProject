//
//  UIBarButtonItem+Extension.m
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (instancetype)barButtonItemWithImageName:(NSString *)image target:(id)target action:(SEL)action{
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:GETIMG(image) forState:UIControlStateNormal];
    // 设置按钮的尺寸为背景图片的尺寸
    button.size = button.currentBackgroundImage.size;
    // 监听按钮点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}


+ (instancetype)barButtonItemWithTitle:(NSString *)title Font:(CGFloat)font TextColor:(UIColor *)textColor target:(id)target action:(SEL)action {
    UIButton *button = [[UIButton alloc] init];
    button.titleLabel.font = GETFONT(14);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 50, 30);
    // 监听按钮点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}
@end
