//
//  MyCenterRootViewController.m
//  BaseProject
//
//  Created by lxl on 2017/6/29.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "CenterRootViewController.h"

@interface CenterRootViewController ()

@end

@implementation CenterRootViewController
- (void)backtoTop{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (![self isRootViewController] ) {
        [self setNavigationBarBackgroundColor:[UIColor whiteColor]];
        [PublicClass setLeftButtonItemOnTargetNav:self action:@selector(backtoTop) image:[UIImage imageNamed:@"btn_fh_b"]];
    }
}
- (void)setNavTitle:(NSString *)str_title{
    [PublicClass seTitleViewOnTargetNav:self UIFont:[UIFont fontWithName:@"PingFang-SC" size:18] title:str_title textColor:UIColorFromHex(666666)];
}
//UINavigationBar+Color
- (void)setNavigationBarBackgroundColor:(UIColor*)color{
    UIImage *img = [PublicClass createImageWithColor:color size:CGSizeMake(1, 1)];
    [self.navigationController.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
}
- (BOOL)isRootViewController
{
    return (self == self.navigationController.viewControllers.firstObject);
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
