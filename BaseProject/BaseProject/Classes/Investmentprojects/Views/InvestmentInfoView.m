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
#import "KLCPopup.h"

#define add_comment_tag 1001
#define input_panel_tag 1002

@interface InvestmentInfoView()
@property(nonatomic, strong) UITableView *tb;
@property(atomic,retain) NSString *webViewCellIdentifier;
@property(atomic,retain) NSString *commentsCellIdentifier;
@property(atomic,retain) WebTableView *webTableView;
@property(atomic,retain) CommnetsTableView *commnetsTableView;
@property(atomic,retain) KLCPopup *inputPanel;
@property(atomic,retain) UITextView *txtView;
@end

@implementation InvestmentInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _webViewCellIdentifier = @"webViewCell";
        _commentsCellIdentifier = @"commnetsViewCell";
        
        _tb = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        [_tb registerClass:[WebViewTableViewCell class] forCellReuseIdentifier:_webViewCellIdentifier];
        [_tb registerClass:[UITableViewCell class] forCellReuseIdentifier:_commentsCellIdentifier];
        [_tb registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tb registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"header"];
        [self initDateSourceDelegate];

        [self didTapCompanyButton];
        _tb.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_tb];
        
    }
    return self;
}

-(void) didTapCompanyButton{
    [self removeAddCommentView];
    [self reloadWeb:@"https://www.google.com.hk/intl/zh-CN/policies/privacy/?fg=1"];
}

-(void) didTapRoleButton{
    [self removeAddCommentView];
    [self reloadWeb:@"https://www.baidu.com/"];
}

-(void) didTapSummryButton{
    [self removeAddCommentView];
    [self reloadWeb:@"http://www.163.com/"];
}

-(void) didTapCommentsButton{
    if (_tb.dataSource != _commnetsTableView) {
        _tb.dataSource = _commnetsTableView;
        _tb.delegate = _commnetsTableView;
    }
    
    [_tb reloadData];
    [self addCommentsView];
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
    
    _webTableView = [[WebTableView alloc] initWithOwner:_tb withCellIdentifier:_webViewCellIdentifier];
    _webTableView.delegate = self;
    
    _commnetsTableView = [[CommnetsTableView alloc] initWithOwner:_tb withCellIdentifier:_commentsCellIdentifier];
    _commnetsTableView.delegate = self;
}

-(void) addCommentsView{
    UIView *addCommentView = [[UIView alloc] init];
    addCommentView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    addCommentView.tag = add_comment_tag;
    
    [self addSubview:addCommentView];
    
    [addCommentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
        make.height.equalTo(@(48));
    }];
    
    UIButton *btnAddComments = [[UIButton alloc] init];
    [btnAddComments setTitle:@"说说你对该项目的看法吧..." forState:UIControlStateNormal];
    btnAddComments.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
    [btnAddComments setTitleColor:[UIColor colorWithHexString:@"#cccccc"] forState:UIControlStateNormal];
    btnAddComments.backgroundColor = [UIColor whiteColor];
    btnAddComments.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btnAddComments.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    btnAddComments.layer.cornerRadius = 16.5;
    [btnAddComments addTarget:self action:@selector(tapAddCommentsButtpn:) forControlEvents:UIControlEventTouchUpInside];
    [addCommentView addSubview:btnAddComments];
    
    [btnAddComments mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addCommentView.mas_left).offset(15);
        make.centerY.equalTo(addCommentView.mas_centerY);
        make.height.equalTo(@33);
        make.width.equalTo(@300);
    }];
    
    UIButton  *btnLike = [[UIButton alloc] init];
    [btnLike setImage:[UIImage imageNamed:@"icon_xq_z"] forState:UIControlStateNormal];
    [btnLike setImage:[UIImage imageNamed:@"btn_xq"] forState:UIControlStateSelected];
    
    [addCommentView addSubview:btnLike];
    
    [btnLike mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(addCommentView).offset(-20);
        make.centerY.equalTo(addCommentView.mas_centerY);
        make.height.equalTo(@19);
        make.width.equalTo(@19);
    }];
    
}

-(void) removeAddCommentView{
    UIView *addCommentView = [self viewWithTag:add_comment_tag];
    
    if (addCommentView != nil) {
        [addCommentView removeFromSuperview];
    }
}

-(void) tapAddCommentsButtpn:(UIButton *) sender{
    
    if (_inputPanel == nil) {
        UIView *pop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 145)];
        pop.backgroundColor = [UIColor whiteColor];
        
        _txtView = [[UITextView alloc] init];
        [pop addSubview:_txtView];
        
        [_txtView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(pop).offset(10);
            make.bottom.equalTo(pop);
            make.left.equalTo(pop);
            make.right.equalTo(pop);
        }];
        
        _inputPanel = [KLCPopup popupWithContentView:pop];
        _inputPanel.showType = KLCPopupShowTypeSlideInFromBottom;
        _inputPanel.dismissType = KLCPopupDismissTypeSlideOutToBottom;
        
        InvestmentInfoView *this = self;
        [_inputPanel setWillStartDismissingCompletion:^(){
            [this.txtView resignFirstResponder];
        }];
    }
    
    [_txtView becomeFirstResponder];
    [_inputPanel showAtCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2 + 10) inView:self];
}

@end
