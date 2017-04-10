//
//  DiaryFooterView.h
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DiaryFooterView;

@protocol DiaryFooterDelegate
@optional
- (void)diaryFooterViewFinishDiary;
- (void)diaryFooterViewCheckNutrition;
@end

@interface DiaryFooterView : UIView
@property (nullable, nonatomic, weak) id<DiaryFooterDelegate>footerDelegate;
@end
