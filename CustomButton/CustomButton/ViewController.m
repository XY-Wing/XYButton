//
//  ViewController.m
//  CustomButton
//
//  Created by wing on 2018/6/20.
//  Copyright © 2018年 wing. All rights reserved.
//

#import "ViewController.h"
#import "XYButton.h"
@interface ViewController ()
@property(nonatomic,strong)XYButton *btn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _btn = [[XYButton alloc] initWithFrame:CGRectMake(10, 100, 100, 100)];//宽高无效
    [_btn setTitle:@"按钮按钮按钮按钮按钮"];
    [_btn setImage:[UIImage imageNamed:@"home_icon_mail"]];
//    [_btn setBackgroundImage:[UIImage imageNamed:@"home_icon_meeting"]];
    _btn.backgroundColor = [UIColor redColor];
    _btn.imageViewPosition = XYPositionLeft;
    _btn.subViewsMargin = 10;
    [_btn setTitleColor:[UIColor cyanColor]];
    [self.view addSubview:_btn];
}
- (IBAction)lr {
    _btn.imageViewPosition = XYPositionLeft;
}
- (IBAction)rl {
    _btn.imageViewPosition = XYPositionRight;
}
- (IBAction)tb {
    _btn.imageViewPosition = XYPositionTop;
}
- (IBAction)bt {
    _btn.imageViewPosition = XYPositionBottom;
}
@end
