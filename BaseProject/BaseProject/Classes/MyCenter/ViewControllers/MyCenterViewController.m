//
//  MyCenterViewController.m
//  BaseProject
//
//  Created by cc on 2017/6/26.
//  Copyright © 2017年 cc. All rights reserved.
//
#import "setIMagecell.h"
#import "MyCenterViewController.h"

@interface MyCenterViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MyCenterViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

/*
 - (void)viewWillDisappear:(BOOL)animated
 {
 [super viewWillDisappear:animated];
 self.navigationController.navigationBarHidden=YES;
 }
 */


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromHex(0xf6f6f6);
    
    self.imageArray=@[@"icon_aqzx",@"icon_zjgl",@"icon_hzbd",@"icon_zqbzzed"];
    
    [self setIMagetable];
}

/*
 *初始化
 */
-(UITableView *)setIMagetable{
    if (!_setIMagetable) {
        self.setIMagetable=[[UITableView alloc]initWithFrame:CGRectMake(0,-40,kScreenW,kScreenH) style:UITableViewStyleGrouped];
        self.setIMagetable.showsVerticalScrollIndicator=NO;
        self.setIMagetable.separatorInset=UIEdgeInsetsMake(0,0,0,0);
        self.setIMagetable.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
        self.setIMagetable.delegate=self;
        self.setIMagetable.dataSource=self;
        [self.view addSubview:self.setIMagetable];
    }
    return _setIMagetable;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 198;
    }else if (section==1){
        return 0.01;
    }
    return YES;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *setView=[[UIView alloc]init];
    setView.backgroundColor=UIColorFromHex(0x4169E1);
    return setView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 4;
    }else if (section==1){
        return 5;
    }
    return YES;
}

-(setIMagecell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"UITableViewCell";
    setIMagecell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[setIMagecell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor=[UIColor whiteColor];
        
        if (indexPath.section==0) {
            cell.setIMage.image=[UIImage imageNamed:self.imageArray[indexPath.row]];
        }
        
    }
    return cell;
}






@end
