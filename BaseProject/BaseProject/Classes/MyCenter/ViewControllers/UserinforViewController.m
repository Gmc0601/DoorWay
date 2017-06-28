//
//  UserinforViewController.m
//  BaseProject
//
//  Created by li on 2017/6/28.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "UserinforViewController.h"

@interface UserinforViewController ()

@end

@implementation UserinforViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title=@"个人资料";
    
    self.view.backgroundColor = UIColorFromHex(0xf0f0f0);
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    [self returnBack];
    
    [self  setIMageMain];
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


/*
 *个人资料
 */
-(void)setIMageMain{
    
    self.setIMageArray=@[@"头像",@"昵称",@"手机号",@"激活账号",@"激活账号"];
    
    for (int i=0; i<self.setIMageArray.count; i++){
        
        UIView *bgView = [[UIView alloc]init];
        bgView.frame = CGRectMake(0,150/2*SCALE+(90/2*SCALE+30/2*SCALE)*i,kScreenW,100/2*SCALE);
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.tag = i;
        bgView.userInteractionEnabled = YES;
        [self.view addSubview:bgView];
        
        //上边线
        UIView *bgUpXianView = [[UIView alloc]init];
        bgUpXianView.frame = CGRectMake(0, 0, kScreenW, 1.0/2*SCALE);
        bgUpXianView.backgroundColor = UIColorFromHex(0xd7d7d7);
        [bgView addSubview:bgUpXianView];
        
        //下边线
        UIView *bgDownXianView = [[UIView alloc]init];
        bgDownXianView.frame = CGRectMake(0,100/2*SCALE-1.0/2*SCALE, kScreenW, 1.0/2*SCALE);
        bgDownXianView.backgroundColor = UIColorFromHex(0xd7d7d7);
        [bgView addSubview:bgDownXianView];
        
        //数组值放进去
        UILabel *titleLable = [[UILabel alloc]init];
        titleLable.frame = CGRectMake(40/2*SCALE,0,100/2*SCALE*5,100/2*SCALE);
        titleLable.text = self.setIMageArray[i];
        titleLable.textColor = UIColorFromHex(0x333333);
        titleLable.font = HelveticaNeueFont(16*SCALE);
        titleLable.textAlignment = NSTextAlignmentLeft;
        [bgView addSubview:titleLable];

    }
    
}



@end
