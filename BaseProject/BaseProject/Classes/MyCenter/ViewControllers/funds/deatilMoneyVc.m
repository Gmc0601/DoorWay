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
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIView *errorView;
@property(nonatomic,strong)UILabel *errorTitle;
@property(nonatomic,strong)UITextView *errorText;
@property(nonatomic,strong)UIButton *errorBut;





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
    
    [self.bgView addSubview:self.errorView];
    [self.errorView addSubview:self.errorTitle];
    [self.errorView addSubview:self.errorBut];
    [self.errorView addSubview:self.errorText];
    
    [self.view addSubview:self.detailMoneyTab];
    [self loadData];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tap1.cancelsTouchesInView = NO;
    [self.bgView addGestureRecognizer:tap1];
    
}

-(void)viewTapped:(UITapGestureRecognizer*)tap1
{
    [self.bgView removeFromSuperview];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadData{
    
    [HttpRequest postPath:@"_mscaccount_001" params:nil resultBlock:^(id responseObject, NSError *error) {
        
    if ([responseObject[@"error"] intValue] == 0) {
        for (NSDictionary *dic  in responseObject[@"info"]) {
            
            deatilMoneyModel *model = [[deatilMoneyModel alloc]initWithShowInfor:dic];
            [self.mutableArr addObject:model];
            
        }

        [self.detailMoneyTab reloadData];
    }else {
        
        [ConfigModel mbProgressHUD:responseObject[@"info"] andView:nil];
    }
        
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
    
    [cell.stateBut addTarget:self action:@selector(statePress:) forControlEvents:UIControlEventTouchUpInside];
    if (self.mutableArr.count > 0) {
        
        deatilMoneyModel *model = self.mutableArr[indexPath.row];
        [cell showData:model];
    }
    
    return cell;
}

-(void)statePress:(UIButton *)but{
    
    detailCell *cell = (detailCell *)[but superview];
    NSIndexPath *index = [self.detailMoneyTab indexPathForCell:cell];
    deatilMoneyModel *model = self.mutableArr[index.row];
    self.errorText.text = model.cause;
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.bgView];
}

#pragma  make - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

}

-(UIView *)bgView{
    
    if (!_bgView) {
        self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
        self.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.38];
        
    }
    return _bgView;
}

-(UIView *)errorView{
    
    if (!_errorView) {
        self.errorView = [[UIView alloc]initWithFrame:CGRectMake((screenWidth-300)/2,(screenHeight - 176)/2, 300, 176)];
        self.errorView.backgroundColor = [UIColor whiteColor];
        self.errorView.layer.cornerRadius = 5;
        self.errorView.layer.masksToBounds = YES;
        self.errorView.alpha = 1;
    }
    return _errorView;
}

-(UILabel *)errorTitle{
    
    if (!_errorTitle) {
        self.errorTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, 300, 20)];
        self.errorTitle.text = @"失败原因";
        self.errorTitle.textColor = [UIColor colorWithHexString:@"#333333"];
        self.errorTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _errorTitle;
}

-(UITextView *)errorText{
    
    if (!_errorText) {
        self.errorText = [[UITextView alloc]initWithFrame:CGRectMake(15, 65, 270, 35)];
        self.errorText.font = [UIFont SYSTEMFontOfSize:15];
        self.errorText.textColor = [UIColor colorWithHexString:@"#333333"];
        self.errorText.editable = NO;
    }
    
    return _errorText;
}

-(UIButton *)errorBut{
    
    if (!_errorBut) {
        self.errorBut = [UIButton buttonWithType:UIButtonTypeCustom];
        self.errorBut.frame = CGRectMake(15, 117, 270, 44);
        [self.errorBut setTitle:@"知道了" forState:UIControlStateNormal];
        self.errorBut.backgroundColor = [UIColor colorWithHexString:@"#379ff2"];
         [self.errorBut addTarget:self action:@selector(errorPress) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _errorBut;
}

-(void)errorPress{
    
    [self.bgView removeFromSuperview];
}

@end

