//
//  ScheduleTopSectionView.h
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressView.h"

@protocol ScheduleTopSectionViewDelegate <NSObject>

- (void)scheduleDetail;

@end
@interface ScheduleTopSectionView : UIView
@property (weak, nonatomic) IBOutlet UIView *progressBack;
@property (weak, nonatomic) IBOutlet UILabel *sloganlabel;
@property (nonatomic, assign) id<ScheduleTopSectionViewDelegate>delegate;
@end
