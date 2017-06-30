//
//  InvestmentInfoView1.m
//  BaseProject
//
//  Created by LeoGeng on 29/06/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "InvestmentInfoView.h"
#import "WebTableView.h"
#import "CommnetsTableView.h"
#import <Masonry/Masonry.h>
#import "UIColor+BGHexColor.h"

#define input_panel_tag 1001

@interface InvestmentInfoView()
@property(nonatomic, strong) UITableView *tb;
@property(atomic,retain) NSString *webViewCellIdentifier;
@property(atomic,retain) NSString *commentsCellIdentifier;
@property(atomic,retain) WebTableView *webTableView;
@property(atomic,retain) CommnetsTableView *commnetsTableView;
@end

@implementation InvestmentInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initDateSourceDelegate];
        
        _tb = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        [_tb registerClass:[WebViewTableViewCell class] forCellReuseIdentifier:_webViewCellIdentifier];
        [_tb registerClass:[UITableViewCell class] forCellReuseIdentifier:_commentsCellIdentifier];
        [_tb registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tb registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"header"];
        
        [self didTapCompanyButton];
        
        _tb.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_tb];
        
    }
    return self;
}

-(void) didTapCompanyButton{
    [self removeInputPanel];
    [self reloadWeb:@"https://www.google.com.hk/intl/zh-CN/policies/privacy/?fg=1"];
}

-(void) didTapRoleButton{
    [self removeInputPanel];
    [self reloadWeb:@"https://www.baidu.com/"];
}

-(void) didTapSummryButton{
    [self removeInputPanel];
    [self reloadWeb:@"http://www.163.com/"];
}

-(void) didTapCommentsButton{
    if (_tb.dataSource != _commnetsTableView) {
        _tb.dataSource = _commnetsTableView;
        _tb.delegate = _commnetsTableView;
    }
    
    [_tb reloadData];
    [self addInputPanel];
}

-(void) reloadWeb:(NSString *) strUrl{
    _webTableView.strUrl = strUrl;
    if (_tb.dataSource != _webTableView) {
        _tb.dataSource = _webTableView;
        _tb.delegate = _webTableView;
    }
    
    [_tb reloadData];
}

-(void) initDateSourceDelegate{
    _webViewCellIdentifier = @"webViewCell";
    _commentsCellIdentifier = @"commnetsViewCell";
    
    _webTableView = [[WebTableView alloc] initWithOwner:_tb withCellIdentifier:_webViewCellIdentifier];
    _webTableView.delegate = self;
    
    _commnetsTableView = [[CommnetsTableView alloc] initWithOwner:_tb withCellIdentifier:_commentsCellIdentifier];
    _commnetsTableView.delegate = self;
}

-(void) addInputPanel{
    UIView *inputPanel = [[UIView alloc] init];
    inputPanel.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    inputPanel.tag = input_panel_tag;
    
    [self addSubview:inputPanel];
    
    [inputPanel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
        make.height.equalTo(@(48));
    }];
    
    UIButton *btnSend = [[UIButton alloc] init];
    [btnSend setTitle:@"说说你对该项目的看法吧..." forState:UIControlStateNormal];
    btnSend.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
    [btnSend setTitleColor:[UIColor colorWithHexString:@"#cccccc"] forState:UIControlStateNormal];
    btnSend.backgroundColor = [UIColor whiteColor];
    btnSend.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btnSend.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    btnSend.layer.cornerRadius = 16.5;
    
    [inputPanel addSubview:btnSend];
    
    [btnSend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(inputPanel.mas_left).offset(15);
        make.centerY.equalTo(inputPanel.mas_centerY);
        make.height.equalTo(@33);
        make.width.equalTo(@300);
    }];
    
    UIButton  *btnLike = [[UIButton alloc] init];
    [btnLike setImage:[UIImage imageNamed:@"icon_xq_z"] forState:UIControlStateNormal];
    [btnLike setImage:[UIImage imageNamed:@"btn_xq"] forState:UIControlStateSelected];
    
    [inputPanel addSubview:btnLike];
    
    [btnLike mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(inputPanel).offset(-20);
        make.centerY.equalTo(inputPanel.mas_centerY);
        make.height.equalTo(@19);
        make.width.equalTo(@19);
    }];
    
}

-(void) removeInputPanel{
    UIView *inputPanel = [self viewWithTag:input_panel_tag];

    if (inputPanel != nil) {
        [inputPanel removeFromSuperview];
    }
}

@end
