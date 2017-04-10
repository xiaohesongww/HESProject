//
//  MeItemCollectionViewCell.m
//  huiErShi-iOS
//
//  Created by wanjianIOSMacMini on 2017/2/10.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "MeItemCollectionViewCell.h"

@implementation MeItemCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        _iconImg=[UIImageView new];
        [self addSubview:_iconImg];
        _iconImg.sd_layout
        .centerYIs(LayOutH(62))
        .centerXEqualToView(self);
        
        _itemLab=[UILabel new];
        _itemLab.font=LayOutFont(32);
        _itemLab.textColor=HESCOLOR_WORD_BLACK;
        _itemLab.textAlignment=NSTextAlignmentCenter;
        [self addSubview:_itemLab];
        
        _itemLab.sd_layout
        .bottomSpaceToView(self,LayOutH(30))
        .leftSpaceToView(self,0)
        .rightSpaceToView(self,0)
        .heightIs(LayOutH(32));
    }
    return self;
}

-(void)setItem:(MeItemModel *)item{
    _item=item;
    UIImage *itemImg=GETIMG(item.item_img);
    _iconImg.image=itemImg;
    _iconImg.sd_layout
    .widthIs(itemImg.size.width)
    .heightIs(itemImg.size.height);
    
    _itemLab.text=item.item_title;
}

@end
