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

#import "UIImageView+WebCache.h"
@interface NewsInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myMTableView;
    BOOL isload;
}

@property (nonatomic, strong)NSArray *NewSArr;


@property (nonatomic, assign)int  refreshCount;
@property (nonatomic, strong)NSMutableArray *NewSArrCount;
@property (nonatomic, strong)NSMutableArray *NewSArrID;

@end

@implementation NewsInfoViewController

- (void)viewWillAppear:(BOOL)animated{
    [self getTableViewDate];
     [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_phb"] forBarMetrics:UIBarMetricsDefault];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _NewSArr = [NSArray array];
    _NewSArrCount = [[NSMutableArray alloc] init];
    _NewSArrID = [[NSMutableArray alloc] init];
    _refreshCount = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setCustomerTitle: @"新闻资讯"];
    
    self.navigationItem.rightBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_xx"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(LoadDatas)];
    // Do any additional setup after loading the view.
    
    myMTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH-64-44) style:UITableViewStylePlain];
    myMTableView.dataSource = self;
    myMTableView.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:myMTableView];
    

     [self getTableViewDate];
    
    
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
    isload = YES;
     [self getTableViewDate];
//    [myMTableView.footer ResetNomoreData];
    
//    // 模拟延时设置
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
        [myMTableView.header endHeadRefresh];

    });
}

-(void)LoadMoreDatas
{
    isload = NO;
    _refreshCount++;
    [self getTableViewDate];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

       [myMTableView.footer endFooterRefreshing];

    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getTableViewDate{
    if (isload) {
        _refreshCount =1;
        [_NewSArrCount removeAllObjects];
        [_NewSArrID removeAllObjects];
    }
    NSMutableDictionary *homeMudic = [NSMutableDictionary new];
    NSString *countStr = [NSString stringWithFormat:@"%d", _refreshCount];
    [homeMudic setObject:countStr forKey:@"page"];
    [homeMudic setObject:@"10" forKey:@"size"];
    [HttpRequest postPath:@"_homenews_001" params:homeMudic resultBlock:^(id responseObject, NSError *error) {
        
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        
//        NSLog(@"login>>>>>>%d", _refreshCount);
        NSDictionary *datadic = responseObject;
        if ([datadic[@"error"] intValue] == 0) {

             _NewSArr = datadic[@"info"];
            if (_NewSArr.count == 0) {
                 [myMTableView.footer NoMoreData];
                 [myMTableView.footer endFooterRefreshing];
             
                return ;

            }
//            if (isload) {
//                [_NewSArrCount removeAllObjects];
//                [_NewSArrCount addObjectsFromArray:_NewSArr];
//            }else{
//                 [_NewSArrCount addObjectsFromArray:_NewSArr];
//            }
            
            for (NSDictionary *dic in _NewSArr) {
                if ([_NewSArrID containsObject:dic[@"id"]]) {
                    return ;
                }else{
                    [_NewSArrCount addObject:dic];
                    [_NewSArrID addObject:dic[@"id"]];
                }
            }
            
             [myMTableView.footer endFooterRefreshing];
               NSLog(@"444%lu", (unsigned long)_NewSArrCount.count);
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
    
//    NSLog(@"444%lu", (unsigned long)_NewSArrCount.count);
    return _NewSArrCount.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *MessageCell = @"cell1";
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MessageCell];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NewsTableViewCell" owner:self options:nil] lastObject];
    }
    
     NSDictionary *cellDic = nil;
    if (indexPath.row < _NewSArrCount.count) {
         cellDic = [_NewSArrCount objectAtIndex:indexPath.row];
    }
    
    
//    NSDictionary *cellDic = _NewSArrCount[indexPath.row];
    cell.titleLabel.text = cellDic[@"title"];
    
      NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[cellDic[@"content"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
          NSLog(@"5556675%@",cellDic[@"img"]);
    cell.contentLabel.attributedText = attributedString;
    
//    [cell.ImgView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:cellDic[@"img"]]]]];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [cell.ImgView sd_setImageWithURL:[NSURL URLWithString:cellDic[@"img"]] completed:nil];

    });
    cell.readCount.text = [NSString stringWithFormat:@"%@阅读    %@赞", cellDic[@"read_num"],cellDic[@"praise_num"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //             cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsWebViewController *newsWeb = [[NewsWebViewController alloc] init];
    newsWeb.newsId =  _NewSArrCount[indexPath.row][@"id"];
    [self.navigationController pushViewController:newsWeb animated:YES];
          
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
