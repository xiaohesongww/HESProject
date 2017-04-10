//
//  HealthyHeadView.m
//  huiErShi-iOS
//
//  Created by 纪辰 on 2017/3/13.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "HealthyHeadView.h"

@implementation HealthyHeadView

- (instancetype)init {
    if (self = [super init]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *labelArray = [NSMutableArray arrayWithCapacity:4];
    
    self.kanbanLabel = [[UILabel alloc] init];
    self.kanbanLabel.tag = 101;
    self.kanbanLabel.text = @"看板";
    self.kanbanLabel.textColor = HESCOLOR_WORD_BLACK;
    self.kanbanLabel.textAlignment = NSTextAlignmentCenter;
    self.kanbanLabel.font = LayOutBOLDFont(32);
    self.kanbanLabel.userInteractionEnabled = YES;
    [self addSubview:self.kanbanLabel];
    self.kanbanLabel.sd_layout
    .topSpaceToView(self,0)
    .bottomSpaceToView(self,0)
    .leftSpaceToView(self,LayOutW(55))
    .widthIs(LayOutW(160));
    [labelArray addObject:self.kanbanLabel];
    
    self.reportLabel = [[UILabel alloc] init];
    self.reportLabel.tag = 102;
    self.reportLabel.font = LayOutBOLDFont(32);
    self.reportLabel.textColor = HESHEXCOLOR(@"999999");
    self.reportLabel.text = @"报告单";
    self.reportLabel.textAlignment = NSTextAlignmentCenter;
    self.reportLabel.userInteractionEnabled = YES;
    [self addSubview:self.reportLabel];
    self.reportLabel.sd_layout
    .topSpaceToView(self,0)
    .bottomSpaceToView(self,0)
    .leftSpaceToView(self.kanbanLabel,0)
    .widthIs(LayOutW(160));
    [labelArray addObject:self.reportLabel];
    
    self.medicineLabel = [[UILabel alloc] init];
    self.medicineLabel.tag = 103;
    self.medicineLabel.font = LayOutBOLDFont(32);
    self.medicineLabel.textColor = HESHEXCOLOR(@"999999");
    self.medicineLabel.text = @"用药";
    self.medicineLabel.textAlignment = NSTextAlignmentCenter;
    self.medicineLabel.userInteractionEnabled = YES;
    [self addSubview:self.medicineLabel];
    self.medicineLabel.sd_layout
    .topSpaceToView(self,0)
    .bottomSpaceToView(self,0)
    .leftSpaceToView(self.reportLabel, 0)
    .widthIs(LayOutW(160));
    [labelArray addObject:self.medicineLabel];
    
    self.diaryLabel = [[UILabel alloc] init];
    self.diaryLabel.tag = 104;
    self.diaryLabel.font = LayOutBOLDFont(32);
    self.diaryLabel.textColor = HESHEXCOLOR(@"999999");
    self.diaryLabel.text = @"日记";
    self.diaryLabel.textAlignment = NSTextAlignmentCenter;
    self.diaryLabel.userInteractionEnabled = YES;
    [self addSubview:self.diaryLabel];
    self.diaryLabel.sd_layout
    .topSpaceToView(self,0)
    .bottomSpaceToView(self,0)
    .rightSpaceToView(self, LayOutW(55))
    .widthIs(LayOutW(160));
    [labelArray addObject:self.diaryLabel];
    
    self.line = [[UILabel alloc] init];
    self.line.backgroundColor = HESHEXCOLOR(@"00a652");
    [self addSubview:self.line];
    self.line.sd_layout
    .bottomSpaceToView(self,0)
    .centerXEqualToView(self.kanbanLabel)
    .widthIs(LayOutW(100))
    .heightIs(LayOutH(4));
    
    for (UILabel *label in labelArray) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actiondo:)];
        [label addGestureRecognizer:tapGesture];
    }
}

-(void)actiondo:(UITapGestureRecognizer*)recognizer{
    UILabel *label = (UILabel *)recognizer.view;
    self.kanbanLabel.textColor = HESHEXCOLOR(@"999999");
    self.reportLabel.textColor = HESHEXCOLOR(@"999999");
    self.medicineLabel.textColor = HESHEXCOLOR(@"999999");
    self.diaryLabel.textColor = HESHEXCOLOR(@"999999");
    label.textColor = HESCOLOR_WORD_BLACK;
    switch (label.tag) {
        case 101:
            self.senderType = SenderTypeBillboard;
            break;
        case 102:
            self.senderType = SenderTypeReport;
            break;
        case 103:
            self.senderType = SenderTypeMedications;
            break;
        case 104:
            self.senderType = SenderTypeDiary;
            break;
            
        default:
            break;
    }
//    NSLog(@"%ld",(long)self.senderType);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.line.sd_layout.centerXEqualToView(label);
        
        [self.line updateLayout];
        
    } completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(changeControllerWithSenderType:)]) {
            [self.delegate changeControllerWithSenderType:self.senderType];
        }
    }];
}


@end
