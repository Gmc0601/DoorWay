//
//  SecurityViewController.m
//  BaseProject
//
//  Created by li on 2017/6/29.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "SecurityViewController.h"

@interface SecurityViewController ()

@end

@implementation SecurityViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromHex(0xf0f0f0);
    
    self.navigationController.navigationBar.translucent = NO;
    
    [self setCustomerTitle:@"互助报单"];
   
}


@end
