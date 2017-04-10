//
//  MedicineCell.h
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MedicineCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *medicineNameLabel;    // 药物名称
@property (weak, nonatomic) IBOutlet UILabel *medicineDoseLabel;    // 药物剂量
@property (weak, nonatomic) IBOutlet UILabel *medicneTimeLabel;     // 服用时间

@end
