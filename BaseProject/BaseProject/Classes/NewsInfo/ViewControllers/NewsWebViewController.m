//
//  NewsWebViewController.m
//  BaseProject
//
//  Created by JeroMac on 2017/6/28.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "NewsWebViewController.h"
#import "LoginViewController.h"
@interface NewsWebViewController ()<UIWebViewDelegate,UIScrollViewDelegate>

{
    UIWebView *NewsWebView;
    NSString *urlStr;
    NSString *readStr;
    UIButton *PraiseBtn;
    
    UILabel *titleLabelD;
    UILabel *timeLabelD;
    UILabel *readCountLabel;
    
    
    UIView *separView1;
    UIView *separView2;
    UILabel *labelRa;
}

//@property(nonatomic, strong)UILabel *titleLabel;

@end

@implementation NewsWebViewController
//     [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_phb"] forBarMetrics:UIBarMetricsDefault];bar_bg


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
  
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_fh_b"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickNewsBackBtn)];
    // Do any additional setup after loading the view.
    
    

    NewsWebView = [[UIWebView alloc] init];
    NewsWebView.scalesPageToFit = YES;
    NewsWebView.frame = CGRectMake(16, 0, self.view.bounds.size.width-32, self.view.bounds.size.height);
    NewsWebView.backgroundColor = [UIColor whiteColor];
    NewsWebView.delegate = self;
    NewsWebView.scrollView.delegate = self;
    for (UIView *subView in [NewsWebView subviews])
    {
        if ([subView isKindOfClass:[UIScrollView class]])
        {
            // 不显示竖直的滚动条
            [(UIScrollView *)subView setShowsVerticalScrollIndicator:NO];
        }
    }
    NewsWebView.scrollView.contentInset = UIEdgeInsetsMake(130, 0, 130, 0);
    NewsWebView.scrollView.contentOffset= CGPointMake(0, -260);
    
   
    
//    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
//    NSMutableURLRequest *requeset = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:3.0];
    
    [self.view addSubview:NewsWebView];
//    [NewsWebView loadRequest:requeset];
     [self creatUI];
    [self getUrlWebDetail];

}


- (void)getUrlViewWebDetail{
    NSMutableDictionary *newsIdMudic = [NSMutableDictionary new];
    [newsIdMudic setObject:self.newsId forKey:@"id"];
    NSString *userTokenStr = [ConfigModel getStringforKey:UserToken];
    [newsIdMudic setObject:userTokenStr forKey:@"userToken"];
    [HttpRequest postPath:@"_newsdetails_001" params:newsIdMudic resultBlock:^(id responseObject, NSError *error) {
        
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        
        NSLog(@"%@_newsdetails_001>>>>>>%@",responseObject[@"info"][@"userhint"], responseObject);
        NSDictionary *datadic = responseObject;
        if ([datadic[@"error"] intValue] == 0) {
            NSDictionary *infoDic = responseObject[@"info"];
            urlStr = infoDic[@"content"];
            readStr = infoDic[@"userhint"];
            if ([readStr isEqualToString:@"1"]) {
                [PraiseBtn setImage:[UIImage imageNamed:@"btn_zxxq_yz"] forState:UIControlStateNormal];
            }else{
                [PraiseBtn setImage:[UIImage imageNamed:@"btn_zxxq_wz"] forState:UIControlStateNormal];
            }

            
        }else {
            NSString *info = datadic[@"info"];
            [ConfigModel mbProgressHUD:info andView:nil];
        }
        NSLog(@"error>>>>%@", error);
    }];
    

    
    
}



