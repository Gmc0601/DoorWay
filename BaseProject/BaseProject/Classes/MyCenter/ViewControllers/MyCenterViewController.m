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
#import "AllReleaseProjectController.h"
#import "LimitAmoutController.h"
#import "securityVC.h"
#import "fundsVC.h"

@interface MyCenterViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MyCenterViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self lastCenterHome];
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
    
}


-(void)lastCenterHome{
    
    self.view.backgroundColor = UIColorFromHex(0xf6f6f6);
    
    self.imageArray=@[@"icon_aqzx",@"icon_zjgl",@"icon_wdhzbzed",@"icon_zqbzzed",@"icon_jltl",@"icon_hzbd",@"icon_fqxm",@"icon_yqm",@"icon_kfzx"];
    
    self.setBaseArray=@[@"安全中心",@"资金管理",@"我的互助保障金额",@"社区保障总额度",@"交流讨论",@"互助报单",@"发起项目",@"我的邀请码",@"客服咨询"];
    
    [self lastIMagetable];
}


/*
 *初始化
 */

-(void)lastIMagetable{
        self.setIMagetable=[[UITableView alloc]initWithFrame:CGRectMake(0,-40,kScreenW,kScreenH) style:UITableViewStyleGrouped];
        self.setIMagetable.showsVerticalScrollIndicator=NO;
        self.setIMagetable.separatorInset=UIEdgeInsetsMake(0,0,0,0);
        self.setIMagetable.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
        self.setIMagetable.delegate=self;
        self.setIMagetable.dataSource=self;
        [self.view addSubview:self.setIMagetable];
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
    
    UIImageView *loginIMage=[[UIImageView alloc]init];
    if ([ConfigModel getBoolObjectforKey:IsLogin]){
         loginIMage.userInteractionEnabled=YES;
        loginIMage.image=[UIImage imageNamed:@"默认头像"];
        loginIMage.contentMode=UIViewContentModeCenter;
    }else{
        loginIMage.image=[UIImage imageNamed:@"btn_dl"];
        loginIMage.userInteractionEnabled=YES;
    }
     [setView addSubview:loginIMage];
    [loginIMage mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(80*SCALE);
        make.centerX.mas_equalTo(setView.mas_centerX);
        make.width.mas_equalTo(loginIMage.mas_width);
        make.height.mas_equalTo(loginIMage.mas_height);
    }];
    
    if ([ConfigModel getBoolObjectforKey:IsLogin]){
        
        UITapGestureRecognizer *loginUser=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loginBuser:)];
        loginUser.numberOfTapsRequired = 1; // 单击
        [loginIMage addGestureRecognizer:loginUser];
    }else{
        UITapGestureRecognizer *loginBtn=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loginButton:)];
        loginBtn.numberOfTapsRequired = 1; // 单击
        [loginIMage addGestureRecognizer:loginBtn];
    }
    UILabel  *lastName=[[UILabel alloc]init];
    lastName.backgroundColor=[UIColor clearColor];
    NSString *name=[ConfigModel userName];
    if ([ConfigModel getBoolObjectforKey:IsLogin]) {
         lastName.text=[NSString stringWithFormat:@"用户昵称: %@",name];
    }else{
        lastName.text=[NSString stringWithFormat:@"用户昵称: %@",@"游客"];
    }
    lastName.textColor=[UIColor blackColor];
    lastName.font=HelveticaNeueFont(16*SCALE);
    [setView addSubview:lastName];
    [lastName mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(loginIMage.mas_bottom).offset(10*SCALE);
        make.centerX.mas_equalTo(setView.mas_centerX);
        make.width.mas_equalTo(loginIMage.mas_width);
        make.height.mas_equalTo(loginIMage.mas_height);
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
-(void)loginButton:(UIButton*)sender{
    
    LoginViewController *login=[[LoginViewController alloc]init];
    login.loginType=Login_Present;
//    [self.navigationController pushViewController:login animated:YES];
     [self presentViewController:login animated:YES completion:nil];
    
}

-(void)loginBuser:(UIButton*)sender{
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
            
            securityVC *security = [[securityVC alloc]init];
           [self.navigationController pushViewController:security animated:YES];

        }else if (indexPath.row==1){
            
            fundsVC *funds = [[fundsVC alloc]init];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:funds];
            [self.navigationController presentViewController:nav animated:YES completion:^{
                
            }];

        }else if (indexPath.row==2){
            LimitAmoutController *limit=[[LimitAmoutController alloc]init];
            [self.navigationController pushViewController:limit animated:YES];
        }
        
    }else if (indexPath.section==1){
        if (indexPath.row==0) {
            
        }else if (indexPath.row==1){
            DeclarationViewController *declaration=[[DeclarationViewController alloc]init];
            [self.navigationController pushViewController:declaration animated:YES];
        }else if (indexPath.row==2){
            AllReleaseProjectController *release=[[AllReleaseProjectController alloc]init];
            [self.navigationController pushViewController:release animated:YES];
        }else if (indexPath.row==3){
            InvitationViewController *Invitation=[[InvitationViewController alloc]init];
            [self.navigationController pushViewController:Invitation animated:YES];
        }else if (indexPath.row==4){
            
        }
    }
}






@end
