//
//  DiaryFooterView.m
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "DiaryFooterView.h"

@implementation DiaryFooterView

- (IBAction)diaryFinished:(UIButton *)sender {
    
    [self.footerDelegate diaryFooterViewFinishDiary];
}
- (IBAction)checkNutrition:(UIButton *)sender {
    [self.footerDelegate diaryFooterViewCheckNutrition];
}

@end
