//
//  deatilMoneyVc.m
//  BaseProject
//
//  Created by 李超杰 on 17/7/5.
//  Copyright © 2017年 cc. All rights reserved.

#define screenWidth [[UIScreen mainScreen] bounds].size.width
#define screenHeight [[UIScreen mainScreen] bounds].size.height

#import "deatilMoneyVc.h"
#import "UIColor+UIColor_Hex_color.h"
#import "UIFont+UIFont_MyFont.h"
#import "detailCell.h"
#import "deatilMoneyModel.h"


@interface deatilMoneyVc ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UITableView *detailMoneyTab;
@property(nonatomic,strong)UIButton *backBut;
@property(nonatomic,strong)NSMutableArray *mutableArr;

@end

@implementation deatilMoneyVc

static NSString *indentifier = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"ffffff"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar addSubview:self.titleLabel];
    [self.navigationController.navigationBar addSubview:self.backBut];
    self.mutableArr = [NSMutableArray arrayWithCapacity:1];
    
    [self.view addSubview:self.detailMoneyTab];
    [self loadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadData{
    
    [HttpRequest postPath:@"_mscaccount_001" params:nil resultBlock:^(id responseObject, NSError *error) {
        
        NSLog(@"快完了，弄好就可以下班了%@",responseObject);
        //        [ConfigModel mbProgressHUD:responseObject[@"info"] andView:nil];
        
        for (NSDictionary *dic  in responseObject[@"info"]) {
            
            deatilMoneyModel *model = [[deatilMoneyModel alloc]initWithShowInfor:dic];
            [self.mutableArr addObject:model];
            
        }
        [self.detailMoneyTab reloadData];
    }];
}


-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(80,0, screenWidth - 160, 44)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.text = @"MSC明细";
        
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

-(UITableView *)detailMoneyTab{
    
    if (!_detailMoneyTab) {
        self.detailMoneyTab = [[UITableView alloc]initWithFrame:CGRectMake(0,64, screenWidth,screenHeight-64)];
        self.detailMoneyTab.delegate = self;
        self.detailMoneyTab.dataSource = self;
        self.detailMoneyTab.rowHeight = 50;
        self.detailMoneyTab.showsHorizontalScrollIndicator = NO;
        self.detailMoneyTab.showsVerticalScrollIndicator = NO;
    }
    
    return _detailMoneyTab;
}

#pragma  make - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.mutableArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    detailCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    
    if (!cell) {
        
        cell = [[detailCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indentifier];
    }
    
    if (self.mutableArr.count > 0) {
        deatilMoneyModel *model = self.mutableArr[indexPath.row];
        [cell showData:model];
    }
    
    return cell;
}

#pragma  make - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
   
}

@end

