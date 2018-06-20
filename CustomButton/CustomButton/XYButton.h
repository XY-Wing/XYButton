//
//  XYButton.h
//  CustomButton
//
//  Created by wing on 2018/6/20.
//  Copyright © 2018年 wing. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,XYButtonImageViewPosition) {
    XYPositionLeft = 0,
    XYPositionRight,
    XYPositionTop,
    XYPositionBottom
};


@interface XYButton : UIControl


@property(nonatomic,strong,readonly)UILabel *titleLabel;
- (void)setTitle:(NSString *)title;
- (void)setTitleColor:(UIColor *)titleColor;

@property(nonatomic,strong,readonly)UIImageView *imageView;
- (void)setImage:(UIImage *)image;

@property(nonatomic,strong,readonly)UIImageView *backgroundImageView;
- (void)setBackgroundImage:(UIImage *)backgroundImage;

/*
 图片位置 默认为XYPositionLeft
 */
@property(nonatomic,assign)XYButtonImageViewPosition imageViewPosition;
/*
 图片与文字的距离 默认为4
 XYPositionLeft & XYPositionRight 为左右间距
 XYPositionTop & XYPositionBottom 为上下间距
 */
@property(nonatomic,assign)CGFloat subViewsMargin;
@end
