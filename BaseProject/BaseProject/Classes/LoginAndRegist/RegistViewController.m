//
//  RegistViewController.m
//  BaseProject
//
//  Created by JeroMac on 2017/6/26.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "RegistViewController.h"
#import "RegistCodeViewController.h"
@interface RegistViewController ()

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)backBtn:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



- (IBAction)nestStepBtn:(UIButton *)sender {
    RegistCodeViewController  *registCodeVC = [[RegistCodeViewController alloc] init];
    [self.navigationController pushViewController: registCodeVC animated:YES];
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
