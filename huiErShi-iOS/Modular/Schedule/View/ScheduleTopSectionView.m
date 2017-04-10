//
//  ScheduleTopSectionView.m
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "ScheduleTopSectionView.h"

@implementation ScheduleTopSectionView


- (void)awakeFromNib {
    [super awakeFromNib];
    ProgressView *progress1 = [[ProgressView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    progress1.progressStrokeColor = [UIColor colorWithHexString:@"00a652"];
    progress1.backgroundStrokeColor = [UIColor whiteColor];
    progress1.progressTextColor = [UIColor whiteColor];
    [self.progressBack addSubview:progress1];
    progress1.innerBackgroundColor = [UIColor clearColor];
    [progress1 setProgress:0.4 Animated:NO];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lookScheduleDetail:)];
    [self.progressBack addGestureRecognizer:tap];
}

#pragma mark -- 查看日程详情
- (void)lookScheduleDetail:(UITapGestureRecognizer *)tap {
    [self.delegate scheduleDetail];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
