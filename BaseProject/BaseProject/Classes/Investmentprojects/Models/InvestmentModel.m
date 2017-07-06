//
//  InvestmentModel.m
//  BaseProject
//
//  Created by cc on 2017/6/27.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "InvestmentModel.h"

@implementation InvestmentModel

+(void) loadData:(void(^)(NSArray *)) callBack{
    NSMutableArray *models = [[NSMutableArray alloc] init];
    
    [HttpRequest postPath:@"_investitem_001" params:nil resultBlock:^(id responseObject, NSError *error) {
        
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        
        NSLog(@"login>>>>>>%@", responseObject);
        NSDictionary *datadic = responseObject;
        if ([datadic[@"error"] intValue] != 0) {
            
        }else {
            for (NSDictionary *dict in datadic[@"info"]) {
                InvestmentModel *model = [[InvestmentModel alloc] init];
                model.backmoney = dict[@"backmoney"];
                model.content = dict[@"content"];
                model.country = dict[@"country"];
                model.country_img = dict[@"country_img"];
                model.create_time = dict[@"create_time"];
                model.grade = dict[@"grade"];
                model._id = dict[@"id"];
                model.img = dict[@"img"];
                model.introduction = dict[@"introduction"];
                model.money = dict[@"money"];
                model.name = dict[@"name"];
                model.pushday = [dict[@"pushday"] stringValue];
                model.ranking = dict[@"ranking"];
                model.real_id = dict[@"real_id"];
                model.sortnum = dict[@"sortnum"];
                model.system = dict[@"system"];
                model.type = dict[@"type"];
                
                [models addObject:model];
            }
        }
        NSLog(@"error>>>>%@", error);
        callBack(models);
    }];
}
@end
