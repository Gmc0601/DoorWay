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
@property(atomic,retain) KLCPopup *popover;
@property(atomic,retain) UITextView *txtView;
@property(atomic,retain) InvestmentModel *model;
@end

@implementation InvestmentInfoView

- (instancetype)initWithFrame:(CGRect)frame withModel:(InvestmentModel *) model
{
    self = [super initWithFrame:frame];
    if (self) {
        _model = model;
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
    [self reloadWeb:_model.introduction];
}

-(void) didTapRoleButton{
    [self removeAddCommentView];
    [self reloadWeb:_model.system];
}

-(void) didTapSummryButton{
    [self removeAddCommentView];
    [self reloadWeb:_model.explain];
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
    _webTableView.headerImageUrl = _model.img;
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
    _commnetsTableView.headerImageUrl = _model.img;
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
    
    if (_popover == nil) {
        UIView *inputPanel = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 145)];
        inputPanel.backgroundColor = [UIColor whiteColor];
        
        UIFont *font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
        UIColor *color = [UIColor colorWithHexString:@"#cccccc"];;
        
        UIButton *btnSender = [[UIButton alloc] init];
        [btnSender setTitle:@"发送" forState:UIControlStateNormal];
        btnSender.titleLabel.font = font;
        btnSender.titleLabel.textAlignment = NSTextAlignmentLeft;
        [btnSender setTitleColor:color forState:UIControlStateNormal];
        [btnSender addTarget:self action:@selector(tapSendeButton) forControlEvents:UIControlEventTouchUpInside];
        
        [inputPanel addSubview:btnSender];
        [btnSender mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(inputPanel).offset(16);
            make.top.equalTo(inputPanel).offset(10);
            make.height.equalTo(@15);
            make.width.equalTo(@40);
        }];
        
        UIButton *btnCancel = [[UIButton alloc] init];
        [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
        btnCancel.titleLabel.font = font;
        btnCancel.titleLabel.textAlignment = NSTextAlignmentRight;
        [btnCancel setTitleColor:color forState:UIControlStateNormal];
        [btnCancel addTarget:self action:@selector(tapCancelInputButton) forControlEvents:UIControlEventTouchUpInside];
        
        [inputPanel addSubview:btnCancel];
        [btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(inputPanel).offset(-16);
            make.top.equalTo(inputPanel).offset(10);
            make.height.equalTo(@15);
            make.width.equalTo(@40);
        }];
        
        _txtView = [[UITextView alloc] init];
        [inputPanel addSubview:_txtView];
        
        [_txtView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(btnCancel.mas_bottom).offset(15);
            make.bottom.equalTo(inputPanel);
            make.left.equalTo(inputPanel);
            make.right.equalTo(inputPanel);
        }];
        
        _popover = [KLCPopup popupWithContentView:inputPanel];
        _popover.showType = KLCPopupShowTypeSlideInFromBottom;
        _popover.dismissType = KLCPopupDismissTypeSlideOutToBottom;
        
        InvestmentInfoView *this = self;
        [_popover setWillStartDismissingCompletion:^(){
            [this.txtView resignFirstResponder];
        }];
    }
    
    [_txtView becomeFirstResponder];
    [_popover showAtCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2 + 10) inView:self];
}

-(void) tapCancelInputButton{
    [_popover dismiss:true];
}

-(void) tapSendeButton{
    
}

@end
