//
//  SecurityCenterVC.m
//  BaseProject
//
//  Created by 李超杰 on 17/7/3.
//  Copyright © 2017年 cc. All rights reserved.

#define screenWidth [[UIScreen mainScreen] bounds].size.width
#define screenHeight [[UIScreen mainScreen] bounds].size.height

#import "SecurityCenterVC.h"
#import "UIColor+UIColor_Hex_color.h"
#import "UIFont+UIFont_MyFont.h"
#import "changePasswordVC.h"
#import "changeEmailVC.h"
#import "changeZFBVC.h"

@interface SecurityCenterVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UITableView *passwordTab;
@property(nonatomic,strong)UIButton *backBut;
@property(nonatomic,strong)UITextField *passwor;
@property(nonatomic,strong)UITextField *surePassword;
@property(nonatomic,strong)UIButton *sureBut;
@property(nonatomic,strong)UILabel *explain;
@property(nonatomic,strong)UIButton *imageBut;
@property(nonatomic,strong)NSString *codeStr;
@property(nonatomic,strong)UILabel *codeLabel;
@property(nonatomic,assign)NSInteger choose;

@end

@implementation SecurityCenterVC

static NSString *indentifier = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"ffffff"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar addSubview:self.titleLabel];
    [self.navigationController.navigationBar addSubview:self.backBut];
    
    [self.view addSubview:self.passwordTab];
    [self.view addSubview:self.sureBut];
    [self.view addSubview:self.explain];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tap1.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap1];
    
}

-(void)viewTapped:(UITapGestureRecognizer*)tap1
{
    [self.view endEditing:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(80,0, screenWidth - 160, 44)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.text = @"安全中心";
        
    }
    return _titleLabel;
}

-(UIButton *)backBut{
    
    if (!_backBut) {
        
        self.backBut = [UIButton buttonWithType:UIButtonTypeCustom];
        self.backBut.frame = CGRectMake(0, 0, 44, 44);
        [self.backBut addTarget:self action:@selector(backPress) forControlEvents:UIControlEventTouchUpInside];
        [self.backBut setImage:[UIImage imageNamed:@"btn_fh_b"] forState:UIControlStateNormal];
        
    }
    
    return  _backBut;
}

-(void)backPress{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

-(UILabel *)explain{
    
    if (!_explain) {
        
        self.explain = [[UILabel alloc]initWithFrame:CGRectMake(15,64, screenWidth - 30, 48)];
        self.explain.textColor = [UIColor colorWithHexString:@"#999999"];
        self.explain.font = [UIFont SYSTEMFontOfSize:12];
        self.explain.text = @"请验证您的手机号以便后续操作";
        
    }
    return _explain;
}

-(UIButton *)imageBut{
    
    if (!_imageBut) {
        self.imageBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.imageBut setImage:[UIImage imageNamed:@"btn_zc_hqyzm"] forState:UIControlStateNormal];
        self.imageBut.frame = CGRectMake(screenWidth - 105, 2,90, 44);
        [self.imageBut addTarget:self action:@selector(getCodePress) forControlEvents:UIControlEventTouchUpInside];
        [self.imageBut setTitleColor:[UIColor colorWithHexString:@"#379ff2"] forState:UIControlStateNormal];
    }
    return _imageBut;
    
}
//获取验证码
-(void)getCodePress{
    
    NSDictionary *dic = @{
                          @"mobile":self.phoneStr
                          };
    
    [HttpRequest postPath:@"_sms_001" params:dic resultBlock:^(id responseObject, NSError *error) {
       
        if ([responseObject[@"error"] intValue] == 0) {
            
            self.codeStr =  responseObject[@"info"];
        }else {
            [ConfigModel mbProgressHUD:responseObject[@"info"] andView:nil];
        }
   }];
    
    [self time];
}

-(UILabel *)codeLabel{
    
    if (!_codeLabel) {
        
        self.codeLabel = [[UILabel alloc]initWithFrame: CGRectMake(screenWidth - 105, 2,90, 44)];
        self.codeLabel.textColor = [UIColor colorWithHexString:@"379ff2"];
        self.codeLabel.text = @"获取验证码";
        self.codeLabel.textAlignment = NSTextAlignmentCenter;
        self.codeLabel.font = [UIFont systemFontOfSize:12];
    
    }
    return _codeLabel;
}

-(void)time{
    
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [self.imageBut setImage:[UIImage imageNamed:@"btn_zc_hqyzm"] forState:UIControlStateNormal];
                [self.imageBut setTitle:@"" forState:UIControlStateNormal];
                
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                self.codeLabel.text = [NSString stringWithFormat:@"%.2ds", seconds];
                [self.imageBut setTitle:[NSString stringWithFormat:@"%.2ds", seconds] forState:UIControlStateNormal];
                [self.imageBut setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                
                
            });
            
            time--;
        }
    });
    dispatch_resume(_timer);
}

