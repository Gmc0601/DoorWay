//
//  CommentModel.m
//  BaseProject
//
//  Created by LeoGeng on 07/07/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel
+(void) loadData:(NSString *) projectId callback:(void(^)(NSArray *)) callBack{
    NSMutableArray *models = [[NSMutableArray alloc] init];
    NSDictionary *param = @{@"type" : @4,@"id":projectId};
    
    [HttpRequest postPath:@"_investitemdetails_001" params:param resultBlock:^(id responseObject, NSError *error) {
        
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        
        NSLog(@"login>>>>>>%@", responseObject);
        NSDictionary *datadic = responseObject;
        if ([datadic[@"error"] intValue] != 0) {
            
        }else {
            for (NSDictionary *dict in datadic[@"info"]) {
            }
        }
        NSLog(@"error>>>>%@", error);
        callBack(models);
    }];
}
@end
