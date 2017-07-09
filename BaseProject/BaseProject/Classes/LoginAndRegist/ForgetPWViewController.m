//
//  ForgetPWViewController.m
//  BaseProject
//
//  Created by JeroMac on 2017/6/27.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "ForgetPWViewController.h"
#import "BaseViewController.h"

#import "ProtocolViewController.h"

#import <MBProgressHUD.h>
@interface ForgetPWViewController ()

@property(assign, nonatomic) NSInteger timeCount;
@property(strong, nonatomic) NSTimer *timer;

@property (weak, nonatomic) IBOutlet UIButton *getcodeBtn;
@property (weak, nonatomic) IBOutlet UITextField *ForgetAccountTF;
@property (weak, nonatomic) IBOutlet UITextField *ForgetCodeTF;
@property (weak, nonatomic) IBOutlet UITextField *ForgetPWTF;
@property (weak, nonatomic) IBOutlet UITextField *ForgetConfirmPWTF;

@end

@implementation ForgetPWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.getcodeBtn.layer.borderColor = RGBColor(55, 159, 242).CGColor;
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
//    titleLabel.text = @"忘记密码";
//    titleLabel.textColor = [UIColor whiteColor];
//    titleLabel.font = [UIFont systemFontOfSize:18];
//    self.navigationItem.titleView = titleLabel;
//    
//    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_fh_b"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickNewsBackBtn)];
    // Do any additional setup after loading the view from its nib.
//     [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];

}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
//}

- (void)clickNewsBackBtn{
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backPWBtn:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)ForgetGetCodeBtn:(UIButton *)sender {
    if ([self.ForgetAccountTF.text isEqualToString:@""]) {
        [ConfigModel mbProgressHUD:@"请输入正确的手机号" andView:self.view];
        return;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *ForgetcodeMudic = [NSMutableDictionary dictionary];
    [ForgetcodeMudic setObject:self.ForgetAccountTF.text forKey:@"mobile"];
    [HttpRequest postPath:@"_smsto_001" params:ForgetcodeMudic resultBlock:^(id responseObject, NSError *error) {
        NSLog(@"List>>>>>>%@", responseObject);
        NSDictionary *datadic = responseObject;
        hud.hidden = YES;
        [hud removeFromSuperview];
        if ([datadic[@"error"] intValue] == 0) {
            sender.userInteractionEnabled = NO;
            self.timeCount = 60;
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduceTime:) userInfo:sender repeats:YES];
            
            
        }else {
            NSString *info = datadic[@"info"];
            [ConfigModel mbProgressHUD:info andView:nil];
        }
        NSLog(@"error>>>>%@", error);
    }];
    
}
- (IBAction)ForgetPWBtn:(UIButton *)sender {
    
    if ([self.ForgetAccountTF.text isEqualToString:@""]){
        [ConfigModel mbProgressHUD:@"请输入手机号" andView:self.view];
        return;
    }else if ([self.ForgetCodeTF.text isEqualToString:@""]) {
        [ConfigModel mbProgressHUD:@"请输入验证码" andView:self.view];
        return;
    }else if ([self.ForgetPWTF.text isEqualToString:@""]){
        [ConfigModel mbProgressHUD:@"请输入密码" andView:self.view];
        return;
    }
    
    if (self.ForgetPWTF.text.length >= 6) {
        
    }else{
        [ConfigModel mbProgressHUD:@"请输入6-12位字母／数字" andView:self.view];
    }

    if ([self.ForgetPWTF.text isEqualToString:self.ForgetConfirmPWTF.text]) {
        
    }else{
        [ConfigModel mbProgressHUD:@"两次输入的密码不一样" andView:self.view];
        
    }
    
    NSMutableDictionary *ForgetFindCodeMudic = [NSMutableDictionary dictionary];
    [ForgetFindCodeMudic setObject:self.ForgetAccountTF.text forKey:@"mobile"];
     [ForgetFindCodeMudic setObject:self.ForgetCodeTF.text forKey:@"code"];
     [ForgetFindCodeMudic setObject:self.ForgetPWTF.text forKey:@"login_pwd"];
    [HttpRequest postPath:@"_set_pwd_003" params:ForgetFindCodeMudic resultBlock:^(id responseObject, NSError *error) {
        NSLog(@"List>>>>>>%@", responseObject);
        NSDictionary *datadic = responseObject;
        if ([datadic[@"error"] intValue] == 0) {
          [ConfigModel mbProgressHUD:@"您已经修改成功" andView:nil];
 
        }else {
            NSString *info = datadic[@"info"];
            [ConfigModel mbProgressHUD:info andView:nil];
        }
        NSLog(@"error>>>>%@", error);
    }];
    
    
    
}


- (void)reduceTime:(NSTimer *)codeTimer {
    self.timeCount--;
    if (self.timeCount == 0) {
        self.getcodeBtn.font = [UIFont systemFontOfSize:12];
        [self.getcodeBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        [self.getcodeBtn setTitleColor:RGBColor(55, 159, 242) forState:UIControlStateNormal];
        UIButton *info = codeTimer.userInfo;
        info.enabled = YES;
        self.getcodeBtn.userInteractionEnabled = YES;
        [self.timer invalidate];
    } else {
        self.getcodeBtn.font = [UIFont systemFontOfSize:12];
        NSString *str = [NSString stringWithFormat:@"%lu秒后重新获取", self.timeCount];
        [self.getcodeBtn setTitle:str forState:UIControlStateNormal];
        self.getcodeBtn.userInteractionEnabled = NO;
        
    }
    
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
