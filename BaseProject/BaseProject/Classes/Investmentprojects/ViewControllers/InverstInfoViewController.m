//
//  InverstInfoViewController.m
//  BaseProject
//
//  Created by LeoGeng on 29/06/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "InverstInfoViewController.h"
#import "LoginViewController.h"

@interface InverstInfoViewController ()
@property(retain,atomic) InvestmentModel *model;
@end

@implementation InverstInfoViewController

- (instancetype)initWithModel:(InvestmentModel *) model
{
    self = [super init];
    if (self) {
        _model = model;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
    titleLabel.text = @"项目详情";
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = titleLabel;
    
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_fh_b"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickNewsBackBtn)];

    InvestmentInfoView *infoView = [[InvestmentInfoView alloc] initWithFrame:self.view.bounds withModel:_model];
    infoView.delegate = self;
    self.view = infoView;
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bar_bg"] forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleDefault animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) gotoLoginViewController{
    LoginViewController *loginVC = [[LoginViewController alloc ] init];
    [self.navigationController presentViewController:loginVC animated:YES completion:nil];
}

- (void)clickNewsBackBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
