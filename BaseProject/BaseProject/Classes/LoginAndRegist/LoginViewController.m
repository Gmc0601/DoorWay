//
//  LoginViewController.m
//  BaseProject
//
//  Created by cc on 2017/6/26.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"

#import "ForgetPWViewController.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//      [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bar_bg"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_phb"] forBarMetrics:UIBarMetricsDefault];
   
}



- (IBAction)registBtn:(UIButton *)sender {
    RegistViewController *registVC = [[RegistViewController alloc] init];
    [self presentViewController:registVC animated:YES completion:nil];
//    [self.navigationController pushViewController:registVC animated:YES];
    
}



- (IBAction)findBackPWBtn:(UIButton *)sender {
    ForgetPWViewController *forgetPW = [[ForgetPWViewController alloc ] init];
    [self presentViewController:forgetPW animated:YES completion:nil];
}

- (IBAction)loginBtn:(UIButton *)sender {
     NSString *uuidStr = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSMutableDictionary *mudicLogin = [NSMutableDictionary dictionary];
    [mudicLogin setObject:self.accountTF.text forKey:@"username"];
    [mudicLogin setObject:self.passwordTF.text forKey:@"loginPass"];
    [mudicLogin setObject:uuidStr forKey:@"device_number"];
    [HttpRequest postPath:LoginURL params:mudicLogin resultBlock:^(id responseObject, NSError *error) {
        
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        
        NSLog(@"login>>>>>>%@", responseObject);
        NSDictionary *datadic = responseObject;
        if ([datadic[@"error"] intValue] == 0) {
//            NSDictionary *infoDic = datadic[@"info"];
//            NSString *usertoken = infoDic[@"userToken"];
//            [ConfigModel saveBoolObject:YES forKey:IsLogin];
//            [ConfigModel saveString:usertoken forKey:UserToken];
            [ConfigModel mbProgressHUD:@"登陆成功" andView:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else {
            NSString *info = datadic[@"info"];
            [ConfigModel mbProgressHUD:info andView:nil];
        }
        NSLog(@"error>>>>%@", error);
    }];

    
    
}

- (IBAction)BackBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
