//
//  registNameViewController.m
//  BaseProject
//
//  Created by JeroMac on 2017/6/27.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "registNameViewController.h"
#import "ProtocolViewController.h"
#import "NSString+MD5.h"

#import "TBTabBarController.h"
#import "AppDelegate.h"
@interface registNameViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nickTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *confirmPWTF;
@property (weak, nonatomic) IBOutlet UITextField *mailTF;
@property (weak, nonatomic) IBOutlet UITextField *zhifubaoTF;
@property (weak, nonatomic) IBOutlet UITextField *zhifubaoNameTF;

@end

@implementation registNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
    titleLabel.text = @"注册";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = titleLabel;
    
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_fh_b"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickRegist3BackBtn)];
    // Do any additional setup after loading the view from its nib.
}


- (void)clickRegist3BackBtn{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleDefault animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle =UIStatusBarStyleLightContent;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)registResultBtn:(UIButton *)sender {
    if ([self.nickTF.text isEqualToString:@""]) {
        [ConfigModel mbProgressHUD:@"请输入昵称" andView:self.view];
        return;
    }else if ([self.passwordTF.text isEqualToString:@""]){
        [ConfigModel mbProgressHUD:@"请输入密码" andView:self.view];
        return;
    }else if ([self.mailTF.text isEqualToString:@""]){
        [ConfigModel mbProgressHUD:@"请输入邮箱" andView:self.view];
        return;
    }else if ([self.zhifubaoTF.text isEqualToString:@""]){
        [ConfigModel mbProgressHUD:@"请输入支付宝账号" andView:self.view];
        return;
    }else if ([self.zhifubaoNameTF.text isEqualToString:@""]){
        [ConfigModel mbProgressHUD:@"请输入支付宝实名" andView:self.view];
        return;
    }
    if (self.passwordTF.text.length >= 6) {
        
    }else{
        [ConfigModel mbProgressHUD:@"请输入6-12位字母／数字" andView:self.view];
    }
    
    
    
    if ([self.passwordTF.text isEqualToString:self.confirmPWTF.text]) {
        
    }else{
        [ConfigModel mbProgressHUD:@"两次输入的密码不一样" andView:self.view];

    }
//    NSString *MD5Str = [self.passwordTF.text md5WithString];
    
    NSMutableDictionary *registMudic = [NSMutableDictionary dictionary];
    [registMudic setObject:self.mobileStr forKey:@"mobile"];
     [registMudic setObject:self.codeStr forKey:@"code"];
     [registMudic setObject:self.passwordTF.text forKey:@"loginPass"];
     [registMudic setObject:self.nickTF.text forKey:@"nickname"];
     [registMudic setObject:self.mailTF.text forKey:@"email"];
     [registMudic setObject:self.zhifubaoTF.text forKey:@"alipay_account"];
     [registMudic setObject:self.zhifubaoNameTF.text forKey:@"alipay_name"];
    [HttpRequest postPath:@"_register_001" params:registMudic resultBlock:^(id responseObject, NSError *error) {
        NSLog(@"List>>>>>>%@", responseObject);
        NSDictionary *datadic = responseObject;

        if ([datadic[@"error"] intValue] == 0) {
            [ConfigModel mbProgressHUD:@"恭喜注册成功" andView:nil];
            
            [self performSelector:@selector(backHomePage) withObject:nil afterDelay:2.0];

            
        }else {
            NSString *info = datadic[@"info"];
            [ConfigModel mbProgressHUD:info andView:nil];
        }
        NSLog(@"error>>>>%@", error);
    }];
    
}

- (void)backHomePage{
    TBTabBarController *TBVC = [[TBTabBarController alloc] init];
    UIApplication *app = [UIApplication sharedApplication];
    AppDelegate *app2 = app.delegate;
    app2.window.rootViewController = TBVC;
}

- (IBAction)registNameBackBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (IBAction)ProtocolBtn:(UIButton *)sender {
    ProtocolViewController *protocolVC = [[ProtocolViewController alloc] init];
    UINavigationController *nV = [[UINavigationController alloc] initWithRootViewController:protocolVC];
    [self presentViewController:nV animated:YES completion:nil];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.zhifubaoNameTF resignFirstResponder];
    [self.zhifubaoTF resignFirstResponder];
    [self.mailTF resignFirstResponder];
    [self.nickTF resignFirstResponder];
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
