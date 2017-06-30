//
//  InvestmentInfoView1.m
//  BaseProject
//
//  Created by LeoGeng on 29/06/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "InvestmentInfoView.h"
#import "WebTableView.h"

//#import <Masonry/Masonry.h>
//#import "UIColor+BGHexColor.h"

@interface InvestmentInfoView()
@property(nonatomic, strong) UITableView *tb;
@property(atomic,retain) NSString *cellIdentifier;
@property(atomic,retain) WebTableView *webTableView;
@end

@implementation InvestmentInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _cellIdentifier = @"webViewCell";
        _webTableView = [[WebTableView alloc] initWithOwner:_tb withCellIdentifier:_cellIdentifier];
        
        _tb = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        [_tb registerClass:[WebViewTableViewCell class] forCellReuseIdentifier:_cellIdentifier];
        [_tb registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tb registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"header"];
        
        [self didTapCompanyButton];
        
        _tb.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_tb];
        
    }
    return self;
}

-(void) didTapCompanyButton{
    [self reloadWeb:@"https://www.google.com.hk/intl/zh-CN/policies/privacy/?fg=1"];
}

-(void) didTapRoleButton{
    [self reloadWeb:@"https://www.baidu.com/"];
}

-(void) didTapSummryButton{
    [self reloadWeb:@"http://www.163.com/"];
}

-(void) didTapCommentsButton{
    [self reloadWeb:@""];
}



-(void) reloadWeb:(NSString *) strUrl{
    _webTableView.strUrl = strUrl;
    if (_tb.dataSource != _webTableView) {
        _tb.dataSource = _webTableView;
        _tb.delegate = _webTableView;
    }
    
    [_tb reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
