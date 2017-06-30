//
//  InvestmentModel.m
//  BaseProject
//
//  Created by cc on 2017/6/27.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "InvestmentModel.h"

@implementation InvestmentModel

-(void) loadData{
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setObject:@"17092558802" forKey:@"mobile"];
    
    [HttpRequest postPath:@"_investitem_001" params:nil resultBlock:^(id responseObject, NSError *error) {
        
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        
        NSLog(@"login>>>>>>%@", responseObject);
        NSDictionary *datadic = responseObject;
        if ([datadic[@"error"] intValue] != 0) {
            
        }else {
            NSString *info = datadic[@"info"];
            [ConfigModel mbProgressHUD:info andView:nil];
        }
        NSLog(@"error>>>>%@", error);
    }];
}
@end