- (void)getUrlWebDetail{
    NSMutableDictionary *newsIdMudic = [NSMutableDictionary new];
    [newsIdMudic setObject:self.newsId forKey:@"id"];
    NSString *userTokenStr = [ConfigModel getStringforKey:UserToken];
    [newsIdMudic setObject:userTokenStr forKey:@"userToken"];
    [HttpRequest postPath:@"_newsdetails_001" params:newsIdMudic resultBlock:^(id responseObject, NSError *error) {
        
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        
        NSLog(@"%@_newsdetails_001>>>>>>%@",responseObject[@"info"][@"userhint"], responseObject);
        NSDictionary *datadic = responseObject;
        if ([datadic[@"error"] intValue] == 0) {
            NSDictionary *infoDic = responseObject[@"info"];
            urlStr = infoDic[@"content"];
            readStr = infoDic[@"userhint"];
            if ([readStr isEqualToString:@"1"]) {
                  [PraiseBtn setImage:[UIImage imageNamed:@"btn_zxxq_yz"] forState:UIControlStateNormal];
            }else{
                  [PraiseBtn setImage:[UIImage imageNamed:@"btn_zxxq_wz"] forState:UIControlStateNormal];
            }
            titleLabelD.text =infoDic[@"title"];
            timeLabelD.text =infoDic[@"create_time"];
            readCountLabel.text = [NSString stringWithFormat:@"阅读 %@   赞 %@",infoDic[@"read_num"],infoDic[@"praise_num"]];
            
            NSString *wideStr = [NSString stringWithFormat:@" <head><style>img{width:%fpx !important;}</style></head>", (kScreenW+100)*2];

            
//             UIFont *font = [UIFont systemFontOfSize:23];
//            NSString* fontStr = [NSString stringWithFormat:@"<span style=\"font-family: %@!important; font-size: %i\">%@</span>",
//                                    font.fontName,
//                                    (int) font.pointSize,
//                                    infoDic[@"content"]];
            
            
            urlStr = [wideStr stringByAppendingString:urlStr];
//            NSLog(@"error>>>>%@", urlStr);
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
    
    separView1 = [[UIView alloc] init];
    separView1.frame = CGRectMake(0, 0, 0, 0);
    separView1.backgroundColor = RGBColor(224, 224, 224);
    [NewsWebView.scrollView addSubview:separView1];

    
    separView2 = [[UIView alloc] init];
    separView2.frame = CGRectMake(0, 0, 0, 0);
    separView2.backgroundColor = RGBColor(224, 224, 224);
    [NewsWebView.scrollView addSubview:separView2];

    
    labelRa = [[UILabel alloc] init];
    labelRa.font = [UIFont systemFontOfSize:11];
    labelRa.textAlignment = NSTextAlignmentCenter;
    labelRa.frame = CGRectMake(0, 0, 0, 0);
    labelRa.text = @"感觉文章不错，点个赞吧";
    labelRa.textColor = RGBColor(153, 153, 153);
    [NewsWebView.scrollView addSubview:labelRa];

    
    PraiseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    PraiseBtn.frame = CGRectMake(0, 0, 0, 0);
    [PraiseBtn setImage:[UIImage imageNamed:@"btn_zxxq_wz"] forState:UIControlStateNormal];
    [PraiseBtn addTarget:self action:@selector(PraiseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
     [NewsWebView.scrollView addSubview:PraiseBtn];
    

    titleLabelD = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabelD.numberOfLines = 0;
    titleLabelD.font = [UIFont systemFontOfSize:25];
    titleLabelD.textColor = RGB(59, 59, 59);
    [NewsWebView.scrollView addSubview:titleLabelD];
    
    timeLabelD = [[UILabel alloc] initWithFrame:CGRectZero];
    timeLabelD.font = [UIFont systemFontOfSize:10];
    timeLabelD.textColor = RGB(153, 153, 153);
    [NewsWebView.scrollView addSubview:timeLabelD];
    
    readCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    readCountLabel.font = [UIFont systemFontOfSize:10];
    readCountLabel.textAlignment = NSTextAlignmentRight;
    readCountLabel.textColor = RGB(153, 153, 153);
    [NewsWebView.scrollView addSubview:readCountLabel];
    
    
}


- (void)PraiseBtnClick:(UIButton *)sender{
//    [ConfigModel saveBoolObject:NO forKey:IsLogin];
    NSLog(@"%@888", IsLogin);
    if ([ConfigModel getBoolObjectforKey:IsLogin] ) {
        if ([readStr isEqualToString:@"1"]) {
            NSMutableDictionary *UNPraiseMudic = [NSMutableDictionary new];
            [UNPraiseMudic setObject:self.newsId forKey:@"id"];
            NSString *userTokenStr = [ConfigModel getStringforKey:UserToken];
            [UNPraiseMudic setObject:userTokenStr forKey:@"userToken"];
            [HttpRequest postPath:@"_offgoodnews_001" params:UNPraiseMudic resultBlock:^(id responseObject, NSError *error) {
                
                if([error isEqual:[NSNull null]] || error == nil){
                    NSLog(@"success");
                }
                
                NSLog(@"%@----%@_newsdetails_001>>>>>>%@",self.newsId, userTokenStr, responseObject);
                NSDictionary *datadic = responseObject;
                if ([datadic[@"error"] intValue] == 0) {
                    NSDictionary *infoDic = responseObject[@"info"];
                    [ConfigModel mbProgressHUD:@"取消点赞成功" andView:self.view];
                    readStr=@"2";
                    [sender setImage:[UIImage imageNamed:@"btn_zxxq_wz"] forState:UIControlStateNormal];
                    
                }else {
                    NSString *info = datadic[@"info"];
                    [ConfigModel mbProgressHUD:info andView:nil];
                }
                NSLog(@"error>>>>%@", error);
            }];
            
        }else{
            NSMutableDictionary *PraiseMudic = [NSMutableDictionary new];
            [PraiseMudic setObject:self.newsId forKey:@"id"];
            NSString *userTokenStr = [ConfigModel getStringforKey:UserToken];
            [PraiseMudic setObject:userTokenStr forKey:@"userToken"];
            [HttpRequest postPath:@"_goodnews_001" params:PraiseMudic resultBlock:^(id responseObject, NSError *error) {
                
                if([error isEqual:[NSNull null]] || error == nil){
                    NSLog(@"success");
                }
                
                NSLog(@"%@----%@_newsdetails_001>>>>>>%@",self.newsId, userTokenStr, responseObject);
                NSDictionary *datadic = responseObject;
                if ([datadic[@"error"] intValue] == 0) {
                    NSDictionary *infoDic = responseObject[@"info"];
                    readStr = @"1";
                    [ConfigModel mbProgressHUD:@"点赞成功" andView:self.view];
                    [sender setImage:[UIImage imageNamed:@"btn_zxxq_yz"] forState:UIControlStateNormal];
                    
                }else {
                    NSString *info = datadic[@"info"];
                    [ConfigModel mbProgressHUD:info andView:nil];
                }
                NSLog(@"error>>>>%@", error);
            }];
            
        }
 
        return;
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc ] init];
//        self.loginViewC = loginVC;
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:navi animated:YES completion:nil];
//        [self presentViewController:loginVC animated:YES completion:nil];

        
    }
 
    
   
}




- (void)viewWillAppear:(BOOL)animated{
    [self getUrlViewWebDetail];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bar_bg"] forBarMetrics:UIBarMetricsDefault];
     [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleDefault animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
//   [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_phb"] forBarMetrics:UIBarMetricsDefault];
    [self getUrlViewWebDetail];
    [UIApplication sharedApplication].statusBarStyle =UIStatusBarStyleLightContent;
   
}
- (void)clickNewsBackBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
     timeLabelD.frame = CGRectMake(1, -18-30, 150, 10);
     titleLabelD.frame = CGRectMake(-3, -120, kScreenW-40, 60);
     readCountLabel.frame = CGRectMake(kScreenW-18-150-16, -18-30, 150, 10);
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '340%'"];
    
     NSLog(@"%f------", webView.scrollView.contentSize.height);
//    NSString *js=@"var script = document.createElement('script');"
//    "script.type = 'text/javascript';"
//    "script.text = \"function ResizeImages() { "
//    "var myimg,oldwidth;"
//    "var maxwidth = %f;"
//    "for(i=0;i <document.images.length;i++){"
//    "myimg = document.images[i];"
//    "if(myimg.width > maxwidth){"
//    "oldwidth = myimg.width;"
//    "myimg.width = %f;"
//    "}"
//    "}"
//    "}\";"
//    "document.getElementsByTagName('head')[0].appendChild(script);";
//    js=[NSString stringWithFormat:js,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.width-15];
//    [webView stringByEvaluatingJavaScriptFromString:js];
//    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%f------%f-----%f", scrollView.contentSize.height - scrollView.contentOffset.y+130,scrollView.contentOffset.y,scrollView.frame.size.height);
//    667.000000-------260.000000-----667.000000
//    1776.000000------1239.000000-----667.000000   537
    
//    568.000000-------194.000000-----568.000000
//    1491.000000------1053.000000-----568.000000   438
    if ((scrollView.contentSize.height - scrollView.contentOffset.y +130) <= scrollView.frame.size.height+50) {
    
        NSLog(@"到底了。。。。");
        
//        PraiseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        PraiseBtn.hidden = NO;
        PraiseBtn.frame = CGRectMake((kScreenW-32-60)/2, scrollView.contentSize.height+50, 60, 60);
//        [PraiseBtn setImage:[UIImage imageNamed:@"btn_zxxq_wz"] forState:UIControlStateNormal];
//        [PraiseBtn addTarget:self action:@selector(PraiseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [NewsWebView.scrollView addSubview:PraiseBtn];
        
//        if ([readStr isEqualToString:@"1"]) {
//            [PraiseBtn setImage:[UIImage imageNamed:@"btn_zxxq_yz"] forState:UIControlStateNormal];
//        }else{
//            [PraiseBtn setImage:[UIImage imageNamed:@"btn_zxxq_wz"] forState:UIControlStateNormal];
//        }
        
        
        
//        separView1 = [[UIView alloc] init];
        separView1.frame = CGRectMake(0, scrollView.contentSize.height+25, (kScreenW-130-40)/2-16, 1);
//        separView1.backgroundColor = RGBColor(224, 224, 224);
//        [NewsWebView.scrollView addSubview:separView1];
//       
//        
//        
//        separView2 = [[UIView alloc] init];
        separView2.frame = CGRectMake(kScreenW-32-((kScreenW-130-40)/2-16), scrollView.contentSize.height+25, (kScreenW-130-40)/2-16, 1);
//        separView2.backgroundColor = RGBColor(224, 224, 224);
//        [NewsWebView.scrollView addSubview:separView2];
//      
//        
//        labelRa = [[UILabel alloc] init];
//        labelRa.font = [UIFont systemFontOfSize:11];
//        labelRa.textAlignment = NSTextAlignmentCenter;
        labelRa.frame = CGRectMake((kScreenW-130-40)/2-16+20, scrollView.contentSize.height+20, 130, 11);
//        labelRa.text = @"感觉文章不错，点个赞吧";
//        labelRa.textColor = RGBColor(153, 153, 153);
//        [NewsWebView.scrollView addSubview:labelRa];
//
        
        
        
//        PraiseBtn.hidden = NO;
//        separView1.hidden = NO;
//        separView2.hidden = NO;
//        labelRa.hidden = NO;
//    }else{
//        PraiseBtn.hidden = YES;
//        separView1.hidden = YES;
//        separView2.hidden = YES;
//        labelRa.hidden = YES;
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
