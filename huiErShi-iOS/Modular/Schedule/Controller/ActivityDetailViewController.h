//
//  ActivityDetailViewController.h
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "MainBaseViewController.h"
#import "ActivityModel.h"

@interface ActivityDetailViewController : MainBaseViewController
@property (nonatomic, strong) ActivityModel *model;
@property (nonatomic, strong) NSString *activityId;
@end
