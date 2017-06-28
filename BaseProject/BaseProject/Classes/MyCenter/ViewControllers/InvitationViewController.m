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
    
    [self setIMageSubView];
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
    
    setMainView=[[UIView alloc]init];
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
    setLable.font=HelveticaNeueFont(11*SCALE);
    [setMainView addSubview:setLable];
    [setLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(45*SCALE);
        make.centerX.mas_equalTo(setMainView.mas_centerX);
        make.height.mas_equalTo((60/2)*SCALE);
    }];
    
    UILabel *IMageLalbe=[[UILabel alloc]init];
    IMageLalbe.backgroundColor=[UIColor clearColor];
    IMageLalbe.textColor=UIColorFromHex(0x379ff2);
    IMageLalbe.text=@"8X79P2";
    IMageLalbe.font=HelveticaNeueFont(50*SCALE);
    [setMainView addSubview:IMageLalbe];
    [IMageLalbe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(setLable.mas_bottom).offset(10*SCALE);
        make.centerX.mas_equalTo(setMainView.mas_centerX);
        make.height.mas_equalTo(IMageLalbe.mas_height);
    }];
}

-(void)setIMageSubView{
    
    UIView *setSubView=[[UIView alloc]init];
    setSubView.backgroundColor=[UIColor whiteColor];
    setSubView.layer.masksToBounds=YES;
    setSubView.layer.cornerRadius=5;
    [self.view addSubview:setSubView];
    [setSubView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(setMainView.mas_bottom).offset(10*SCALE);
        make.left.mas_equalTo(10*SCALE);
        make.right.mas_equalTo(-10*SCALE);
        make.height.mas_equalTo((240/2)*SCALE);
    }];
    
    UILabel *subLable=[[UILabel alloc]init];
    subLable.backgroundColor=[UIColor clearColor];
    subLable.textColor=UIColorFromHex(0x666666);
    subLable.text=@"邀请码说明";
    subLable.font=HelveticaNeueFont(13*SCALE);
    [setSubView addSubview:subLable];
    [subLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15*SCALE);
        make.centerX.mas_equalTo(setSubView.mas_centerX);
        make.height.mas_equalTo((60/2)*SCALE);
    }];
    
    
    UILabel *subIMageLalbe=[[UILabel alloc]init];
    subIMageLalbe.backgroundColor=[UIColor clearColor];
    subIMageLalbe.textColor=UIColorFromHex(0x999999);
    subIMageLalbe.numberOfLines=3;
    subIMageLalbe.text=@" 1. 邀请好友使用您的邀请码注册,当好友激活后，您将获得40%的激活MSC积分 ; \n 2. 邀请激活好友数越多，获得的MSC越多；";
    subIMageLalbe.font=HelveticaNeueFont(13*SCALE);
    [setSubView addSubview:subIMageLalbe];
    [subIMageLalbe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(subLable.mas_bottom).offset(10*SCALE);
        //make.centerX.mas_equalTo(setMainView.mas_centerX);
        make.left.mas_equalTo(10*SCALE);
        make.right.mas_equalTo(-10*SCALE);
        make.height.mas_equalTo(50*SCALE);
    }];

}



@end
