//
//  IMElemBaseTableViewCell.h
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MsgModel.h"

@interface IMElemBaseTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *headImageView; // 用户头像
@property (nonatomic,strong) UIImageView *backView; // 气泡
@property (nonatomic,strong) UILabel *contentLabel; // 气泡内文本

- (void)refreshCell:(MsgModel *)model;
@end
