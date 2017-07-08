//
//  CommentModel.h
//  BaseProject
//
//  Created by LeoGeng on 07/07/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject
@property(retain,atomic) NSString *nickName;
@property(retain,atomic) NSString *avatarUrl;
@property(nonatomic) NSTimeInterval time;
@property(retain,atomic) NSString *comment;

+(void) loadData:(NSString *) projectId callback:(void(^)(NSArray *)) callBack;
+(NSArray *) fakeData;
@end
