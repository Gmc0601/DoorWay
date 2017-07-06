//
//  NewsWebViewController.m
//  BaseProject
//
//  Created by JeroMac on 2017/6/28.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "NewsWebViewController.h"
#import "LoginViewController.h"
@interface NewsWebViewController ()<UIWebViewDelegate>

{
    UIWebView *NewsWebView;
    NSString *urlStr;
}

@end

@implementation NewsWebViewController
//     [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_phb"] forBarMetrics:UIBarMetricsDefault];bar_bg


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
  
    [self creatUI];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_fh_b"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickNewsBackBtn)];
    // Do any additional setup after loading the view.
    
    
    [self getUrlWebDetail];
    NewsWebView = [[UIWebView alloc] init];
    NewsWebView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64-130);
    NewsWebView.delegate = self;
    NewsWebView.scalesPageToFit = YES;
    
//    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
//    NSMutableURLRequest *requeset = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:3.0];
    
    [self.view addSubview:NewsWebView];
//    [NewsWebView loadRequest:requeset];
}


- (void)getUrlWebDetail{
    NSMutableDictionary *newsIdMudic = [NSMutableDictionary new];
    [newsIdMudic setObject:self.newsId forKey:@"id"];
    [HttpRequest postPath:@"_newsdetails_001" params:newsIdMudic resultBlock:^(id responseObject, NSError *error) {
        
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        
        NSLog(@"_newsdetails_001>>>>>>%@", responseObject);
        NSDictionary *datadic = responseObject;
        if ([datadic[@"error"] intValue] == 0) {
            NSDictionary *infoDic = responseObject[@"info"];
            urlStr = infoDic[@"content"];
            [NewsWebView loadHTMLString:urlStr baseURL:nil];
            
        }else {
            NSString *info = datadic[@"info"];
            [ConfigModel mbProgressHUD:info andView:nil];
        }
        NSLog(@"error>>>>%@", error);
    }];

    
}
- (void)creatUI{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
    titleLabel.text = @"咨询详情";
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = titleLabel;
    
    UIView *separView1 = [[UIView alloc] init];
    separView1.frame = CGRectMake(10, kScreenH-105, (kScreenW-130-40)/2+10, 1);
    separView1.backgroundColor = RGBColor(224, 224, 224);
    [self.view addSubview:separView1];
    
    UIView *separView2 = [[UIView alloc] init];
    separView2.frame = CGRectMake(kScreenW-110, kScreenH-105, (kScreenW-130-40)/2+10, 1);
    separView2.backgroundColor = RGBColor(224, 224, 224);
    [self.view addSubview:separView2];
    
    UILabel *labelRa = [[UILabel alloc] init];
    labelRa.font = [UIFont systemFontOfSize:11];
    labelRa.textAlignment = NSTextAlignmentCenter;
    labelRa.frame = CGRectMake((kScreenW-130)/2, kScreenH-111, 130, 11);
    labelRa.text = @"感觉文章不错，点个赞吧";
    labelRa.textColor = RGBColor(153, 153, 153);
    [self.view addSubview:labelRa];
    
    UIButton *PraiseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    PraiseBtn.frame = CGRectMake((kScreenW-60)/2, kScreenH-80, 60, 60);
    [PraiseBtn setImage:[UIImage imageNamed:@"btn_zxxq_wz"] forState:UIControlStateNormal];
    [PraiseBtn addTarget:self action:@selector(PraiseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:PraiseBtn];
}


- (void)PraiseBtnClick:(UIButton *)sender{
//    [ConfigModel saveBoolObject:NO forKey:IsLogin];
    if ([ConfigModel getBoolObjectforKey:IsLogin] ) {
        NSMutableDictionary *PraiseMudic = [NSMutableDictionary new];
        [PraiseMudic setObject:self.newsId forKey:@"id"];
        [PraiseMudic setObject:UserToken forKey:@"userToken"];
        [HttpRequest postPath:@"_goodnews_001" params:PraiseMudic resultBlock:^(id responseObject, NSError *error) {
            
            if([error isEqual:[NSNull null]] || error == nil){
                NSLog(@"success");
            }
            
            NSLog(@"_newsdetails_001>>>>>>%@", responseObject);
            NSDictionary *datadic = responseObject;
            if ([datadic[@"error"] intValue] == 0) {
                NSDictionary *infoDic = responseObject[@"info"];
          [sender setImage:[UIImage imageNamed:@"btn_zxxq_yz"] forState:UIControlStateNormal];
                
            }else {
                NSString *info = datadic[@"info"];
                [ConfigModel mbProgressHUD:info andView:nil];
            }
            NSLog(@"error>>>>%@", error);
        }];

        
       
        return;
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc ] init];
//        self.loginViewC = loginVC;
//        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:loginVC];
//        [self presentViewController:navi animated:YES completion:nil];
        [self presentViewController:loginVC animated:YES completion:nil];

        
    }
 
    
   
}




- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bar_bg"] forBarMetrics:UIBarMetricsDefault];
     [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleDefault animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
//   [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_phb"] forBarMetrics:UIBarMetricsDefault];
    [UIApplication sharedApplication].statusBarStyle =UIStatusBarStyleLightContent;
   
}
- (void)clickNewsBackBtn{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
