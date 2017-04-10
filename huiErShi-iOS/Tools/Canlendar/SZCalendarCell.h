//
//  SZCalendarCell.h
//  SZCalendarPicker
//
//  Created by Stephen Zhuang on 14/12/1.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SZCalendarCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *progressBack;
@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIView *bottomLine;
@property (weak, nonatomic) IBOutlet UIView *activityState;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@end
