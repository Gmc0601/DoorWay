//
//  InverstInfoViewController.m
//  BaseProject
//
//  Created by LeoGeng on 29/06/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "InverstInfoViewController.h"

@interface InverstInfoViewController ()

@end

@implementation InverstInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    InvestmentInfoView *infoView = [[InvestmentInfoView alloc] initWithFrame:self.view.bounds];
    self.view = infoView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
