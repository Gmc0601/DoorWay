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
#import "NSURL+Category.h"
#import "UIImageView+WebCache.h"

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
@property(nonatomic, strong) UIFont *font1;
@property(nonatomic, strong) UIFont *font2;
@property(nonatomic, strong) UIColor *fontColor;
@end

@implementation InvestmentItemTableViewCell
@synthesize model = _model;

-(void) setModel:(InvestmentModel *)model{
    _model = model;
    _lblTitle.text = model.name;
    [self resetConstraintsForTitle];
    
    _lblDescription.text = model.content;
    [self setMoney:model.money];
    [self setPublishDay:model.pushday];
    _lblRate.text = [NSString stringWithFormat:@"%@%%",model.backmoney];
    _lblRanking.text = model.ranking;
    [self setStatus:model.type];
    [self setBackgroundImage:model.img];
    [self setGrade:model.grade];
    [self setNationalFlag:model.country_img];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSString *strFontFamily = @"PingFang-SC-Medium";
        _font1 = [UIFont fontWithName:strFontFamily size:12];
        _font2 = [UIFont fontWithName:@"HelveticaNeue" size:18];
        _fontColor = [UIColor colorWithHexString:@"#666666"];

        self.selectionStyle =  UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        [self addInvestmentImageView];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark----private method
-(void) addInvestmentImageView{
    _imgView = [[UIImageView alloc] init];
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
    backgrounView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    backgrounView.alpha = 0.7;
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
    [self addDesciptionLabel];
    [self addInvestmentInfoView];
}

-(void) addTitleLabel{
    CGFloat fontSize = 15;
    
    _lblTitle = [[UILabel alloc] init];
    _lblTitle.text = @"国泰金龙债务A";
    _lblTitle.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:fontSize];
    _lblTitle.textColor = [UIColor colorWithRed:59/255 green:59/255 blue:59/255 alpha:1];
    _lblTitle.textAlignment = NSTextAlignmentCenter;
    [_descriptionPanel addSubview:_lblTitle];
    
    [self resetConstraintsForTitle];
}

-(void) resetConstraintsForTitle{
    [_lblTitle removeConstraints:_lblTitle.constraints];
    CGFloat fontSize = 18;
    CGFloat heightOfLblTitle = 15;
    
    //TODO:Set it when setting the value of title
    CGFloat widthOffset = self.bounds.size.width - 200;
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
    _nationalImageView.image = [UIImage imageNamed:@"sign_china"];
    _nationalImageView.layer.cornerRadius = 7.5;
    _nationalImageView.layer.masksToBounds = YES;
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

-(void) setGrade:(NSNumber *) grade{
    int tag = 2001;
    
    for (int i=0; i<5; i++) {
        [[_descriptionPanel viewWithTag:tag] removeFromSuperview];
        tag += 1;
    }
    
    CGFloat offset = -13;
    tag = 2001;
    for (int i=0; i<grade.intValue; i++) {
        UIImageView *img = [self addStarWithRightOffSet:offset];
        img.tag = tag;
        tag += 1;
        offset += -20;
    }
}

-(UIImageView *) addStarWithRightOffSet:(CGFloat)rightOffSet{
    UIImageView *starView = [[UIImageView alloc] init];
    starView.image = [UIImage imageNamed:@"icon_pf"];
    [_descriptionPanel addSubview:starView];
    
    [starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_descriptionPanel.mas_right).offset(rightOffSet);
        make.centerY.equalTo(_lblTitle.mas_centerY).offset(0);
        make.width.equalTo(@14);
        make.height.equalTo(@13);
    }];
    
    return starView;
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
    
    
    CGFloat fontSize = 12;
    UIColor *titleFontColor = [UIColor colorWithHexString:@"#999999"];
    UIFont *titleFont = [UIFont fontWithName:@"PingFang-SC-Medium" size:fontSize];
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
    lblDaysTitle.text = @"监测天数";
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
    
    _lblRanking = [[UILabel alloc] init];
    _lblRanking.text = @"50";
    _lblRanking.font = _font2;
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
    _lblRate.font = _font2;
    _lblRate.textColor = _fontColor;
    [self addSubview:_lblRate];
    
    [_lblRate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lblMoneyTitle.mas_bottom).offset(10);
        make.trailing.equalTo(_lblRanking.mas_leading).offset(5);
        make.leading.equalTo(lblRateOfReturnTitle.mas_leading).offset(0);
        make.height.equalTo(_lblRanking.mas_height);
    }];
    
    _lblDay = [[UILabel alloc] init];
    [self addSubview:_lblDay];
    
    [_lblDay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lblMoneyTitle.mas_bottom).offset(10);
        make.trailing.equalTo(_lblRate.mas_leading).offset(5);
        make.leading.equalTo(lblDaysTitle.mas_leading).offset(0);
        make.height.equalTo(_lblRanking.mas_height);
    }];
    
    _lblMoney = [[UILabel alloc] init];
    [self addSubview:_lblMoney];
    
    [_lblMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lblMoneyTitle.mas_bottom).offset(10);
        make.trailing.equalTo(_lblDay.mas_leading).offset(5);
        make.leading.equalTo(lblMoneyTitle.mas_leading).offset(0);
        make.height.equalTo(_lblRanking.mas_height);
    }];
    
}

-(void) setMoney:(NSString *) strMoney{
    _lblMoney.attributedText = [NSMutableAttributedString attributeString:@"￥" prefixFont:_font1 prefixColor:_fontColor suffixString:strMoney suffixFont:_font2 suffixColor:_fontColor];
}

-(void) setPublishDay:(NSString *) strMoney{
    _lblDay.attributedText = [NSMutableAttributedString attributeString:strMoney prefixFont:_font2 prefixColor:_fontColor suffixString:@"天" suffixFont:_font1 suffixColor:_fontColor];
}

-(void) setStatus:(NSString *) strStatus{
    
    if ([@"结束" isEqualToString:strStatus]) {
        _lblStatus.textColor = [UIColor colorWithHexString:@"#e3e3e3 "];
    }else if([@"预警" isEqualToString:strStatus]) {
        _lblStatus.textColor = [UIColor colorWithHexString:@"#ff9f00"];
    }else{
        _lblStatus.textColor = [UIColor colorWithHexString:@"#2d9bf2"];
    }
    
    _lblStatus.layer.borderColor = _lblStatus.textColor.CGColor;
    _lblStatus.text = strStatus;
}

-(void)setBackgroundImage:(NSString *) url{
    _imgView.image = nil;
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:url] completed:nil];
}

-(void) setNationalFlag:(NSString *) url{
    _nationalImageView.image = nil;

    [_nationalImageView sd_setImageWithURL:[NSURL URLWithString:url] completed:nil];
}
@end
