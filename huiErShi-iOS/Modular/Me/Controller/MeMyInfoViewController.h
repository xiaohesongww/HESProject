//
//  MeMyInfoViewController.h
//  huiErShi-iOS
//
//  Created by wanjianIOSMacMini on 2017/2/10.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "MainBaseViewController.h"

@interface MeMyInfoViewController : MainBaseViewController
@property (nonatomic, copy) void(^(setName))(NSString *name);
@property (nonatomic, copy) void(^(setIcon))(UIImage *icon);
@end
