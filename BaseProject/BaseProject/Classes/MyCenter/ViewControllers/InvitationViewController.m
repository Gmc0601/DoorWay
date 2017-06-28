//
//  InvitationViewController.m
//  BaseProject
//
//  Created by li on 2017/6/28.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "InvitationViewController.h"

@interface InvitationViewController ()

@end

@implementation InvitationViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title=@"我的邀请码";
    self.view.backgroundColor = UIColorFromHex(0xf0f0f0);
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    [self returnBack];
    
    [self setIMageMain];
}


#pragma -mark 返回按钮

-(UIButton *)returnBack{
    if (!_returnBack) {
        _returnBack = [UIButton buttonWithType:UIButtonTypeCustom];
        _returnBack.frame = CGRectMake(10/2,(88-60)/2/2*SCALE,44/2*SCALE,44/2*SCALE);
        [_returnBack setImage:[UIImage imageNamed:@"btn_fh_b"] forState:UIControlStateNormal];
        [_returnBack addTarget:self action:@selector(returnBackView) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:_returnBack];
        self.navigationItem.leftBarButtonItem = leftItem;
    }
    return _returnBack;
}


-(void)returnBackView{
     [self.navigationController popViewControllerAnimated:YES];
}


-(void)setIMageMain{
    
    UIView *setMainView=[[UIView alloc]init];
    setMainView.backgroundColor=[UIColor whiteColor];
    setMainView.layer.masksToBounds=YES;
    setMainView.layer.cornerRadius=5;
    [self.view addSubview:setMainView];
    [setMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(74*SCALE);
        make.left.mas_equalTo(10*SCALE);
        make.right.mas_equalTo(-10*SCALE);
        make.height.mas_equalTo((330/2)*SCALE);
    }];
    
    UILabel *setLable=[[UILabel alloc]init];
    setLable.backgroundColor=[UIColor clearColor];
    setLable.textColor=UIColorFromHex(0x999999);
    setLable.text=@"我的邀请码";
    setLable.font=HelveticaNeueFont(15*SCALE);
    [setMainView addSubview:setLable];
    [setLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(45*SCALE);
        make.centerX.mas_equalTo(setMainView.mas_centerX);
        make.height.mas_equalTo((60/2)*SCALE);
    }];

}



@end
