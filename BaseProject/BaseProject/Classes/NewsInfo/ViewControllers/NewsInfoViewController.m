//
//  NewsInfoViewController.m
//  BaseProject
//
//  Created by cc on 2017/6/26.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "NewsInfoViewController.h"


#import "NewsTableViewCell.h"
@interface NewsInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myMTableView;
    
}
@end

@implementation NewsInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomerTitle: @"新闻资讯"];
    
#if UserToeknAndLogin
    [ConfigModel saveBoolObject:YES forKey:IsLogin];
    [ConfigModel saveString:@"31604b552d2a64de9d4b36af26e61634" forKey:UserToken];
#else
#endif
    
    
    
    [self getTableViewDate];
    
    
    self.navigationItem.rightBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_xx"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickNewsBtn)];
    // Do any additional setup after loading the view.
    
    
    myMTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH-64-44)];
    myMTableView.dataSource = self;
    myMTableView.delegate = self;
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:myMTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getTableViewDate{
    
    [HttpRequest postPath:@"_homenews_001" params:nil resultBlock:^(id responseObject, NSError *error) {
        
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        
        NSLog(@"login>>>>>>%@", responseObject);
        NSDictionary *datadic = responseObject;
        if ([datadic[@"error"] intValue] == 0) {
            
        }else {
            NSString *info = datadic[@"info"];
            [ConfigModel mbProgressHUD:info andView:nil];
        }
        NSLog(@"error>>>>%@", error);
    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 16;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *MessageCell = @"cell1";
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MessageCell];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NewsTableViewCell" owner:self options:nil] lastObject];
    }
    
    //             cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //       [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (void)clickNewsBtn{
//    LoginViewController *loginVC = [[LoginViewController alloc] init];
//    
//    [self.navigationController pushViewController:loginVC animated:YES];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
