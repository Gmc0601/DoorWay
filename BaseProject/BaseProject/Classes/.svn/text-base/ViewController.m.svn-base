//
//  ViewController.m
//  BaseProject
//
//  Created by cc on 2017/6/14.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "ViewController.h"
#import "KeychainUUID.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    KeychainUUID *keychain = [[KeychainUUID alloc] init];
    id data = [keychain readUDID];
    NSString *udidStr = data;
    NSDictionary *dic = @{
                          @"username":@"17326093194",
                          @"loginPass":@"000000",
                          @"device_number" : udidStr,
                          };

    [HttpRequest postPath:LoginURL params:dic resultBlock:^(id responseObject, NSError *error) {
        NSLog(@"Login>>>>>%@", responseObject);
        NSDictionary *dic = responseObject;
        NSLog(@"%@", dic);
        int errorint = [dic[@"error"] intValue];
        if (errorint == 0 ) {
            NSDictionary *info = dic[@"info"];
            NSString *userToken = info[@"userToken"];
            [ConfigModel saveString:userToken forKey:UserToken];
            [ConfigModel saveBoolObject:YES forKey:IsLogin];
            [ConfigModel mbProgressHUD:@"登录成功" andView:nil];
        }else {
            NSString *errorStr = dic[@"info"];
            NSLog(@"%@", errorStr);
            [ConfigModel mbProgressHUD:errorStr andView:nil];
            
        }
    }];
    
    
    NSString *str = @"你猜";
    NSLog(@"我只是来试一试 到底行不行");
    NSLog(@"%@", str);
    
    //
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
