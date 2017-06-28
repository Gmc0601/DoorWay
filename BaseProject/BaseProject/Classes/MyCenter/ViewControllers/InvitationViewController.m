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
    self.view.backgroundColor = UIColorFromHex(0xf6f6f6);
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    [self returnBack];
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
    
    

}



@end
