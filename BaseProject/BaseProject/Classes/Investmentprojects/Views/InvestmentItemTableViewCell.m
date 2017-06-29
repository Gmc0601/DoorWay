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
#import "UIColor+BGHexColor.h"
#import "NSMutableAttributedString+Category.h"

@interface InvestmentItemTableViewCell()
@property(nonatomic, strong) UILabel *lblTitle;
@property(nonatomic, strong) UIImageView *imgView;
@property(nonatomic, strong) UIView *bottomView;
@property(nonatomic, strong) UIView *descriptionPanel;
@property(nonatomic, strong) UIImageView *nationalImageView;
@property(nonatomic, strong) UILabel *lblStatus;
@property(nonatomic, strong) UILabel *lblDescription;
@property(nonatomic, strong) UILabel *lblMoney;
@property(nonatomic, strong) UILabel *lblDay;
@property(nonatomic, strong) UILabel *lblRate;
@property(nonatomic, strong) UILabel *lblRanking;
@end

@implementation InvestmentItemTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle =  UITableViewCellSelectionStyleNone;

        self.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
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
        make.top.equalTo(self.mas_top).offset(10);
        make.right.equalTo(self.mas_right).offset(0);
        make.height.equalTo(@156);
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
        make.height.equalTo(@50);

    }];
}

-(void) addDescriptionPanel{
    _descriptionPanel = [[UIView alloc] init];
    [_imgView addSubview:_descriptionPanel];
    
    [_descriptionPanel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imgView.mas_left).offset(0);
        make.right.equalTo(_imgView.mas_right).offset(0);
        make.bottom.equalTo(_imgView.mas_bottom).offset(0);
        make.height.equalTo(@53);
    }];
    
    [self addSubViewToDescriptionPanel];
}

-(void) addSubViewToDescriptionPanel{
    [self addTitleLabel];
    [self addNationalImageView];
    [self addStatusLable];
    [self addStarWithRightOffSet:-13];
    [self addDesciptionLabel];
    [self addInvestmentInfoView];
}

-(void) addTitleLabel{
    CGFloat fontSize = 15;
    CGFloat heightOfLblTitle = 15;
    
    _lblTitle = [[UILabel alloc] init];
    _lblTitle.text = @"国泰金龙债务A";
    _lblTitle.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:fontSize];
    _lblTitle.textColor = [UIColor colorWithRed:59/255 green:59/255 blue:59/255 alpha:1];
    _lblTitle.textAlignment = NSTextAlignmentCenter;
    [_descriptionPanel addSubview:_lblTitle];
    
    //TODO:Set it when setting the value of title
    CGFloat widthOffset = self.bounds.size.width - 130;
    CGFloat widthOfTitle = [_lblTitle.text widthWithFontSize:fontSize height:heightOfLblTitle];
    
    if (widthOfTitle > widthOffset) {
        widthOfTitle = widthOffset;
    }
    
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_descriptionPanel.mas_left).offset(13);
        make.top.equalTo(_descriptionPanel.mas_top).offset(10);
        make.width.equalTo(@(widthOfTitle));
        make.height.equalTo(@(heightOfLblTitle));
    }];
}

-(void) addNationalImageView{
    _nationalImageView = [[UIImageView alloc] init];
    _nationalImageView.backgroundColor = [UIColor greenColor];
    [_descriptionPanel addSubview:_nationalImageView];
    
    [_nationalImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lblTitle.mas_right).offset(8);
        make.centerY.equalTo(_lblTitle.mas_centerY).offset(0);
        make.width.equalTo(_lblTitle.mas_height);
        make.height.equalTo(_lblTitle.mas_height);
    }];
}

-(void) addStatusLable{
    CGFloat fontSize = 10;
    _lblStatus = [[UILabel alloc] init];
    _lblStatus.text = @"正常";
    _lblStatus.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:fontSize];
    _lblStatus.textColor = [UIColor colorWithHexString:@"#2d9bf2"];
    _lblStatus.layer.cornerRadius = 5;
    _lblStatus.layer.borderColor = _lblStatus.textColor.CGColor;
    _lblStatus.layer.borderWidth = 1;
    _lblStatus.textAlignment = NSTextAlignmentCenter;
    [_descriptionPanel addSubview:_lblStatus];
    
    [_lblStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nationalImageView.mas_right).offset(7);
        make.centerY.equalTo(_lblTitle.mas_centerY).offset(0);
        make.width.equalTo(@30);
        make.height.equalTo(@12);
    }];
}

-(void) addStarWithRightOffSet:(CGFloat)rightOffSet{
    UIImageView *starView = [[UIImageView alloc] init];
    starView.backgroundColor = [UIColor greenColor];
    [_descriptionPanel addSubview:starView];
    
    [starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_descriptionPanel.mas_right).offset(rightOffSet);
        make.centerY.equalTo(_lblTitle.mas_centerY).offset(0);
        make.width.equalTo(@14);
        make.height.equalTo(@13);
    }];
}

-(void) addDesciptionLabel{
    CGFloat fontSize = 13;
    _lblDescription = [[UILabel alloc] init];
    _lblDescription.text = @"正常正常正常正常正常正常正常正常";
    _lblDescription.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:fontSize];
    _lblDescription.textColor = [UIColor colorWithHexString:@"#666666"];
    [_descriptionPanel addSubview:_lblDescription];
    
    [_lblDescription mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lblTitle.mas_bottom).offset(9);
        make.left.equalTo(_lblTitle.mas_left).offset(0);
        make.right.equalTo(_descriptionPanel.mas_right).offset(-13);
        make.height.equalTo(@15);
    }];
}

