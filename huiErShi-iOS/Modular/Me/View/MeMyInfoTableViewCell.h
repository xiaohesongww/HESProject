//
//  MeMyInfoTableViewCell.h
//  huiErShi-iOS
//
//  Created by wanjianIOSMacMini on 2017/2/10.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeMyInfoTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLab; ///< title
@property (nonatomic, strong) UILabel *contentLab; ///< content
@property (nonatomic, strong) CALayer*bootmLine;

+ (instancetype)cellWithTableView:(UITableView*)tableView;

@end
