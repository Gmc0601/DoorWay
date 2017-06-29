//
//  InvestmentInfoView.m
//  BaseProject
//
//  Created by LeoGeng on 29/06/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "InvestmentInfoView.h"
#import <Masonry/Masonry.h>
#import "UIColor+BGHexColor.h"

@interface InvestmentInfoView()
@property(atomic,retain) UIScrollView *scrollView;
@property(atomic,retain) UIFont *font;
@property(atomic,retain) UIFont *highlightFont;
@property(atomic,retain) UIColor *fontColor;
@property(atomic,retain) UIColor *highlightFontColor;
@property(atomic,retain) UIButton *highlightButton;
@end

@implementation InvestmentInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}

-(void) addSubviews{
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    [self addSubview:_scrollView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 156)];
    imageView.backgroundColor = [UIColor redColor];
    [_scrollView addSubview:imageView];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 156, self.bounds.size.width, 44)];
    headerView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:headerView];
    
    CGFloat width = self.bounds.size.width / 4;
    _font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
    _highlightFont = [UIFont fontWithName:@"PingFang-SC-Medium" size:16];
    _fontColor = [UIColor colorWithHexString:@"#666666"];
    _highlightFontColor = [UIColor colorWithHexString:@"#379ff2"];
    
    UIButton *btnCompany = [[UIButton alloc] init];
    btnCompany.titleLabel.font = _highlightFont;
    [btnCompany setTitle:@"公司介绍" forState:UIControlStateNormal];
    [btnCompany setTitleColor:_highlightFontColor
                     forState:UIControlStateSelected];
    [btnCompany setTitleColor:_fontColor forState:UIControlStateNormal];
    [btnCompany setSelected:YES];
    btnCompany.titleLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:btnCompany];
    [btnCompany addTarget:self action:@selector(tapCompayButton:) forControlEvents:UIControlEventTouchUpInside];
    _highlightButton = btnCompany;
    
    [btnCompany mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(headerView);
        make.top.equalTo(headerView);
        make.bottom.equalTo(headerView);
        make.width.equalTo(@(width));
    }];
    
    UIButton *btnRole = [[UIButton alloc] init];
    btnRole.titleLabel.font = _font;
    [btnRole setTitle:@"盈利制度" forState:UIControlStateNormal];
    [btnRole setTitleColor:_highlightFontColor forState:UIControlStateSelected];
    [btnRole setTitleColor:_fontColor forState:UIControlStateNormal];
    btnRole.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnRole addTarget:self action:@selector(tapRoleButton:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:btnRole];
    
    [btnRole mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(btnCompany.mas_trailing);
        make.top.equalTo(headerView);
        make.bottom.equalTo(headerView);
        make.width.equalTo(@(width));
    }];
    
    UIButton *btnSummry = [[UIButton alloc] init];
    btnSummry.titleLabel.font = _font;
    [btnSummry setTitle:@"风险说明" forState:UIControlStateNormal];
    [btnSummry setTitleColor:_highlightFontColor forState:UIControlStateSelected];
    [btnSummry setTitleColor:_fontColor forState:UIControlStateNormal];
    btnSummry.titleLabel.textAlignment = NSTextAlignmentCenter;
[btnSummry addTarget:self action:@selector(tapSummryButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [headerView addSubview:btnSummry];
    
    [btnSummry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(btnRole.mas_trailing);
        make.top.equalTo(headerView);
        make.bottom.equalTo(headerView);
        make.width.equalTo(@(width));
    }];
    
    
    UIButton *btnComments = [[UIButton alloc] init];
    btnComments.titleLabel.font = _font;
    [btnComments setTitle:@"会员评论" forState:UIControlStateNormal];
    [btnComments setTitleColor:_highlightFontColor forState:UIControlStateSelected];
    [btnComments addTarget:self action:@selector(tapCommentsButton:) forControlEvents:UIControlEventTouchUpInside];
    [btnComments setTitleColor:_fontColor forState:UIControlStateNormal];
    btnComments.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [headerView addSubview:btnComments];
    
    [btnComments mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(btnSummry.mas_trailing);
        make.top.equalTo(headerView);
        make.bottom.equalTo(headerView);
        make.width.equalTo(@(width));
    }];
}

-(void) tapCompayButton:(UIButton *) sender{
    if (sender != _highlightButton) {
        [self changeButtonTitleStyle:sender];
    }
}

-(void) tapRoleButton:(UIButton *) sender{
    if (sender != _highlightButton) {
        [self changeButtonTitleStyle:sender];
    }
}

-(void) tapSummryButton:(UIButton *) sender{
    if (sender != _highlightButton) {
        [self changeButtonTitleStyle:sender];
    }
}

-(void) tapCommentsButton:(UIButton *) sender{
    if (sender != _highlightButton) {
        [self changeButtonTitleStyle:sender];
    }
}

-(void) changeButtonTitleStyle:(UIButton *)newButton{
    _highlightButton.titleLabel.font = _font;
    [_highlightButton setSelected:NO];
    
    newButton.titleLabel.font = _highlightFont;
    [newButton setSelected:YES];
    _highlightButton = newButton;
}

@end
