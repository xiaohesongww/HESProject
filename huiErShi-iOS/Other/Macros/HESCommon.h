//
//  HESCommon.h
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//


#ifndef HESCommon_h
#define HESCommon_h

// NSLog ..
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"[%s:%d行] %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif


#define USER_ID @"1"
#define HESCOLOR(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define HESHEXCOLOR(c) [UIColor colorWithHexString:c]
#define KString(string) [NSString stringWithFormat:@"%@", string]

#define kIMUserSign @"IM_UserSign"//IM登录签名

#define kUserPath @"UserInfo" //归档存储用户 filePath
//主题背景色
#define HESCOLOR_THEME HESCOLOR(235, 235, 235)
//导航栏
#define HESCOLOR_NAV  HESCOLOR(41, 35, 49)

//黑色文字
#define HESCOLOR_WORD_BLACK  HESHEXCOLOR(@"333333")
//line
#define HESCOLOR_LINE  HESHEXCOLOR(@"cccccc")

#define GETIMG(x) [UIImage imageNamed:x]

#define GETFONT(x) [UIFont systemFontOfSize:x]

//屏宽高宏
#define kSCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define kSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)



#define kScreenWidthRatio  (kScreenWidth / 750)
#define LayOutFont(R)  [UIFont systemFontOfSize:(ceilf((R) * kScreenWidthRatio))]
#define LayOutBOLDFont(R) [UIFont boldSystemFontOfSize:(ceilf((R) * kScreenWidthRatio))]
#define  LayOutW(x)    (kScreenWidth*(x)/750)
#define  LayOutH(x)    (kScreenHeight*(x)/1334)

/// 版本的宏.
#define     iOS7   ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
#define     iOS8   ([[[UIDevice currentDevice]systemVersion]doubleValue]>= 8.0)



#endif /* HESCommon_h */