-(void) addInvestmentInfoView{
    UIView *infoView = [[UIView alloc] init];
    infoView.backgroundColor = [UIColor whiteColor];
    [self addSubview:infoView];
    
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_descriptionPanel.mas_bottom).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(0);
    }];
    
    
    NSString *strFontFamily = @"PingFang-SC-Medium";
    CGFloat fontSize = 12;
    UIColor *titleFontColor = [UIColor colorWithHexString:@"#999999"];
    UIFont *titleFont = [UIFont fontWithName:strFontFamily size:fontSize];
    CGFloat padding = 45;
    
    UILabel *lblMoneyTitle = [[UILabel alloc] init];
    lblMoneyTitle.text = @"投资金额";
    lblMoneyTitle.font = titleFont;
    lblMoneyTitle.textColor = titleFontColor;
    [self addSubview:lblMoneyTitle];
    
    [lblMoneyTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_descriptionPanel.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(13);
        make.height.equalTo(@12);
        make.width.equalTo(@(50));
    }];
    
    UILabel *lblDaysTitle = [[UILabel alloc] init];
    lblDaysTitle.text = @"检测天数";
    lblDaysTitle.font = titleFont;
    lblDaysTitle.textColor = titleFontColor;
    [self addSubview:lblDaysTitle];
    
    [lblDaysTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lblMoneyTitle.mas_centerY).offset(0);
        make.left.equalTo(lblMoneyTitle.mas_right).offset(padding);
        make.height.equalTo(lblMoneyTitle.mas_height);
        make.width.equalTo(@(50));
    }];
    
    UILabel *lblRateOfReturnTitle = [[UILabel alloc] init];
    lblRateOfReturnTitle.text = @"投资回报率";
    lblRateOfReturnTitle.font = titleFont;
    lblRateOfReturnTitle.textColor = titleFontColor;

    [self addSubview:lblRateOfReturnTitle];
    
    [lblRateOfReturnTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lblMoneyTitle.mas_centerY).offset(0);
        make.left.equalTo(lblDaysTitle.mas_right).offset(padding);
        make.height.equalTo(lblMoneyTitle.mas_height);
        make.width.equalTo(@(70));
    }];
    
    UILabel *lblRankingTitle = [[UILabel alloc] init];
    lblRankingTitle.text = @"全球排名";
    lblRankingTitle.font = titleFont;
    lblRankingTitle.textColor = titleFontColor;
    [self addSubview:lblRankingTitle];
    
    [lblRankingTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lblMoneyTitle.mas_centerY).offset(0);
        make.right.equalTo(self.mas_right).offset(-13);
        make.height.equalTo(lblMoneyTitle.mas_height);
        make.width.equalTo(@(50));
    }];
    
    UIFont *font1 = [UIFont fontWithName:strFontFamily size:12];
    UIFont *font2 = [UIFont fontWithName:@"HelveticaNeue" size:18];
    UIColor *fontColor = [UIColor colorWithHexString:@"#666666"];

    _lblRanking = [[UILabel alloc] init];
    _lblRanking.text = @"50";
    _lblRanking.font = font2;
    _lblRanking.textColor = [UIColor colorWithHexString:@"#f8780b"];
    _lblRanking.textAlignment = NSTextAlignmentRight;
    [self addSubview:_lblRanking];
    
    [_lblRanking mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lblMoneyTitle.mas_bottom).offset(10);
        make.trailing.equalTo(lblRankingTitle).offset(0);
        make.leading.equalTo(lblRankingTitle).offset(0);
        make.height.equalTo(@18);
    }];
    
    _lblRate = [[UILabel alloc] init];
    _lblRate.text = @"62%";
    _lblRate.font = font2;
    _lblRate.textColor = fontColor;
    [self addSubview:_lblRate];
    
    [_lblRate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lblMoneyTitle.mas_bottom).offset(10);
        make.trailing.equalTo(_lblRanking.mas_leading).offset(5);
        make.leading.equalTo(lblRateOfReturnTitle.mas_leading).offset(0);
        make.height.equalTo(_lblRanking.mas_height);
    }];
    
    _lblDay = [[UILabel alloc] init];
    _lblDay.attributedText = [NSMutableAttributedString attributeString:@"70" prefixFont:font2 prefixColor:fontColor suffixString:@"天" suffixFont:font1 suffixColor:fontColor];
    [self addSubview:_lblDay];
    
    [_lblDay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lblMoneyTitle.mas_bottom).offset(10);
        make.trailing.equalTo(_lblRate.mas_leading).offset(5);
        make.leading.equalTo(lblDaysTitle.mas_leading).offset(0);
        make.height.equalTo(_lblRanking.mas_height);
    }];
    
    _lblMoney = [[UILabel alloc] init];
    _lblMoney.attributedText = [NSMutableAttributedString attributeString:@"￥" prefixFont:font1 prefixColor:fontColor suffixString:@"50000" suffixFont:font2 suffixColor:fontColor];
    [self addSubview:_lblMoney];
    
    [_lblMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lblMoneyTitle.mas_bottom).offset(10);
        make.trailing.equalTo(_lblDay.mas_leading).offset(5);
        make.leading.equalTo(lblMoneyTitle.mas_leading).offset(0);
        make.height.equalTo(_lblRanking.mas_height);
    }];
    
}

@end
