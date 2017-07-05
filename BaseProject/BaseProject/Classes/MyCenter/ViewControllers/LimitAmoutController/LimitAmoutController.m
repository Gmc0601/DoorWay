//
//  LimitAmoutController.m
//  BaseProject
//
//  Created by lxl on 2017/7/2.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "LimitAmoutController.h"
#import "AmoutDetailController.h"
#import "UploadLimitViewController.h"
@interface LimitAmoutController ()

@end

@implementation LimitAmoutController
#pragma mark-提升额度
- (IBAction)UpAmoutLimit:(id)sender {
    UploadLimitViewController * upload = [[UploadLimitViewController alloc]init];
    [self.navigationController pushViewController:upload animated:YES];

}
- (void)AmountDetail{
    AmoutDetailController * detail = [[AmoutDetailController alloc]init];
    [self.navigationController pushViewController:detail animated:YES];
}
- (void)addNavBarInfo{
    [self setNavTitle:@"我的互助额度"];
    // Do any additional setup after loading the view from its nib.
    self.detailLab.text = [NSString stringWithFormat:@"1.激活账户后，根据不同的激活方式，享有对应的互助额度，在您投资出现亏损时，平台会给你进行补贴；\n2.使用账户剩余MSC提升互助额度，1MSC提升10MSC互助额度；"];
   UIButton * btn = [PublicClass setRightTitleOnTargetNav:self action:@selector(AmountDetail) Title:@"明细"];
    [btn setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavBarInfo];

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
