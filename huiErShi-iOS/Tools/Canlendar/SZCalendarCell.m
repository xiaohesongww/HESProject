//
//  SZCalendarCell.m
//  SZCalendarPicker
//
//  Created by Stephen Zhuang on 14/12/1.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "SZCalendarCell.h"
#import "ProgressView.h"
@interface SZCalendarCell()

@end
@implementation SZCalendarCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.dateLabel.backgroundColor = [UIColor orangeColor];
    self.dateLabel.layer.cornerRadius = 10;
    self.dateLabel.clipsToBounds = YES;
    self.activityState.layer.cornerRadius = 2.5;
    self.activityState.clipsToBounds = YES;
    ProgressView *progress1 = [[ProgressView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    progress1.progressLineWidth = 1.5;
    progress1.backgourndLineWidth = 0;
    progress1.progressTextColor = [UIColor clearColor];
    progress1.progressStrokeColor = [UIColor orangeColor];
    progress1.backgroundStrokeColor = [UIColor clearColor];
    [self.progressBack addSubview:progress1];
    progress1.innerBackgroundColor = [UIColor clearColor];
    [progress1 setProgress:0.7 Animated:NO];
}

//- (UIView *)bottomLine {
//    return _bottomLine;
//}
//- (UILabel *)dateLabel
//{
//    if (!_dateLabel) {
//        _dateLabel = [[UILabel alloc] initWithFrame:self.bounds];
//        [_dateLabel setTextAlignment:NSTextAlignmentCenter];
//        [_dateLabel setFont:[UIFont systemFontOfSize:17]];
//        [self addSubview:_dateLabel];
//    }
//    return _dateLabel;
//}
@end
