//
//  ModifyNicknameViewController.h
//  huiErShi-iOS
//
//  Created by 纪辰 on 2017/2/18.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModifyNicknameViewController : UIViewController
@property (nonatomic, copy) void(^(setName))(NSString *name);
@end
