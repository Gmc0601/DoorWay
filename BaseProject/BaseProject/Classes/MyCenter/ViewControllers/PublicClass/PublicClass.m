//
//  PublicClass.m
//  BaseProject
//
//  Created by lxl on 2017/6/29.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "PublicClass.h"

@implementation PublicClass
+ (void)setRightTitleOnTargetNav:(id)controller action:(SEL)action Title:(NSString *)title{
    //设置navbar上的右键按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn addTarget:controller action:action forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleColor:[UIColor colorWithRed:0/255.0 green:149/255.0 blue:241/255.0 alpha:1] forState:UIControlStateNormal];
    [rightBtn setTitle:title forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
    [rightBtn sizeToFit];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [[controller navigationItem] setRightBarButtonItem:backItem];
}
@end
