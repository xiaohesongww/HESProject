//
//  HealthyHeadView.h
//  huiErShi-iOS
//
//  Created by 纪辰 on 2017/3/13.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, SenderType) {
    SenderTypeBillboard,      //看板
    SenderTypeReport,         //报告
    SenderTypeMedications,//用药
    SenderTypeDiary           //日记
};
@protocol HealthyHeadViewDelegate<NSObject>
- (void)changeControllerWithSenderType:(SenderType)senderType;
@end

@interface HealthyHeadView : UIView
@property (nonatomic, strong) UILabel *kanbanLabel;         /// 看板
@property (nonatomic, strong) UILabel *reportLabel;         /// 报告单
@property (nonatomic, strong) UILabel *medicineLabel;       /// 用药
@property (nonatomic, strong) UILabel *diaryLabel;          /// 日记
@property (nonatomic, strong) UILabel *line;                ///< 线
@property (nonatomic, assign) SenderType senderType;

@property (nonatomic, weak) id<HealthyHeadViewDelegate>delegate;
@end
