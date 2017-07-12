//
//  detailCell.h
//  BaseProject
//
//  Created by 李超杰 on 17/7/5.
//  Copyright © 2017年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class deatilMoneyModel;

@interface detailCell : UITableViewCell

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *payeeLabel;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *moneyLabel;
@property(nonatomic,strong)UILabel *stateLabel;

-(void)showData:(deatilMoneyModel *)info;


@end
