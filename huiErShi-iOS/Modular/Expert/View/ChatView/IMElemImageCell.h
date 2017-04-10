//
//  IMElemImageCell.h
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "BaseCell.h"
#import "MsgModel.h"

@interface IMElemImageCell : BaseCell
@property (nonatomic,strong) UIImageView *headImageView; // 用户头像
@property (nonatomic,strong) UIImageView *backView; // 气泡
@property (nonatomic,strong) UIImageView *contentLabel; // 气泡内图片

- (void)refreshCell:(MsgModel *)model;

@end
