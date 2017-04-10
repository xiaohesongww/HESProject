//
//  RZPopupMenuItem.m
//  RZPopupMenu
//
//  Created by Zrocky on 16/1/20.
//  Copyright (c) 2016年 Zrocky. All rights reserved.
//

#import "RZPopupMenuItem.h"
#import "UIView+AdjustFrame.h"

CGFloat const kRZPopupItemContentSizeRatio = .7f;

@interface RZPopupMenuItem ()

@property (nonatomic, strong) UIImageView *contentImageView;
@property (nonatomic, strong) UILabel *lable;
@end
@implementation RZPopupMenuItem

- (instancetype)initWithContentImage:(UIImage *)contentImage
                               Title:(NSString *)title;
{
    if (self = [super init]) {
        self.contentImageView.image = contentImage;
        self.lable.text = title;
        self.userInteractionEnabled = YES;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    [self addSubview:self.contentImageView];
    [self addSubview:self.lable];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.contentImageView.width = self.width * kRZPopupItemContentSizeRatio;
    self.contentImageView.height = self.height * kRZPopupItemContentSizeRatio;
    self.contentImageView.center = CGPointMake(self.width * 0.5, self.height * 0.2);
    self.lable.frame = CGRectMake(0, self.contentImageView.height, self.width, self.height - self.contentImageView.height);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.delegate respondsToSelector:@selector(popupMenuItemTouchesBegan:)]) {
        [self.delegate popupMenuItemTouchesBegan:self];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

#pragma mark - delegate

#pragma mark - event response

#pragma mark - public methods

#pragma mark - private methods

#pragma mark - setter and getter
- (UIImageView *)contentImageView
{
    if (!_contentImageView) {
        _contentImageView = [[UIImageView alloc] init];
    }
    return _contentImageView;
}

- (UILabel *)lable {
    if (!_lable) {
        _lable = [[UILabel alloc] init];
        _lable.textAlignment = NSTextAlignmentCenter;
        _lable.font = [UIFont systemFontOfSize:11];
        _lable.textColor = [UIColor whiteColor];
    }
    return _lable;
}
@end
