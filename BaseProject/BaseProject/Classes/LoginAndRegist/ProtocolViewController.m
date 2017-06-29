//
//  ProtocolViewController.m
//  BaseProject
//
//  Created by JeroMac on 2017/6/27.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "ProtocolViewController.h"
#import "ConfigModel.h"
#import <MBProgressHUD.h>
@interface ProtocolViewController ()<UIWebViewDelegate>

{
    UIWebView *DetailWebView;
}


@end

@implementation ProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户注册协议";
    [self.navigationController.navigationBar setTitleTextAttributes:
     
  @{NSFontAttributeName:[UIFont systemFontOfSize:17],
    
    NSForegroundColorAttributeName:RGBColor(0, 0, 0)}];
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
//    titleLabel.text = @"用户注册协议";
//    titleLabel.textColor = [UIColor whiteColor];
//    titleLabel.font = [UIFont systemFontOfSize:18];
//    self.navigationItem.titleView = titleLabel;
    
    
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_fh_b"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickProtocolBackBtn)];
    // Do any additional setup after loading the view.
    
    DetailWebView = [[UIWebView alloc] init];
    DetailWebView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    DetailWebView.delegate = self;
    DetailWebView.scalesPageToFit = YES;
    //    [DetailWebView loadHTMLString:URLStr baseURL:nil];
    
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSMutableURLRequest *requeset = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:3.0];
    
    [self.view addSubview:DetailWebView];
    [DetailWebView loadRequest:requeset];
}

- (void)clickProtocolBackBtn{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [ConfigModel mbProgressHUD:@"加载失败" andView:self.view];
    [ConfigModel hideHud:self];
//    [MBProgressHUD hideHUDForView:DetailWebView animated:YES];
    
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