-(UITextField *)passwor{
    
    if (!_passwor) {
        
        self.passwor = [[UITextField alloc]initWithFrame:CGRectMake(80, 0,screenWidth - 190, 48)];
        self.passwor.textColor = [UIColor colorWithHexString:@"#333333"];
        self.passwor.text = self.phoneStr;
        self.passwor.font = [UIFont SYSTEMFontOfSize:15];
        self.passwor.userInteractionEnabled = NO;
        self.passwor.delegate = self;
        self.passwor.tag = 1002;
    }
    
    return _passwor;
}

-(UITextField *)surePassword{
    
    if (!_surePassword) {
        
        self.surePassword = [[UITextField alloc]initWithFrame:CGRectMake(80, 0, screenWidth - 140, 48)];
        self.surePassword.textColor = [UIColor colorWithHexString:@"#333333"];
        self.surePassword.placeholder = @"请输入4位验证码" ;
        self.surePassword.font = [UIFont SYSTEMFontOfSize:15];
        self.surePassword.returnKeyType = UIReturnKeyDone;
        self.surePassword.delegate = self;
        self.surePassword.clearButtonMode = UITextFieldViewModeAlways;
        self.surePassword.tag = 1002;
    }
    
    return _surePassword;
}

-(UIButton *)sureBut{
    
    if (!_sureBut) {
        
        self.sureBut = [UIButton buttonWithType:UIButtonTypeCustom];
        self.sureBut.frame = CGRectMake(15,238,screenWidth - 30,48);
        
        self.sureBut.backgroundColor = [UIColor colorWithHexString:@"#379ff2"];
        [self.sureBut addTarget:self action:@selector(surePress) forControlEvents:UIControlEventTouchUpInside];
        [self.sureBut setTitle:@"确定" forState:UIControlStateNormal];
        self.sureBut.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.sureBut.titleLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
        self.sureBut.layer.cornerRadius = 10;
        self.sureBut.layer.masksToBounds = YES;
        
    }
    return  _sureBut;
}

-(void)surePress{
    
     NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
     NSString *changeValue = [user objectForKey:@"changeValue"];
    
    if (![self.surePassword.text isEqualToString:@""]) {
       
        if ([self.surePassword.text isEqualToString:self.codeStr]) {
            if ([changeValue isEqualToString:@"0"]){
                
                changePasswordVC *password  = [[changePasswordVC alloc]init];
                password.phoneStr = self.phoneStr;
                password.codeStr = self.codeStr;
                [self popUp:password];
            }else if ([changeValue isEqualToString:@"1"]){
                
                changeEmailVC *email  = [[changeEmailVC alloc]init];
                email.phoneStr = self.phoneStr;
                email.codeStr = self.codeStr;
                [self popUp:email];
            }else if ([changeValue isEqualToString:@"2"]){
                
                changeZFBVC *zfb = [[changeZFBVC alloc]init];
                zfb.phoneStr = self.phoneStr;
                zfb.codeStr = self.codeStr;
                [self popUp:zfb];
                
            }
        } else {
          [ConfigModel mbProgressHUD:@"验证码不正确" andView:nil];
        }
 
    }else{
        
        [ConfigModel mbProgressHUD:@"验证码不能为空" andView:nil];
    }
}

-(void)popUp:(UIViewController *)Vc{
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:Vc];
    [self.navigationController presentViewController:nav animated:YES completion:^{
        
    }];
}



-(UITableView *)passwordTab{
    
    if (!_passwordTab) {
        self.passwordTab = [[UITableView alloc]initWithFrame:CGRectMake(0,112, screenWidth,96)];
        self.passwordTab.delegate = self;
        self.passwordTab.dataSource = self;
        self.passwordTab.rowHeight = 48;
        self.passwordTab.scrollEnabled = NO;
        self.passwordTab.showsHorizontalScrollIndicator = NO;
        
    }
    
    return _passwordTab;
}

#pragma  make - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier];
        
    }
    
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    cell.textLabel.font = [UIFont SYSTEMFontOfSize:15];
    
    switch (indexPath.row) {
        case 0:
            self.passwordTab.rowHeight = 48;
            cell.textLabel.text = @"手机号：";
            [cell addSubview:self.passwor];
            [cell addSubview:self.imageBut];
            break;
        case 1:
            self.passwordTab.rowHeight = 48;
            cell.textLabel.text = @"验证码：";
            [cell addSubview:self.surePassword];
            break;

        default:
            break;
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
   
}

#pragma marks - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    NSInteger pointLength = existedLength - selectedLength + replaceLength;
    
    if (pointLength > 4) {
        return NO;
    }else{
        return YES;
    }

}

@end
