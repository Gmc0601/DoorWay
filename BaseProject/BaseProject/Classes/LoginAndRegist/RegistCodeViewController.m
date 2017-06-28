//
//  RegistCodeViewController.m
//  BaseProject
//
//  Created by JeroMac on 2017/6/26.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "RegistCodeViewController.h"
#import "ConfigModel.h"
#import <MBProgressHUD.h>
#import "registNameViewController.h"


@interface RegistCodeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *regist2GetCodeBtn;
@property(assign, nonatomic) NSInteger timeCount;
@property(strong, nonatomic) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;

@end

@implementation RegistCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.regist2GetCodeBtn.layer.borderColor = RGBColor(55, 159, 242).CGColor;
    self.regist2GetCodeBtn.layer.cornerRadius = 3;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
    titleLabel.text = @"注册";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = titleLabel;
    
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_fh_b"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickRegist2BackBtn)];
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)codeBtn:(UIButton *)sender {
    if ([self.accountTF.text isEqualToString:@""]) {
        [ConfigModel mbProgressHUD:@"请输入正确的手机号" andView:self.view];
        return;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    NSMutableDictionary *codeMudic = [NSMutableDictionary dictionary];
    [codeMudic setObject:self.accountTF.text forKey:@"mobile"];
    [HttpRequest postPath:@"_sms_002" params:codeMudic resultBlock:^(id responseObject, NSError *error) {
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


//        sender.userInteractionEnabled = NO;
//        self.timeCount = 60;
//        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduceTime:) userInfo:sender repeats:YES];
    
    
    
//    [HttpTool postWithUrl:@"ValidateCode.action" param:dic success:^(id responseObj) {
//        hud.hidden = YES;
//        [hud removeFromSuperview];
//        
//        if ([responseObj[@"success"] intValue]) {
//            sender.userInteractionEnabled = NO;
//            self.timeCount = 60;
//            self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduceTime:) userInfo:sender repeats:YES];
//            //    _codeTF.text     = [NSString stringWithFormat:@"%@",responseObj[@"obj"]];
//        }else{
//            NSString *STR = responseObj[@"obj"];
//            [self showHint:STR];
//            return ;
//        };
//    } failure:^(NSError *error) {
//        NSLog(@"689%@", error);
//        hud.hidden = YES;
//        [hud removeFromSuperview];
//        if ([HttpTool connectedToNetwork]) {
//            [self showHint:@"登录失败"];
//            return ;
//        }else{
//            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络连接失败,请查看网络是否连接正常！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alert show];
//        }
//    }];
    
    
}






- (void)reduceTime:(NSTimer *)codeTimer {
    self.timeCount--;
    if (self.timeCount == 0) {
        self.regist2GetCodeBtn.font = [UIFont systemFontOfSize:12];
        [self.regist2GetCodeBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        [self.regist2GetCodeBtn setTitleColor:RGBColor(55, 159, 242) forState:UIControlStateNormal];
        UIButton *info = codeTimer.userInfo;
        info.enabled = YES;
        self.regist2GetCodeBtn.userInteractionEnabled = YES;
        [self.timer invalidate];
    } else {
        self.regist2GetCodeBtn.font = [UIFont systemFontOfSize:12];
        NSString *str = [NSString stringWithFormat:@"%lu秒后重新获取", self.timeCount];
        [self.regist2GetCodeBtn setTitle:str forState:UIControlStateNormal];
        self.regist2GetCodeBtn.userInteractionEnabled = NO;
        
    }
    
}
- (void)clickRegist2BackBtn{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)registNameBtn:(UIButton *)sender {
   
    registNameViewController  *registNameVC = [[registNameViewController alloc] init];
    registNameVC.codeStr = self.codeTF.text;
    registNameVC.mobileStr = self.accountTF.text;
    [self.navigationController pushViewController:registNameVC animated:YES];
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
