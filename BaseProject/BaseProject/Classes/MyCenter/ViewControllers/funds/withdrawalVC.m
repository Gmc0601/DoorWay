//
//  withdrawalVC.m
//  BaseProject
//
//  Created by 李超杰 on 17/7/5.
//  Copyright © 2017年 cc. All rights reserved.
//
#define screenWidth [[UIScreen mainScreen] bounds].size.width
#define screenHeight [[UIScreen mainScreen] bounds].size.height

#import "withdrawalVC.h"
#import "UIColor+UIColor_Hex_color.h"
#import "UIFont+UIFont_MyFont.h"
#import "pulicMath.h"

@interface withdrawalVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UITableView *transferTab;
@property(nonatomic,strong)UIButton *backBut;
@property(nonatomic,strong)UITextField *phoneText;
@property(nonatomic,strong)UITextField *moneyText;
@property(nonatomic,strong)UIButton *sureBut;
@property(nonatomic,strong)UILabel *moneyLabel;
@property(nonatomic,strong)UILabel *explainLabel;


@end

@implementation withdrawalVC

static NSString *indentifier = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"ffffff"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar addSubview:self.titleLabel];
    [self.navigationController.navigationBar addSubview:self.backBut];
    
    [self.view addSubview:self.transferTab];
    [self.view addSubview:self.sureBut];
    [self.view addSubview:self.moneyLabel];
    [self.view addSubview:self.explainLabel];
    
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
        self.titleLabel.text = @"提现";
        
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

-(UITextField *)phoneText{
    
    if (!_phoneText) {
        
        self.phoneText = [[UITextField alloc]initWithFrame:CGRectMake(80, 0, screenWidth - 95, 48)];
        self.phoneText.textColor = [UIColor colorWithHexString:@"#333333"];
        self.phoneText.text = self.aliPay ;
        self.phoneText.font = [UIFont SYSTEMFontOfSize:15];
        self.phoneText.returnKeyType = UIReturnKeyDone;
        self.phoneText.delegate = self;
        self.phoneText.textAlignment = NSTextAlignmentRight;
        self.phoneText.userInteractionEnabled = NO;
    }
    
    return _phoneText;
}

-(UITextField *)moneyText{
    
    if (!_moneyText) {
        
        self.moneyText = [[UITextField alloc]initWithFrame:CGRectMake(90, 0, screenWidth - 120, 48)];
        self.moneyText.textColor = [UIColor colorWithHexString:@"#333333"];
        self.moneyText.placeholder = @"请填写提现的MSC金额" ;
        self.moneyText.font = [UIFont SYSTEMFontOfSize:15];
        self.moneyText.returnKeyType = UIReturnKeyDone;
        self.moneyText.delegate = self;
        self.moneyText.keyboardType = UIKeyboardTypeNumberPad;
        self.moneyText.clearButtonMode = UITextFieldViewModeAlways;
        self.moneyText.tag = 1002;
    }
    
    return _moneyText;
}

-(UIButton *)sureBut{
    
    if (!_sureBut) {
        
        self.sureBut = [UIButton buttonWithType:UIButtonTypeCustom];
        self.sureBut.frame = CGRectMake(15,210,screenWidth - 30,48);
        
        self.sureBut.backgroundColor = [UIColor colorWithHexString:@"#379ff2"];
        [self.sureBut addTarget:self action:@selector(surePress) forControlEvents:UIControlEventTouchUpInside];
        [self.sureBut setTitle:@"提交审核" forState:UIControlStateNormal];
        self.sureBut.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.sureBut.titleLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
        self.sureBut.layer.cornerRadius = 5;
        self.sureBut.layer.masksToBounds = YES;
        
    }
    return  _sureBut;
}

-(void)surePress{
    
    if ([pulicMath isBlankString:self.moneyText.text]) {
        
            if ([self.moneyText.text integerValue] < [self.money integerValue]) {
                NSDictionary *dic = @{
                                      @"amount":self.moneyText.text,
                                      @"mobile":self.phoneText.text,
                                      };
                [HttpRequest postPath:@"_mscwithdraws_001" params:dic resultBlock:^(id responseObject, NSError *error) {
                    
                    NSLog(@"提现成功:%@",responseObject);
                    
                    if ([responseObject[@"error"] integerValue] == 0) {
                        
                        [ConfigModel mbProgressHUD:@"提现成功" andView:nil];
                        NSString *money = [NSString stringWithFormat:@"%@",responseObject[@"info"]];
                        [self.delegate money:money];
                        [self backPress];
                    } else {
                        
                        [ConfigModel mbProgressHUD:responseObject[@"info"] andView:nil];
                    }
                }];
                
            } else {
                [ConfigModel mbProgressHUD:@"转账金额大于余额" andView:nil];
            }
    }else{
        
        [ConfigModel mbProgressHUD:@"输入不能为空" andView:nil];
    }
}



-(UILabel *)moneyLabel{
    
    if (!_moneyLabel) {
        self.moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 185, screenWidth - 30, 15)];
        self.moneyLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        self.moneyLabel.font = [UIFont SYSTEMFontOfSize:12];
        self.moneyLabel.text = [NSString stringWithFormat:@"剩余%@MSC可提现",self.money];
        [self label:self.moneyLabel allStr:self.moneyLabel.text rangeStr:[NSString stringWithFormat:@"%@MSC",self.money]];
    }
    return _moneyLabel;
}

//label显示不同字体颜色
-(void)label:(UILabel *)label allStr:(NSString *)allStr rangeStr:(NSString *)rangeStr{
    
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString: allStr];
    NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:rangeStr].location, [[noteStr string] rangeOfString:rangeStr].length);
    //需要设置的位置
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#379ff2"] range:redRange];
    //设置颜色
    [label setAttributedText:noteStr];
}

-(UILabel *)explainLabel{
    
    if (!_explainLabel) {
        self.explainLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 273, screenWidth - 30, 15)];
        self.explainLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        self.explainLabel.font = [UIFont SYSTEMFontOfSize:12];
        self.explainLabel.text = @"注：100MSC = 1元";
        self.explainLabel.numberOfLines = 0;
    }
    return _explainLabel;
}

-(UITableView *)transferTab{
    
    if (!_transferTab) {
        self.transferTab = [[UITableView alloc]initWithFrame:CGRectMake(0,64, screenWidth,96)];
        self.transferTab.delegate = self;
        self.transferTab.dataSource = self;
        self.transferTab.rowHeight = 48;
        self.transferTab.scrollEnabled = NO;
        self.transferTab.showsHorizontalScrollIndicator = NO;
        
    }
    
    return _transferTab;
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
            self.transferTab.rowHeight = 48;
            cell.textLabel.text = @"收款支付宝：";
            [cell addSubview:self.phoneText];
            break;
        case 1:
            self.transferTab.rowHeight = 48;
            cell.textLabel.text = @"提现金额：";
            [cell addSubview:self.moneyText];
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
    
    if (pointLength > 10) {
        return NO;
    }else{
        return YES;
    }
 
}


@end
