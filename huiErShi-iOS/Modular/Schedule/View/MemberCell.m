//
//  MemberCell.m
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "MemberCell.h"

@implementation MemberCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.memberIcon.layer.cornerRadius = 20;
    self.memberIcon.clipsToBounds = YES;
}

@end
