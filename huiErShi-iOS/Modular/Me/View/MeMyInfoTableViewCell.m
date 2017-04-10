//
//  MeMyInfoTableViewCell.m
//  huiErShi-iOS
//
//  Created by wanjianIOSMacMini on 2017/2/10.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "MeMyInfoTableViewCell.h"

@implementation MeMyInfoTableViewCell

+ (instancetype)cellWithTableView:(UITableView*)tableView{
    
    static NSString *cellID=@"MeMyInfoTableViewCell";
    MeMyInfoTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor=[UIColor whiteColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        _titleLab=[UILabel new];
        _titleLab.font=LayOutBOLDFont(32);
        _titleLab.textColor=HESCOLOR_WORD_BLACK;
        [self.contentView addSubview:_titleLab];
        
        _titleLab.sd_layout
        .leftSpaceToView(self.contentView,LayOutW(20))
        .topSpaceToView(self.contentView,0)
        .bottomSpaceToView(self.contentView,0)
        .widthIs(LayOutW(70));
        
        
        _contentLab=[UILabel new];
        _contentLab.font=LayOutFont(32);
        _contentLab.textAlignment=NSTextAlignmentRight;
        _contentLab.textColor=HESCOLOR_WORD_BLACK;
        [self.contentView addSubview:_contentLab];
        _contentLab.sd_layout
        .leftSpaceToView(_titleLab,LayOutW(20))
        .rightSpaceToView(self.contentView,LayOutW(20))
        .topSpaceToView(self.contentView,0)
        .bottomSpaceToView(self.contentView,0);
        
        _titleLab.text=@"昵称";
        _contentLab.text=@"loongcrown";
        
        _bootmLine = [CALayer layer];
        _bootmLine.frame = CGRectMake(LayOutW(20), LayOutH(87), kScreenWidth-LayOutW(20), CGFloatFromPixel(1));
        _bootmLine.backgroundColor = HESCOLOR_LINE.CGColor;
        [self.layer addSublayer:_bootmLine];
    }
    return self;
}

@end
