//
//  CommentModel.m
//  BaseProject
//
//  Created by LeoGeng on 07/07/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel
+(void) loadData:(NSString *) projectId callback:(void(^)(BOOL,NSArray*)) callBack{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setObject:@4 forKey:@"type"];
    [param setObject:projectId forKey:@"items_id"];
    
    if (![ConfigModel getBoolObjectforKey:IsLogin] ) {
        NSString *userTokenStr = [ConfigModel getStringforKey:UserToken];
        [param setObject:userTokenStr forKey:@"userToken"];
    }
    
    [HttpRequest postPath:@"_investitemdetails_001" params:param resultBlock:^(id responseObject, NSError *error) {
        NSMutableArray *models = [[NSMutableArray alloc] init];
        BOOL isLike = NO;
        @try {
            NSDictionary *datadic = responseObject;
            if ([datadic[@"error"] intValue] != 0) {
                [ConfigModel mbProgressHUD:datadic[@"info"] andView:nil];
            }else {
                isLike = datadic[@"info"][@"users_good"];
                NSArray *dataArr = datadic[@"info"][@"usercomment"];
                if (![dataArr  isEqual: @""]) {
                    for (NSDictionary *dict in dataArr) {
                        CommentModel *model = [[CommentModel alloc] init];
                        model.avatarUrl = dict[@"avatar_url"];
                        model.comment = dict[@"comment"];
                        model.time = dict[@"time"];
                        model.nickName = dict[@"nickname"];
                        [models addObject:model];
                    }
                }
                
            }
        } @catch (NSException *exception) {
            NSLog(@"%@",exception);
        }
        
        callBack(isLike,models);
    }];
}
@end
