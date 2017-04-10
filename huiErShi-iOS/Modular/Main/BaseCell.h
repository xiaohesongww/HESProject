//
//  BaseCell.h
//  LiveStar
//
//  Created by SKT1 on 2016/12/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCell : UITableViewCell
//加载非xibCell

+ (instancetype)loadNormalCellWithTabelView:(UITableView *)tableView;

//加载xibCell

+ (instancetype)loadNibCellWithTabelView:(UITableView *)tableView;
@end
