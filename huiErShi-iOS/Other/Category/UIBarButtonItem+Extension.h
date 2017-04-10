//
//  UIBarButtonItem+Extension.h
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (instancetype)barButtonItemWithImageName:(NSString *)image target:(id)target action:(SEL)action;

+ (instancetype)barButtonItemWithTitle:(NSString *)title Font:(CGFloat)font TextColor:(UIColor *)textColor target:(id)target action:(SEL)action;
@end
