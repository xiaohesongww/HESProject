//
//  MyDeviceCell.h
//  huiErShi-iOS
//
//  Created by 漪珊 on 2017/2/20.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyDeviceCell : BaseCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *deviceName;
@property (weak, nonatomic) IBOutlet UILabel *state;

@end
