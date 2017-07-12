//
//  pulicMath.h
//  充电桩
//
//  Created by 李超杰 on 17/4/19.
//  Copyright © 2017年 李超杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface pulicMath : NSObject

//判断字符串是否为空
+(BOOL)isBlankString:(NSString *)string;

//判断手机号码格式是否正确
+(BOOL)valiMobile:(NSString *)mobile;

//密码判断
+(BOOL)checkPassWord:(NSString *)str;

+(NSString*)dictionaryToJson:(NSDictionary *)dic;



@end
