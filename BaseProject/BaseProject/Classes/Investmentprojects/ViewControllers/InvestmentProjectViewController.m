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

@interface InvestmentProjectViewController ()
@property(retain,atomic) UITableView *tblInvestments;
@property(retain,atomic) NSArray *datasource;
@end

@implementation InvestmentProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomerTitle: @"投资项目"];
    [self addTableView];
    _datasource = [InvestmentModel loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) addTableView{
    
    CGFloat offset = self.navigationController.navigationBar.frame.size.height + 20;
    self.tblInvestments = [[UITableView alloc] initWithFrame:CGRectMake(0, offset, self.view.bounds.size.width, self.view.bounds.size.height - offset) style:UITableViewStylePlain];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *infoViewController = [[InverstInfoViewController alloc] init];
    [self.navigationController pushViewController:infoViewController animated:YES];

}
@end
