//
//  SecurityViewController.m
//  BaseProject
//
//  Created by li on 2017/6/29.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "SecurityViewController.h"

@interface SecurityViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    UITableView *IMageSecurity;
    
}

@end

@implementation SecurityViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromHex(0xf0f0f0);
    
    self.navigationController.navigationBar.translucent = NO;
    
    [self setCustomerTitle:@"安全中心"];
    
    [self setIMageSecurity];
}

-(void)setIMageSecurity{
    IMageSecurity=[[UITableView alloc]initWithFrame:CGRectMake(0,-40,kScreenW,kScreenH) style:UITableViewStyleGrouped];
    IMageSecurity.showsVerticalScrollIndicator=NO;
    IMageSecurity.separatorInset=UIEdgeInsetsMake(0,0,0,0);
    IMageSecurity.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    IMageSecurity.delegate=self;
    IMageSecurity.dataSource=self;
    [self.view addSubview:IMageSecurity];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50*SCALE;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"setIMagecell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor=[UIColor whiteColor];
        
    }
    return cell;
}







@end
