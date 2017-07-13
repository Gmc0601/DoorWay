//
//  securityVC.m
//  BaseProject
//
//  Created by 李超杰 on 17/6/29.
//  Copyright © 2017年 cc. All rights reserved.
//

#define screenWidth [[UIScreen mainScreen] bounds].size.width
#define screenHeight [[UIScreen mainScreen] bounds].size.height

#import "securityVC.h"
#import "UIColor+UIColor_Hex_color.h"
#import "UIFont+UIFont_MyFont.h"
#import "changePasswordVC.h"
#import "changeEmailVC.h"
#import "changeZFBVC.h"
#import "SecurityCenterVC.h"


@interface securityVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UITableView *securityTab;
@property(nonatomic,strong)UIButton *backBut;
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)NSString *zfb;
@property(nonatomic,strong)NSString *phoneStr;

@end

@implementation securityVC

static NSString *indentifier = @"cell";

-(void)viewWillAppear:(BOOL)animated{
    
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"ffffff"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar addSubview:self.titleLabel];
    [self.navigationController.navigationBar addSubview:self.backBut];
    
    [self.view addSubview:self.securityTab];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadData{
  
    [HttpRequest postPath:@"_userinfolist_001" params:nil resultBlock:^(id responseObject, NSError *error) {
        
        NSDictionary *dataDic = responseObject;
        if ([dataDic[@"error"] intValue] == 0) {
            //
            self.email = responseObject[@"info"][@"email"];
            self.zfb = responseObject[@"info"][@"alipay_account"];
            self.phoneStr = responseObject[@"info"][@"mobile"];
             [self.securityTab reloadData];
        }else {
            //
            [ConfigModel mbProgressHUD:dataDic[@"info"] andView:nil];
        }

    }];
    
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

-(UITableView *)securityTab{
    
    if (!_securityTab) {
        self.securityTab = [[UITableView alloc]initWithFrame:CGRectMake(0,64, screenWidth,144)];
        self.securityTab.delegate = self;
        self.securityTab.dataSource = self;
        self.securityTab.rowHeight = 48;
        self.securityTab.scrollEnabled = NO;
        self.securityTab.showsHorizontalScrollIndicator = NO;
        
    }
    
    return _securityTab;
}

#pragma  make - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indentifier];
        
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    cell.textLabel.font = [UIFont SYSTEMFontOfSize:15];
    cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    cell.detailTextLabel.font = [UIFont SYSTEMFontOfSize:13];
    
    if (indexPath.row == 0){
        
        cell.textLabel.text = @"修改密码";
        
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"邮箱";
        cell.detailTextLabel.text = self.email;
        
    }else if (indexPath.row == 2){
        
        cell.textLabel.text = @"支付宝账号";
        cell.detailTextLabel.text = self.zfb;
    }
    
    return cell;
}



#pragma  make - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
   
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
   
    SecurityCenterVC *password  = [[SecurityCenterVC alloc]init];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:[NSString stringWithFormat:@"%ld",indexPath.row] forKey:@"changeValue"];
    
    password.phoneStr = self.phoneStr;
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:password];
    [self.navigationController presentViewController:nav animated:YES completion:^{
        
    }];

}

@end

