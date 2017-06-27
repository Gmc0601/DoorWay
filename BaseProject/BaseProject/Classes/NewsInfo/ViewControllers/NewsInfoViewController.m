//
//  NewsInfoViewController.m
//  BaseProject
//
//  Created by cc on 2017/6/26.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "NewsInfoViewController.h"
#import "LoginViewController.h"
#import "ViewController.h"
@interface NewsInfoViewController ()

@end

@implementation NewsInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomerTitle: @"新闻资讯"];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:FRAME(100, 100, 100, 100)];
    btn.backgroundColor = [UIColor yellowColor];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    // Do any additional setup after loading the view.
}
- (void)click:(id)sender {
    [self presentViewController:[ViewController new] animated:YES completion:^{
        
    }];
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
