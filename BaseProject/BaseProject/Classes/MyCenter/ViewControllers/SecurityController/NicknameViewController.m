//
//  NicknameViewController.m
//  BaseProject
//
//  Created by li on 2017/6/29.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "NicknameViewController.h"

@interface NicknameViewController ()

@end

@implementation NicknameViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromHex(0xf0f0f0);
    
    self.navigationController.navigationBar.translucent = NO;
    
    [self setCustomerTitle:@"修改昵称"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
