//
//  InvestmentModel.h
//  BaseProject
//
//  Created by LeoGeng on 29/06/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InvestmentModel : NSObject
@property(retain,atomic) NSString *country;
@property(retain,atomic) NSString *country_img;
@property(assign,nonatomic) NSNumber *id;
@property(retain,atomic) NSString *name;
@property(retain,atomic) NSString *img;
@property(assign,nonatomic) NSNumber *grade;
@property(retain,atomic) NSNumber *money;
@property(retain,atomic) NSString *backmoney;
@property(retain,atomic) NSNumber *introduction;
@property(retain,atomic) NSNumber *type;
@property(retain,atomic) NSNumber *create_time;
@property(retain,atomic) NSNumber *pushday;
@end
