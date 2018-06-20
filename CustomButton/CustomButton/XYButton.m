//
//  XYButton.m
//  CustomButton
//
//  Created by wing on 2018/6/20.
//  Copyright © 2018年 wing. All rights reserved.
//

#import "XYButton.h"
typedef NS_ENUM(NSInteger,XYButtonType) {
    XYButtonTypeTitleLabel = 0,
    XYButtonTypeImageView,
    XYButtonTypeBackgroundImageView,
    XYButtonTypeTitleLabelAndImageView,
    XYButtonTypeTitleLabelAndbgImageView,
    XYButtonTypeTitleLabelAndImageViewAndbgImageView
};
@interface XYButton()
@property(nonatomic,strong,readwrite)UILabel *titleLabel;
@property(nonatomic,strong,readwrite)UIImageView *imageView;
@property(nonatomic,strong,readwrite)UIImageView *backgroundImageView;
@property(nonatomic,assign)XYButtonType buttonType;
@end
@implementation XYButton
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
- (instancetype)init
{
    if (self = [super init]) {
        _subViewsMargin = 4;
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _subViewsMargin = 4;
    }
    return self;
}
- (CGSize)getSize
{
    return [_titleLabel.text boundingRectWithSize:CGSizeMake(kScreenW, kScreenH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_titleLabel.font} context:nil].size;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    XYButtonType buttonType = self.buttonType;
    switch (buttonType) {
        case XYButtonTypeTitleLabel:
        {
            CGSize finalSize = CGSizeZero;
            CGSize size = [self getSize];
            _titleLabel.frame = CGRectMake(0, 0, size.width, size.height);
            finalSize = size;
            
            CGRect frame = self.frame;
            frame.size = finalSize;
            self.frame = frame;
        }
            break;
        case XYButtonTypeTitleLabelAndImageView:
        case XYButtonTypeTitleLabelAndImageViewAndbgImageView:
        {
            [_imageView sizeToFit];
            CGSize imageSize = _imageView.image.size;
            CGSize finalSize = CGSizeZero;
            CGSize size = [self getSize];
            
            if (_imageViewPosition == XYPositionLeft || _imageViewPosition == XYPositionRight) {
                
                finalSize.height = MAX(imageSize.height,size.height);
                finalSize.width = imageSize.width + size.width + _subViewsMargin;
                
                CGFloat LabX = _imageViewPosition == XYPositionLeft ? imageSize.width + _subViewsMargin : 0;
                CGFloat imgVX = _imageViewPosition == XYPositionLeft ? 0 : size.width + _subViewsMargin;
                CGFloat LabY = (finalSize.height - size.height) * 0.5;
                CGFloat imgVY = (finalSize.height - imageSize.height) * 0.5;
                
                _titleLabel.frame = CGRectMake(LabX, LabY, size.width, size.height);
                _imageView.frame = CGRectMake(imgVX, imgVY, imageSize.width, imageSize.height);
                
                CGRect frame = self.frame;
                frame.size = finalSize;
                self.frame = frame;
            } else {
                
                finalSize.width = MAX(imageSize.width, size.width);
                finalSize.height = imageSize.height + size.height + _subViewsMargin;
                
                CGFloat LabY = _imageViewPosition == XYPositionTop ? imageSize.height + _subViewsMargin : 0;
                CGFloat imgVY = _imageViewPosition == XYPositionTop ? 0 : size.height + _subViewsMargin;
                CGFloat labX = (finalSize.width - size.width) * 0.5;
                CGFloat imgVX = (finalSize.width - imageSize.width) * 0.5;
                
                _titleLabel.frame = CGRectMake(labX, LabY, size.width, size.height);
                _imageView.frame = CGRectMake(imgVX, imgVY, imageSize.width, imageSize.height);
                
                CGRect frame = self.frame;
                frame.size = finalSize;
                self.frame = frame;
            }
            
            _backgroundImageView.frame = self.bounds;
        }
            break;
            case XYButtonTypeImageView:
            case XYButtonTypeBackgroundImageView:
        {
            NSLog(@"请使用UIButton或UIImageView.");
        }
            break;
        default:
            break;
    }
    
    
}
- (CGSize)sizeThatFits:(CGSize)size
{
    
    return [super sizeThatFits:size];
}
- (void)setTitle:(NSString *)title //forState:(UIControlState)state
{
    if (!_titleLabel) {
        self.titleLabel.text = title;
    } else {
        _titleLabel.text = title;
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
- (void)setTitleColor:(UIColor *)titleColor
{
    if (!_titleLabel) {
        self.titleLabel.textColor = titleColor;
    } else {
        _titleLabel.textColor = titleColor;
    }
}
- (void)setImage:(UIImage *)image
{
    if (!image) return;
    if (!_imageView) {
        self.imageView.image = image;
    } else {
        _imageView.image = image;
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    if (!backgroundImage) return;
    if (!_backgroundImageView) {
        self.backgroundImageView.image = backgroundImage;
    } else {
        _backgroundImageView.image = backgroundImage;
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
#pragma mark - lazy
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
    }
    return _imageView;
}
- (UIImageView *)backgroundImageView
{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        [self insertSubview:_backgroundImageView atIndex:0];
    }
    return _backgroundImageView;
}
#pragma mark - setter
- (void)setImageViewPosition:(XYButtonImageViewPosition)imageViewPosition
{
    _imageViewPosition = imageViewPosition;
    [self setNeedsLayout];
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
    }];
    
}
- (void)setSubViewsMargin:(CGFloat)subViewsMargin
{
    _subViewsMargin = subViewsMargin;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
#pragma mark - getter
- (XYButtonType)buttonType
{
    if (_titleLabel && !_imageView && !_backgroundImageView) {
        return XYButtonTypeTitleLabel;
    } else if (!_titleLabel && _imageView && !_backgroundImageView) {
        return XYButtonTypeImageView;
    } else if (!_titleLabel && !_imageView && _backgroundImageView) {
        return XYButtonTypeBackgroundImageView;
    } else if (_titleLabel && _imageView && !_backgroundImageView) {
        return XYButtonTypeTitleLabelAndImageView;
    } else if (_titleLabel && !_imageView && _backgroundImageView) {
        return XYButtonTypeTitleLabelAndbgImageView;
    } else if (_titleLabel && _imageView && _backgroundImageView) {
        return XYButtonTypeTitleLabelAndImageViewAndbgImageView;
    } else {
        return XYButtonTypeTitleLabel;
    }
}
@end
