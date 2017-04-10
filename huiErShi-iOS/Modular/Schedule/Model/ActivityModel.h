//
//  ActivityModel.h
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "QZHModel.h"

@interface ActivityModel : QZHModel
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *currentApplyNumber;
@property (nonatomic, copy) NSString *startAt;
@property (nonatomic, copy) NSString *iconUrl;
@property (nonatomic, copy) NSString *lastedTime;
@property (nonatomic, copy) NSString *maxApplyNumber;
@property (nonatomic, copy) NSString *name;
@end
