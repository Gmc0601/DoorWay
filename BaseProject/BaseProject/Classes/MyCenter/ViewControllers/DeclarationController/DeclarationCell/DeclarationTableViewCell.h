//
//  DeclarationTableViewCell.h
//  BaseProject
//
//  Created by lxl on 2017/6/28.
//  Copyright © 2017年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeclarationTableViewCell : UITableViewCell

/**
 保单编号
 */
@property (weak, nonatomic) IBOutlet UILabel *numLab;
/**
 提交时间
 */
@property (weak, nonatomic) IBOutlet UILabel *uploadTimeLab;
/**
 证券名称
 */
@property (weak, nonatomic) IBOutlet UILabel *titleNameLab;
/**
 参投用户名
 */
@property (weak, nonatomic) IBOutlet UILabel *userNameLab;
/**
 参投金额
 */
@property (weak, nonatomic) IBOutlet UILabel *amountLab;
/**
 参投时间
 */
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

/**
 状态
 */
@property (weak, nonatomic) IBOutlet UILabel *typeLab;

@end
