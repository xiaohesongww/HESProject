//
//  ExpertCell.h
//  huiErShi-iOS
//
//  Created by apple on 17/3/3.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpertCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *professionalTitle;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end
