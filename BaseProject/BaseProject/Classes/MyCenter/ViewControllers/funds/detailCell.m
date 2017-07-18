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
        
    }
    return  _titleLabel;
}

-(UILabel *)timeLabel{
    
    if (!_timeLabel) {
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 33, screenWidth - 180, 15)];
        self.timeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        self.timeLabel.font = [UIFont SYSTEMFontOfSize:12];
        
    }
    return  _timeLabel;
}

-(UILabel *)moneyLabel{
    
    if (!_moneyLabel) {
        self.moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth - 164, 10,148, 15)];
        self.moneyLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        self.moneyLabel.font = [UIFont SYSTEMFontOfSize:15];
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

    }
    return  _stateLabel;
}

-(UIButton *)stateBut{
    
    if (!_stateBut) {
        self.stateBut =[UIButton buttonWithType:UIButtonTypeCustom];
        self.stateBut.frame = CGRectMake(screenWidth - 164, 33, 148, 15);
        self.stateBut.backgroundColor = [UIColor clearColor];
        
        self.stateBut.userInteractionEnabled = NO;
    }
    
    
    return _stateBut;
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      
        [self addSubview:self.titleLabel];
        [self addSubview:self.timeLabel];
        [self addSubview:self.stateLabel];
        [self addSubview:self.moneyLabel];
        [self addSubview:self.stateBut];
    }
    return self;
}

-(void)showData:(deatilMoneyModel *)info{
    
    self.moneyLabel.text = info.amount;
    self.timeLabel.text = info.create_time;
    self.titleLabel.text = info.action_type;
    
    if ([info.action_type isEqualToString:@"提现"]) {
    
        if ([info.wirhdrawals_type isEqualToString:@"提现失败"]) {
            
            self.stateBut.userInteractionEnabled = YES;
            self.stateLabel.text = [NSString stringWithFormat:@"%@ 原因",info.wirhdrawals_type];
            [self label:self.stateLabel allStr:self.stateLabel.text rangeStr:@"原因"];
        }else{
            
           self.stateLabel.text = info.wirhdrawals_type;
        }
    }
}

-(void)label:(UILabel *)label allStr:(NSString *)allStr rangeStr:(NSString *)rangeStr{
    
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString: allStr];
    NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:rangeStr].location, [[noteStr string] rangeOfString:rangeStr].length);
    //需要设置的位置
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#379ff2"] range:redRange];
    //设置颜色
    [label setAttributedText:noteStr];
    
}


@end
