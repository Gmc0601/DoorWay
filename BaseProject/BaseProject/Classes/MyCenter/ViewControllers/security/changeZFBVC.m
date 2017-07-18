//
//  changeZFBVC.m
//  BaseProject
//
//  Created by 李超杰 on 17/6/29.
//  Copyright © 2017年 cc. All rights reserved.

#define screenWidth [[UIScreen mainScreen] bounds].size.width
#define screenHeight [[UIScreen mainScreen] bounds].size.height

#import "changeZFBVC.h"
#import "UIColor+UIColor_Hex_color.h"
#import "UIFont+UIFont_MyFont.h"

@interface changeZFBVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UITableView *passwordTab;
@property(nonatomic,strong)UIButton *backBut;
@property(nonatomic,strong)UITextField *passwor;
@property(nonatomic,strong)UITextField *surePassword;
@property(nonatomic,strong)UIButton *sureBut;

@end

@implementation changeZFBVC

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
        self.titleLabel.text = @"修改支付宝";
        
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

-(UITextField *)passwor{
    
    if (!_passwor) {
        
        self.passwor = [[UITextField alloc]initWithFrame:CGRectMake(100, 0, screenWidth - 140, 48)];
        self.passwor.textColor = [UIColor colorWithHexString:@"#333333"];
        self.passwor.placeholder = @"请输入支付宝账号" ;
        self.passwor.font = [UIFont SYSTEMFontOfSize:15];
        self.passwor.secureTextEntry = YES;
        self.passwor.returnKeyType = UIReturnKeyDone;
        self.passwor.delegate = self;
        self.passwor.clearButtonMode = UITextFieldViewModeAlways;
        self.passwor.tag = 1002;
    }
    
    return _passwor;
}

-(UITextField *)surePassword{
    
    if (!_surePassword) {
        
        self.surePassword = [[UITextField alloc]initWithFrame:CGRectMake(100, 0, screenWidth - 140, 48)];
        self.surePassword.textColor = [UIColor colorWithHexString:@"#333333"];
        self.surePassword.placeholder = @"请输入支付宝实名姓名" ;
        self.surePassword.font = [UIFont SYSTEMFontOfSize:15];
        self.surePassword.secureTextEntry = YES;
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
        self.sureBut.frame = CGRectMake(15,190,screenWidth - 30,48);
        
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
   
    if (![self.passwor.text isEqualToString:@""]&&![self.surePassword.text isEqualToString:@""]) {
        
            NSDictionary *dic = @{
                                  @"email":self.passwor.text,
                                  @"mobile":self.phoneStr,
                                  @"code":self.codeStr
                                  
                                  };
            [HttpRequest postPath:@"_updateuserali_001" params:dic resultBlock:^(id responseObject, NSError *error) {
                
                if ([responseObject[@"error"] intValue] == 0) {
                    
                    [ConfigModel mbProgressHUD:responseObject[@"info"] andView:nil];
                    [self backPress];
                }else {
                    [ConfigModel mbProgressHUD:responseObject[@"info"] andView:nil];
                }
                
            }];
    }else{
        
        [ConfigModel mbProgressHUD:@"输入不能为空" andView:nil];
    }
}

-(UITableView *)passwordTab{
    
    if (!_passwordTab) {
        self.passwordTab = [[UITableView alloc]initWithFrame:CGRectMake(0,64, screenWidth,96)];
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
            cell.textLabel.text = @"支付宝账号：";
            [cell addSubview:self.passwor];
            break;
        case 1:
            self.passwordTab.rowHeight = 48;
            cell.textLabel.text = @"支付宝实名：";
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
    
    if (pointLength > 25) {
        return NO;
    }else{
        return YES;
    }
    
}

@end




