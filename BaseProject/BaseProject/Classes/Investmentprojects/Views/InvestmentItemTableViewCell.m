//
//  InvestmentItemTableViewCell.m
//  BaseProject
//
//  Created by LeoGeng on 27/06/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "InvestmentItemTableViewCell.h"
#import <Masonry/Masonry.h>

@interface InvestmentItemTableViewCell()
@property(nonatomic, strong) UILabel *lblTitle;
@property(nonatomic, strong) UIImageView *imgView;
@property(nonatomic, strong) UIView *bottomView;
@end

@implementation InvestmentItemTableViewCell
@synthesize imageView;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle =  UITableViewCellSelectionStyleNone;

        self.backgroundColor = [UIColor whiteColor];
        [self addInvestmentImageView];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark----private method
-(void) addInvestmentImageView{
    _imgView = [[UIImageView alloc] init];
    _imgView.backgroundColor = [UIColor redColor];
    [self addSubview:_imgView];
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.top.equalTo(self.mas_top).offset(20);
        make.right.equalTo(self.mas_right).offset(0);
        make.height.equalTo(@312);
    }];
    
    [self addBackgroundView];
}

-(void) addBackgroundView{
    UIView *backgrounView = [[UIView alloc] init];
    backgrounView.backgroundColor = [UIColor whiteColor];
    backgrounView.alpha = 0.5;
    [_imgView addSubview:backgrounView];
    
    [backgrounView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imgView.mas_left).offset(0);
        make.right.equalTo(_imgView.mas_right).offset(0);
        make.bottom.equalTo(_imgView.mas_bottom).offset(0);
        make.height.equalTo(@100);

    }];
}

@end
