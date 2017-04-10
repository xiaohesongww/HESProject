//
//  RZPopupMenuItem.h
//  RZPopupMenu
//
//  Created by Zrocky on 16/1/20.
//  Copyright (c) 2016年 Zrocky. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RZPopupMenuItemDelegate;

@interface RZPopupMenuItem : UIView

@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGPoint farPoint;
@property (nonatomic, assign) CGPoint nearPoint;
@property (nonatomic, assign) CGPoint endPoint;

@property (nonatomic, weak) id<RZPopupMenuItemDelegate> delegate;

- (instancetype)initWithContentImage:(UIImage *)contentImage
                                   Title:(NSString *)title;

@end


@protocol RZPopupMenuItemDelegate <NSObject>

@optional
- (void)popupMenuItemTouchesBegan:(RZPopupMenuItem *)item;

@end
