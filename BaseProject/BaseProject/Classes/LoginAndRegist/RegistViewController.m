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
@property (weak, nonatomic) IBOutlet UITextField *regist1TF;

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
    titleLabel.text = @"注册";
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = titleLabel;
    
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_fh_b"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickRegist1BackBtn)];
    // Do any additional setup after loading the view from its nib.
}

- (void)clickRegist1BackBtn{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleDefault animated:YES];
     [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bar_bg"] forBarMetrics:UIBarMetricsDefault];
 
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle =UIStatusBarStyleLightContent;
    
}
- (IBAction)backBtn:(UIButton *)sender {
    [self  dismissViewControllerAnimated:YES completion:nil];
}



- (IBAction)nestStepBtn:(UIButton *)sender {
    NSMutableDictionary *regist1Mudic = [NSMutableDictionary dictionary];
    [regist1Mudic setObject:self.regist1TF.text forKey:@"invitationcode"];
    
    [HttpRequest postPath:@"_invitationcode_001" params:regist1Mudic resultBlock:^(id responseObject, NSError *error) {
        
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        
        NSLog(@"login>>>>>>%@", responseObject);
        NSDictionary *datadic = responseObject;
        if ([datadic[@"error"] intValue] == 0) {
            RegistCodeViewController  *registCodeVC = [[RegistCodeViewController alloc] init];
            registCodeVC.inventedStr = self.regist1TF.text;
//            [self presentViewController:registCodeVC animated:YES completion:nil];
            [self.navigationController pushViewController:registCodeVC animated:YES];
        }else {
            NSString *info = datadic[@"info"];
            [ConfigModel mbProgressHUD:info andView:nil];
        }
        NSLog(@"error>>>>%@", error);
    }];

    
//    RegistCodeViewController  *registCodeVC = [[RegistCodeViewController alloc] init];
//    [self presentViewController:registCodeVC animated:YES completion:nil];
    
    
    

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.regist1TF resignFirstResponder];

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
