//
//  deatilMoneyModel.m
//  BaseProject
//
//  Created by 李超杰 on 17/7/11.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "deatilMoneyModel.h"

@implementation deatilMoneyModel

-(id)initWithShowInfor:(NSDictionary *)myInfor{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:myInfor];
        
    }
    
    return self;
    
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


-(id)valueForUndefinedKey:(NSString *)key{
    
    return nil;
    
}


@end
