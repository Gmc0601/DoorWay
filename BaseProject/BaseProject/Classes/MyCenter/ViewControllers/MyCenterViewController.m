//
//  MyCenterViewController.m
//  BaseProject
//
//  Created by cc on 2017/6/26.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "Masonry.h"
#import "PublicClass.h"
#import "setIMagecell.h"
#import "MyCenterViewController.h"
#import "InvitationViewController.h"
#import "UserinforViewController.h"
#import "DeclarationViewController.h"
#import "LoginViewController.h"


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
    
    self.imageArray=@[@"icon_aqzx",@"icon_zjgl",@"icon_wdhzbzed",@"icon_zqbzzed",@"icon_jltl",@"icon_hzbd",@"icon_fqxm",@"icon_yqm",@"icon_kfzx"];
    
    self.setBaseArray=@[@"安全中心",@"资金管理",@"我的互助保障金额",@"社区保障总额度",@"交流讨论",@"互助报单",@"发起项目",@"我的邀请码",@"客服咨询"];
    
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
    return 48*SCALE;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 198*SCALE;
    }else if (section==1){
        return 0.01;
    }
    return YES;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *setView=[[UIView alloc]init];
    setView.backgroundColor=UIColorFromHex(0x4169E1);
    
    UIButton *consultationBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [consultationBtn setImage:[UIImage imageNamed:@"btn_xx"] forState:UIControlStateNormal];
    [consultationBtn addTarget:self action:@selector(consultation:) forControlEvents:UIControlEventTouchUpInside];
    [setView addSubview:consultationBtn];
    [consultationBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(50*SCALE);
        make.right.mas_equalTo(-16*SCALE);
        make.width.mas_equalTo(36/2);
        make.height.mas_equalTo(35/2);
    }];
    
    UIButton *loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setImage:[UIImage imageNamed:@"btn_dl"] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [setView addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(100*SCALE);
        make.centerX.mas_equalTo(setView.mas_centerX);
        make.width.mas_equalTo(206/2);
        make.height.mas_equalTo(65/2);
    }];
    
    return setView;
}



/*
 *咨询方法
 */
-(void)consultation:(UIButton*)sender{
    
}

/*
 *登录方法
 */
-(void)login:(UIButton*)sender{
    
//    LoginViewController *login=[[LoginViewController alloc]init];
//    [self.navigationController pushViewController:login animated:YES];
    
    
    UserinforViewController *userInfo=[[UserinforViewController alloc]init];
     [self.navigationController pushViewController:userInfo animated:YES];
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
    static NSString *identifier = @"setIMagecell";
    setIMagecell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[setIMagecell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor=[UIColor whiteColor];
        
        if (indexPath.section==0) {
            cell.setIMage.image=[UIImage imageNamed:self.imageArray[indexPath.row]];
            cell.setIMageLable.text=self.setBaseArray[indexPath.row];
        }else if (indexPath.section==1){
            cell.setIMage.image=[UIImage imageNamed:self.imageArray[indexPath.row+4]];
            cell.setIMageLable.text=self.setBaseArray[indexPath.row+4];
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
         
        }
        
    }else if (indexPath.section==1){
        if (indexPath.row==0) {
            
        }else if (indexPath.row==1){
            DeclarationViewController *declaration=[[DeclarationViewController alloc]init];
            [self.navigationController pushViewController:declaration animated:YES];
        }else if (indexPath.row==2){
            
        }else if (indexPath.row==3){
            InvitationViewController *Invitation=[[InvitationViewController alloc]init];
            [self.navigationController pushViewController:Invitation animated:YES];
        }else if (indexPath.row==4){
            
        }
    }
}






@end
