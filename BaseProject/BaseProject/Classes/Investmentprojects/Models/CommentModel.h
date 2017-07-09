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
@property(nonatomic) NSString* time;
@property(retain,atomic) NSString *comment;

+(void) loadData:(NSString *) projectId callback:(void(^)(BOOL,NSArray*)) callBack;
@end
