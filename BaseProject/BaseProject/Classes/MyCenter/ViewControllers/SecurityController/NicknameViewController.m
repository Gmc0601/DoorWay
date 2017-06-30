//
//  NicknameViewController.m
//  BaseProject
//
//  Created by li on 2017/6/29.
//  Copyright © 2017年 cc. All rights reserved.
//


#import "Masonry.h"
#import "NicknameViewController.h"

@interface NicknameViewController ()<UITextFieldDelegate>

@end

@implementation NicknameViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromHex(0xf0f0f0);
    
    self.navigationController.navigationBar.translucent = NO;
    
    [self .view addSubview:self.saveButton];
    
    [self setCustomerTitle:@"修改昵称"];
    
    [self setSubviewsMain];
}


-(void)setSubviewsMain{
    [self.view addSubview:self.setIMageFiled];
    [self.view addSubview:self.IMageLine];
}


-(UITextField *)setIMageFiled{
    if (!_setIMageFiled) {
        self.setIMageFiled=[[UITextField alloc]init];
        self.setIMageFiled.borderStyle=UITextBorderStyleNone;
        self.setIMageFiled.font=HelveticaNeueFont(15*SCALE);
        self.setIMageFiled.textColor=[UIColor blackColor];
        self.setIMageFiled.text=@"我是人名";
        self.setIMageFiled.textAlignment=NSTextAlignmentLeft;
        self.setIMageFiled.backgroundColor=[UIColor clearColor];
        self.setIMageFiled.textColor=UIColorFromHex(0x333333);
        self.setIMageFiled.delegate=self;
        [self.view addSubview:self.setIMageFiled];
        [self.setIMageFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0*SCALE);
            make.left.mas_equalTo(10*SCALE);
            make.right.mas_equalTo(-10*SCALE);
            make.height.mas_equalTo(50*SCALE);
        }];
    }
    return _setIMageFiled;
}

-(UIImageView *)IMageLine{
    if (!_IMageLine) {
        self.IMageLine=[[UIImageView alloc]init];
        self.IMageLine.backgroundColor=UIColorFromHex(0xd7d7d7);
        [self.view addSubview:self.IMageLine];
        [self.IMageLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.setIMageFiled.mas_bottom).offset(1);
            make.left.mas_equalTo(10*SCALE);
            make.right.mas_equalTo(-10*SCALE);
            make.height.mas_equalTo(1*SCALE);
        }];
    }
    return _IMageLine;
}


#pragma -mark 保存

-(UIButton *)saveButton{
    if (!_saveButton) {
        self.saveButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.saveButton setTitle:@"保存" forState:UIControlStateNormal];
        self.saveButton.titleLabel.font=HelveticaNeueFont(16*SCALE);
        self.saveButton.frame = CGRectMake((kScreenW-80)*SCALE,(88-60)/2/2*SCALE,60,44/2*SCALE);
        [self.saveButton addTarget:self action:@selector(saveBtn:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.saveButton];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    return _saveButton;
}

-(void)saveBtn:(UIButton *)sender{
    if (self.selectedinfoString) {
        self.selectedinfoString(self.setIMageFiled.text);
         [self.navigationController popViewControllerAnimated:YES];
    }
}




@end
