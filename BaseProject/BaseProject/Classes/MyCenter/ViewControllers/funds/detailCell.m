//
//  detailCell.m
//  BaseProject
//
//  Created by 李超杰 on 17/7/5.
//  Copyright © 2017年 cc. All rights reserved.
//
#define screenWidth [[UIScreen mainScreen] bounds].size.width
#define screenHeight [[UIScreen mainScreen] bounds].size.height

#import "detailCell.h"
#import "UIColor+UIColor_Hex_color.h"
#import "UIFont+UIFont_MyFont.h"
#import "deatilMoneyModel.h"

@implementation detailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 10, screenWidth - 180, 15)];
        self.titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        self.titleLabel.font = [UIFont SYSTEMFontOfSize:15];
        self.titleLabel.text = @"提现";
    }
    return  _titleLabel;
}

-(UILabel *)timeLabel{
    
    if (!_timeLabel) {
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 33, screenWidth - 180, 15)];
        self.timeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        self.timeLabel.font = [UIFont SYSTEMFontOfSize:12];
        self.timeLabel.text = @"2017/7/5";
    }
    return  _timeLabel;
}

-(UILabel *)moneyLabel{
    
    if (!_moneyLabel) {
        self.moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth - 164, 10,148, 15)];
        self.moneyLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        self.moneyLabel.font = [UIFont SYSTEMFontOfSize:15];
        self.moneyLabel.text = @"-100";
        self.moneyLabel.textAlignment = NSTextAlignmentRight;
    }
    return  _moneyLabel;
}

-(UILabel *)stateLabel{
    
    if (!_stateLabel) {
        self.stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth - 164, 33, 148, 15)];
        self.stateLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        self.stateLabel.font = [UIFont SYSTEMFontOfSize:12];
        self.stateLabel.textAlignment = NSTextAlignmentRight;
        self.stateLabel.text = @"提现审核中";
    }
    return  _stateLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      
        [self addSubview:self.titleLabel];
        [self addSubview:self.timeLabel];
        [self addSubview:self.stateLabel];
        [self addSubview:self.moneyLabel];
        
    }
    return self;
}

-(void)showData:(deatilMoneyModel *)info{
    
    self.moneyLabel.text = info.amount;
    self.timeLabel.text = info.create_time;
    self.titleLabel.text = info.action_type;
    if ([info.wirhdrawals_type isEqualToString:@"1"]) {
        self.stateLabel.text = @"成功";
    }else  if ([info.wirhdrawals_type isEqualToString:@"2"]){
        self.stateLabel.text = @"审核中";
    }else  if ([info.wirhdrawals_type isEqualToString:@"3"]){
        self.stateLabel.text = @"失败";
    }
}


@end
