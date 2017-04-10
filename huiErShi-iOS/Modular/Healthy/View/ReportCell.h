//
//  ReportCell.h
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *reportImageView;
@property (weak, nonatomic) IBOutlet UILabel *reportTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *reportTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *reportStatusLabel;

@end
