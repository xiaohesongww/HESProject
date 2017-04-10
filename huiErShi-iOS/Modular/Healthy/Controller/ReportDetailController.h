//
//  ReportDetailController.h
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ReportType) {
    ReportTypeVipNone       = 1, // 非会员
    ReportTypeInput         = 2, // 报告单录入中
    ReportTypeImageUnclear  = 3, // 报告单图片不清楚
    ReportTypeSucceed       = 4  // 报告单识别成功
};

@interface ReportDetailController : UIViewController

@end
