//
//  ProjectCell.h
//  huiErShi-iOS
//
//  Created by 漪珊 on 2017/2/21.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "BaseCell.h"

@interface ProjectCell : BaseCell
@property (nonatomic, assign) BOOL isSelected;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@end
