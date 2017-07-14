//
//  InvestmentModel.h
//  BaseProject
//
//  Created by cc on 2017/6/27.
//  Copyright © 2017年 cc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InvestmentModel : NSObject
@property(retain,atomic) NSString *backmoney;
@property(retain,atomic) NSString *content;
@property(retain,atomic) NSString *country;
@property(retain,atomic) NSString *country_img;
@property(retain,atomic) NSDate *create_time;
@property(retain,atomic) NSNumber *grade;
@property(retain,atomic) NSString *_id;
@property(retain,atomic) NSString *img;
@property(retain,atomic) NSString *introduction;
@property(retain,atomic) NSString *money;
@property(retain,atomic) NSString *name;
@property(retain,atomic) NSString *pushday;
@property(retain,atomic) NSString *ranking;
@property(retain,atomic) NSString *real_id;
@property(retain,atomic) NSString *sortnum;
@property(retain,atomic) NSString *system;
@property(retain,atomic) NSString *type;
@property(retain,atomic) NSString *explain;


+(void) loadData:(int) page callback:(void(^)(NSArray *)) callBack;
@end
