//
//  ActivityRemindCell.m
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "ActivityRemindCell.h"
#import "ActivityModel.h"

@implementation ActivityRemindCell

- (void)setActivityModel:(ActivityModel *)activityModel {
    _activityModel = activityModel;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:activityModel.iconUrl] placeholderImage:[UIImage imageNamed:@"叹号1"]];
    self.activityName.text = activityModel.name;
    self.activityAddress.text = activityModel.location;
//    self.applyState
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
