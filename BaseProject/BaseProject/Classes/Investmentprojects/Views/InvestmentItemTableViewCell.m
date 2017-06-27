//
//  InvestmentItemTableViewCell.m
//  BaseProject
//
//  Created by LeoGeng on 27/06/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "InvestmentItemTableViewCell.h"
#import "NSString+Category.h"
#import <Masonry/Masonry.h>

@interface InvestmentItemTableViewCell()
@property(nonatomic, strong) UILabel *lblTitle;
@property(nonatomic, strong) UIImageView *imgView;
@property(nonatomic, strong) UIView *bottomView;
@property(nonatomic, strong) UIView *descriptionPanel;
@end

@implementation InvestmentItemTableViewCell

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
    [self addDescriptionPanel];
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

-(void) addDescriptionPanel{
    _descriptionPanel = [[UIView alloc] init];
    [_imgView addSubview:_descriptionPanel];
    
    [_descriptionPanel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imgView.mas_left).offset(0);
        make.right.equalTo(_imgView.mas_right).offset(0);
        make.bottom.equalTo(_imgView.mas_bottom).offset(0);
        make.height.equalTo(@100);
    }];
    
    [self addSubViewToDescriptionPanel];
}

-(void) addSubViewToDescriptionPanel{
    CGFloat fontSize = 30;
    _lblTitle = [[UILabel alloc] init];
    _lblTitle.text = @"国泰金龙债务A";
    _lblTitle.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:fontSize];
    _lblTitle.textColor = [UIColor colorWithRed:59/255 green:59/255 blue:59/255 alpha:1];
    [_descriptionPanel addSubview:_lblTitle];
    
    //TODO:
    CGFloat widthOffset = self.bounds.size.width - 100;
    CGFloat widthOfTitle = [_lblTitle.text widthWithFontSize:fontSize height:30];
    
    if (widthOfTitle > widthOffset) {
        widthOfTitle = widthOffset;
    }
    
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_descriptionPanel.mas_left).offset(26);
        make.top.equalTo(_descriptionPanel.mas_top).offset(20);
        make.width.equalTo(@(widthOfTitle));
        make.height.equalTo(@30);
    }];
}

@end
