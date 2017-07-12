//
//  fundsVC.m
//  BaseProject
//
//  Created by 李超杰 on 17/7/3.
//  Copyright © 2017年 cc. All rights reserved.
//
#define screenWidth [[UIScreen mainScreen] bounds].size.width
#define screenHeight [[UIScreen mainScreen] bounds].size.height

#import "fundsVC.h"
#import "UIColor+UIColor_Hex_color.h"
#import "UIFont+UIFont_MyFont.h"
#import "deatilMoneyVc.h"
#import "transferVC.h"
#import "withdrawalVC.h"


@interface fundsVC ()<withdrawaDeledata,transferDeledata>

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIButton *backBut;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIButton *rightBut;
@property(nonatomic,strong)UILabel *remaining;
@property(nonatomic,strong)UILabel *remainingMoney;
@property(nonatomic,strong)UIButton *transferBut;
@property(nonatomic,strong)UIButton *withdrawalBut;
@property(nonatomic,strong)UILabel *explainLabel;
@property(nonatomic,strong)UITextView *explainView;
@property(nonatomic,strong)NSString *money;
@property(nonatomic,strong)NSString *aliPay;
@end

@implementation fundsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.backBut];
    [self.bgView addSubview:self.rightBut];
    [self.bgView addSubview:self.remainingMoney];
    [self.bgView addSubview:self.remaining];
    [self.bgView addSubview:self.transferBut];
    [self.bgView addSubview:self.withdrawalBut];
    [self.view addSubview: self.explainLabel];
    [self.view addSubview: self.explainView];
    [self.navigationController.navigationBar setHidden:YES];
    [self loadData];
    
}

-(void)loadData{
    
    [HttpRequest postPath:@"_userinfolist_001" params:nil resultBlock:^(id responseObject, NSError *error) {
        
        NSDictionary *dataDic = responseObject;
        if ([dataDic[@"error"] intValue] == 0) {

            self.money = responseObject[@"info"][@"userlimit"];
            self.remainingMoney.text = self.money;
            self.aliPay = responseObject[@"info"][@"alipay_account"];

            NSLog(@"任他吗的都是自私的：%@",responseObject);
        }else {
            //
            [ConfigModel mbProgressHUD:dataDic[@"info"] andView:nil];
        }
        
    }];

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIView *)bgView {
    
    if (!_bgView) {
        self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, -20, screenWidth, 315)];
        self.bgView.backgroundColor = [UIColor colorWithHexString:@"#379ff2"];
    }
    
    return _bgView;
}

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(80,40, screenWidth - 160, 44)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.text = @"资金管理";
    }
    return _titleLabel;
}

-(UIButton *)backBut{
    
    if (!_backBut) {
        
        self.backBut = [UIButton buttonWithType:UIButtonTypeCustom];
        self.backBut.frame = CGRectMake(0, 40, 44, 44);
        [self.backBut addTarget:self action:@selector(backPress) forControlEvents:UIControlEventTouchUpInside];
        [self.backBut setImage:[UIImage imageNamed:@"btn_fh_w"] forState:UIControlStateNormal];
        
    }
    
    return  _backBut;
}

-(void)backPress{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

-(UIButton *)rightBut{
    
    if (!_rightBut) {
        
        self.rightBut = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightBut.frame = CGRectMake(screenWidth - 59, 40, 44, 44);
        [self.rightBut addTarget:self action:@selector(rightButPress) forControlEvents:UIControlEventTouchUpInside];
        [self.rightBut setTitle:@"明细" forState:UIControlStateNormal];
        self.rightBut.titleLabel.font = [UIFont SYSTEMFontOfSize:15];
        
    }
    
    return  _rightBut;
}

-(void)rightButPress{
    
    deatilMoneyVc *detail = [[deatilMoneyVc alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:detail];
    [self.navigationController presentViewController:nav animated:YES completion:^{
        
    }];
    
}

-(UILabel *)remaining{
    
    if (!_remaining) {
        
        self.remaining = [[UILabel alloc]initWithFrame:CGRectMake(80,132, screenWidth - 160, 20)];
        self.remaining.textAlignment = NSTextAlignmentCenter;
        self.remaining.textColor = [UIColor whiteColor];
        self.remaining.text = @"账户剩余MSC";
        self.remaining.font = [UIFont SYSTEMFontOfSize:15];
    }
    return _remaining;
}

-(UILabel *)remainingMoney{
    
    if (!_remainingMoney) {
        
        self.remainingMoney = [[UILabel alloc]initWithFrame:CGRectMake(80,167, screenWidth - 160, 30)];
        self.remainingMoney.textAlignment = NSTextAlignmentCenter;
        self.remainingMoney.textColor = [UIColor whiteColor];
        self.remainingMoney.text = self.money;
        self.remainingMoney.font = [UIFont SYSTEMFontOfSize:30];
    }
    return _remainingMoney;
}


-(UIButton *)transferBut{
    
    if (!_transferBut) {
        
        self.transferBut = [UIButton buttonWithType:UIButtonTypeCustom];
        self.transferBut.frame = CGRectMake((screenWidth-249)/2, 243,107, 32);
        [self.transferBut addTarget:self action:@selector(transferPress) forControlEvents:UIControlEventTouchUpInside];
        [self.transferBut setImage:[UIImage imageNamed:@"btn_zz"] forState:UIControlStateNormal];
    }
    
    return  _transferBut;
}

-(void)transferPress{
    
    transferVC *detail = [[transferVC alloc]init];
    detail.money = self.money;
    detail.delegate = self;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:detail];
    [self.navigationController presentViewController:nav animated:YES completion:^{
        
    }];
    
}

-(void)transferMoney:(NSString *)money{
    
   self.remainingMoney.text = money;
}

-(UIButton *)withdrawalBut{
    
    if (!_withdrawalBut) {
        
        self.withdrawalBut = [UIButton buttonWithType:UIButtonTypeCustom];
        self.withdrawalBut.frame = CGRectMake((screenWidth-249)/2+107+35, 243,107, 32);
        [self.withdrawalBut addTarget:self action:@selector(withDarawalPress) forControlEvents:UIControlEventTouchUpInside];
        [self.withdrawalBut setImage:[UIImage imageNamed:@"btn_tx"] forState:UIControlStateNormal];
    }
    
    return  _withdrawalBut;
}

-(void)withDarawalPress{
    
    withdrawalVC *detail = [[withdrawalVC alloc]init];
    detail.money = self.money;
    detail.aliPay = self.aliPay;
    detail.delegate = self;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:detail];
    [self.navigationController presentViewController:nav animated:YES completion:^{
        
    }];

}
-(void)money:(NSString *)money{
    
    self.remainingMoney.text = money;
    
}

-(UILabel *)explainLabel{
    
    if (!_explainLabel) {
        
        self.explainLabel = [[UILabel alloc]initWithFrame:CGRectMake(16,315, screenWidth - 32, 20)];
        self.explainLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        self.explainLabel.text = @"MSC货币介绍";
        self.explainLabel.font = [UIFont SYSTEMFontOfSize:15];
    }
    return _explainLabel;
}

-(UITextView *)explainView{
    
    if (!_explainView) {
        
        self.explainView = [[UITextView alloc]initWithFrame:CGRectMake(16,340, screenWidth - 32, screenHeight - 355)];
        self.explainView.textColor = [UIColor colorWithHexString:@"#999999"];
        self.explainView.text = @"MSC货币介绍";
        self.explainView.font = [UIFont SYSTEMFontOfSize:15];
        self.explainView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    }
    return _explainView;
}

@end
