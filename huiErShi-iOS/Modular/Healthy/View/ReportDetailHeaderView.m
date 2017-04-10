//
//  ReportDetailHeaderView.m
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "ReportDetailHeaderView.h"

@implementation ReportDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UIImageView *reportImageView = [[UIImageView alloc] init];
    reportImageView.backgroundColor = [UIColor redColor];
    [self addSubview:reportImageView];
    reportImageView.sd_layout
    .leftSpaceToView(self, LayOutW(20))
    .topSpaceToView(self, LayOutH(20))
    .bottomSpaceToView(self, LayOutH(20))
    .widthIs(LayOutW(140));
    
    UILabel *reportStatusLabel = [[UILabel alloc] init];
    reportStatusLabel.text = @"报告单待识别";
    reportStatusLabel.font = LayOutBOLDFont(32);
    [self addSubview:reportStatusLabel];
    reportStatusLabel.sd_layout
    .topSpaceToView(self, LayOutH(40))
    .leftSpaceToView(reportImageView, LayOutW(40))
    .heightIs(LayOutH(44))
    .widthIs(LayOutW(200));
    
    UILabel *reportUploadTimeLabel = [[UILabel alloc] init];
    reportUploadTimeLabel.text = @"上传日期: 2016年 10月 29日";
    reportUploadTimeLabel.font = LayOutFont(26);
    reportUploadTimeLabel.textColor = HESHEXCOLOR(@"666666");
    [self addSubview:reportUploadTimeLabel];
    reportUploadTimeLabel.sd_layout
    .leftEqualToView(reportStatusLabel)
    .topSpaceToView(reportStatusLabel, LayOutH(40))
    .heightIs(LayOutH(44))
    .widthIs(LayOutW(400));
}

@end
