//
//  MeItemCollectionViewCell.h
//  huiErShi-iOS
//
//  Created by wanjianIOSMacMini on 2017/2/10.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeItemModel.h"
@interface MeItemCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *iconImg; ///< 图片
@property (nonatomic, strong) UILabel *itemLab; ///< lab
@property (nonatomic, strong) MeItemModel *item; ///<模块
@end
