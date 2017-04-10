//
//  ActivityRemindCell.h
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "BaseCell.h"
@class ActivityModel;
@interface ActivityRemindCell : BaseCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *activityName;
@property (weak, nonatomic) IBOutlet UILabel *activityAddress;
@property (weak, nonatomic) IBOutlet UILabel *applyState;
@property (weak, nonatomic) IBOutlet UILabel *activitytime;

@property (nonatomic, strong) ActivityModel *activityModel;
@end
