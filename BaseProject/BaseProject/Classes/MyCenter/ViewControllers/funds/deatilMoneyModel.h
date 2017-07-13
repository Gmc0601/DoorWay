//
//  deatilMoneyModel.h
//  BaseProject
//
//  Created by 李超杰 on 17/7/11.
//  Copyright © 2017年 cc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface deatilMoneyModel : NSObject

@property(nonatomic,strong)NSString *amount;//单笔交易金额
@property(nonatomic,strong)NSString *type;//1增加  2减少
@property(nonatomic,strong)NSString *action_type;//具体金额操作类型
@property(nonatomic,strong)NSString *create_time;//操作时间
@property(nonatomic,strong)NSString *user_id;
@property(nonatomic,strong)NSString *action_id;
@property(nonatomic,strong)NSString *user_account;
@property(nonatomic,strong)NSString *wirhdrawals_type;//提现的状态（1成功  2审核中  3失败）
@property(nonatomic,strong)NSString *cause;//提现失败的原因
@property(nonatomic,strong)NSString *mobile;//好友激活账户时 该好友的手机号

-initWithShowInfor:(NSDictionary *)myInfor;


@end
