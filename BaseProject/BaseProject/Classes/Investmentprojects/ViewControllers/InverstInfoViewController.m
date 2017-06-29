//
//  InverstInfoViewController.m
//  BaseProject
//
//  Created by LeoGeng on 29/06/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "InverstInfoViewController.h"
#import "InvestmentInfoView.h"

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
