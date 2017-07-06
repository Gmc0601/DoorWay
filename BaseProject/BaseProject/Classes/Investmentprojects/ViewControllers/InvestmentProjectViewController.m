//
//  InvestmentProjectViewController.m
//  BaseProject
//
//  Created by cc on 2017/6/26.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "InvestmentProjectViewController.h"
#import "InvestmentItemTableViewCell.h"
#import "InverstInfoViewController.h"
#import "InvestmentModel.h"
#import "TBRefresh.h"

@interface InvestmentProjectViewController ()
@property(retain,atomic) UITableView *tblInvestments;
@property(retain,atomic) NSArray *datasource;
@end

@implementation InvestmentProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomerTitle: @"投资项目"];
    [self addTableView];
    __weak InvestmentProjectViewController *weakself=self;
    [_tblInvestments addRefreshHeaderWithBlock:^{
        [InvestmentModel loadData:^(NSArray *data)  {
            [weakself.tblInvestments.header endHeadRefresh];
            weakself.datasource = data;
            [weakself.tblInvestments reloadData];
        }];
        
    }];
    
    [_tblInvestments.header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) addTableView{
    self.tblInvestments = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH-64-44) style:UITableViewStylePlain];
    [self.tblInvestments registerClass:[InvestmentItemTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tblInvestments.rowHeight = 222;
    self.tblInvestments.dataSource = self;
    self.tblInvestments.delegate = self;
    self.tblInvestments.backgroundColor = [UIColor clearColor];
    self.tblInvestments.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tblInvestments];
}

#pragma mark - UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InvestmentItemTableViewCell *cell = (InvestmentItemTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[InvestmentItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    InvestmentModel *model = _datasource[indexPath.row];
    cell.model = model;
    
    return cell;
}

#pragma mark - UITableViewDelegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    InvestmentModel * model= _datasource[indexPath.row];
    UIViewController *infoViewController = [[InverstInfoViewController alloc] initWithModel:model];
    [self.navigationController pushViewController:infoViewController animated:YES];

}
@end
