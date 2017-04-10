//
//  ActivityStateCell.h
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "BaseCell.h"

@interface ActivityStateCell : BaseCell
@property (weak, nonatomic) IBOutlet UILabel *activityName;
@property (weak, nonatomic) IBOutlet UILabel *signStaeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *signStateImg;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;

@end
