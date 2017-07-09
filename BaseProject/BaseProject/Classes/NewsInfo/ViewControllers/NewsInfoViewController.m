//
//  NewsInfoViewController.m
//  BaseProject
//
//  Created by cc on 2017/6/26.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "NewsInfoViewController.h"
#import "LoginViewController.h"
#import "NewsWebViewController.h"
#import "NewsTableViewCell.h"

#import "TBRefresh.h"
#import "KeychainUUID.h"
@interface NewsInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myMTableView;
    
}

@property (nonatomic, strong)NSArray *NewSArr;

@end

@implementation NewsInfoViewController

- (void)viewWillAppear:(BOOL)animated{
    [self getTableViewDate];
     [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_phb"] forBarMetrics:UIBarMetricsDefault];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setCustomerTitle: @"新闻资讯"];
    
#if UserToeknAndLogin
//    [ConfigModel saveBoolObject:YES forKey:IsLogin];
//    [ConfigModel saveString:@"31604b552d2a64de9d4b36af26e61634" forKey:UserToken];
#else
#endif
    
    
    
    [self getTableViewDate];
    
    
    self.navigationItem.rightBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_xx"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickNewsBtn)];
    // Do any additional setup after loading the view.
    
    myMTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH-64-44)];
    myMTableView.dataSource = self;
    myMTableView.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self.view addSubview:myMTableView];
    

      __weak NewsInfoViewController *weakself=self;
    [myMTableView addRefreshHeaderWithBlock:^{
        
        [weakself LoadDatas];
        
    }];
    
    [myMTableView addRefreshFootWithBlock:^{
        
        [weakself LoadMoreDatas];
    }];

    [myMTableView.header beginRefreshing];
}

-(void)LoadDatas
{
    
    [myMTableView.footer ResetNomoreData];
    
    // 模拟延时设置
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [myMTableView.header endHeadRefresh];
        
    });
    
    
    
}

-(void)LoadMoreDatas
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [myMTableView.footer NoMoreData];
        
    });
    
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
        
//        NSLog(@"login>>>>>>%@", responseObject);
        NSDictionary *datadic = responseObject;
        if ([datadic[@"error"] intValue] == 0) {
            _NewSArr = [NSArray array];
             _NewSArr = datadic[@"info"];
//            NSLog(@"444%lu", (unsigned long)_NewSArr.count);
            [myMTableView reloadData];
            
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
    
//    NSLog(@"444%lu", (unsigned long)_NewSArr.count);
    return _NewSArr.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *MessageCell = @"cell1";
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MessageCell];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NewsTableViewCell" owner:self options:nil] lastObject];
    }
    
    NSDictionary *cellDic = _NewSArr[indexPath.row];
    cell.titleLabel.text = cellDic[@"title"];
    
      NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[cellDic[@"content"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
          NSLog(@"5556675%@",attributedString);
    cell.contentLabel.attributedText = attributedString;
    
    [cell.ImgView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:cellDic[@"img"]]]]];
    cell.readCount.text = [NSString stringWithFormat:@"%@阅读    %@赞", cellDic[@"read_num"],cellDic[@"praise_num"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //             cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsWebViewController *newsWeb = [[NewsWebViewController alloc] init];
    newsWeb.newsId =  _NewSArr[indexPath.row][@"id"];
    [self.navigationController pushViewController:newsWeb animated:YES];
          
}


- (void)clickNewsBtn{
//    LoginViewController *loginVC = [[LoginViewController alloc] init];
//    
//    [self.navigationController pushViewController:loginVC animated:YES];
    
//    [ConfigModel saveBoolObject:NO forKey:IsLogin];
    if ([ConfigModel getBoolObjectforKey:IsLogin] ) {
        NSString *userTokenStr = [ConfigModel getStringforKey:UserToken];
        NSMutableDictionary *mudic = [NSMutableDictionary new];
//        [mudic setObject:userTokenStr forKey:@"userToken"];
        KeychainUUID *keychain = [[KeychainUUID alloc] init];
        id data = [keychain readUDID];
        NSString *udidStr = data;
//        [mudic setObject:udidStr forKey:@"device_number"];
        [HttpRequest postPath:@"_logout_001" params:mudic resultBlock:^(id responseObject, NSError *error) {
            
            if([error isEqual:[NSNull null]] || error == nil){
                NSLog(@"success");
            }
            
            NSLog(@"%@login>>>>>>%@", udidStr,responseObject);

            NSDictionary *datadic = responseObject;
            if ([datadic[@"error"] intValue] == 0) {
              
                NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
                [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
                [ConfigModel mbProgressHUD:@"退出成功" andView:nil];
         
            }else {
                NSString *info = datadic[@"info"];
                [ConfigModel mbProgressHUD:info andView:nil];
            }
            NSLog(@"error>>>>%@", error);
        }];

        return;
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc ] init];
        [self.navigationController presentViewController:loginVC animated:YES completion:nil];
        
    }
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
