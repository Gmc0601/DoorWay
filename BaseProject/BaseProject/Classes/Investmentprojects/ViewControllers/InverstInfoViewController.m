//
//  InverstInfoViewController.m
//  BaseProject
//
//  Created by LeoGeng on 29/06/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "InverstInfoViewController.h"

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
    InvestmentInfoView *infoView = [[InvestmentInfoView alloc] initWithFrame:self.view.bounds withModel:_model];
    self.view = infoView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
