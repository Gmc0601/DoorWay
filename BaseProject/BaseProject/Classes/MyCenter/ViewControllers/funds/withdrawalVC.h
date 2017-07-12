//
//  withdrawalVC.h
//  BaseProject
//
//  Created by 李超杰 on 17/7/5.
//  Copyright © 2017年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol withdrawaDeledata <NSObject>

-(void)money:(NSString *)money;

@end

@interface withdrawalVC : UIViewController

@property(nonatomic,strong)NSString *money;
@property(nonatomic,strong)NSString *aliPay;

@property(nonatomic,strong)id<withdrawaDeledata>delegate;

@end
