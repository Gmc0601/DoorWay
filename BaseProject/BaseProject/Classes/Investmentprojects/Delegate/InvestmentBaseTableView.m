//
//  BaseTableView.m
//  BaseProject
//
//  Created by LeoGeng on 30/06/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "InvestmentBaseTableView.h"
#import "WebViewTableViewCell.h"
#import "UIColor+BGHexColor.h"
#import <Masonry/Masonry.h>

@interface InvestmentBaseTableView()

@property(atomic,retain) UIFont *font;
@property(atomic,retain) UIFont *highlightFont;
@property(atomic,retain) UIColor *fontColor;
@property(atomic,retain) UIColor *highlightFontColor;
@property(atomic,retain) UIButton *highlightButton;
@end

@implementation InvestmentBaseTableView
@synthesize cellIdentifier;
@synthesize owner;

- (instancetype)initWithOwner:(UITableView *) _owner withCellIdentifier:(NSString *) _cellIdentifier
{
    self = [super init];
    if (self) {
        self.owner = _owner;
        self.cellIdentifier = _cellIdentifier;

    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return 44;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    
    if (header.subviews.count > 1) {
        return header;
    }
    header.backgroundColor = [UIColor whiteColor];
    
    CGFloat width = tableView.bounds.size.width / 4;
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
    [header addSubview:btnCompany];
    [btnCompany addTarget:self action:@selector(tapCompayButton:) forControlEvents:UIControlEventTouchUpInside];
    _highlightButton = btnCompany;
    
    [btnCompany mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(header);
        make.top.equalTo(header);
        make.bottom.equalTo(header);
        make.width.equalTo(@(width));
    }];
    
    UIButton *btnRole = [[UIButton alloc] init];
    btnRole.titleLabel.font = _font;
    [btnRole setTitle:@"盈利制度" forState:UIControlStateNormal];
    [btnRole setTitleColor:_highlightFontColor forState:UIControlStateSelected];
    [btnRole setTitleColor:_fontColor forState:UIControlStateNormal];
    btnRole.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnRole addTarget:self action:@selector(tapRoleButton:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:btnRole];
    
    [btnRole mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(btnCompany.mas_trailing);
        make.top.equalTo(header);
        make.bottom.equalTo(header);
        make.width.equalTo(@(width));
    }];
    
    UIButton *btnSummry = [[UIButton alloc] init];
    btnSummry.titleLabel.font = _font;
    [btnSummry setTitle:@"风险说明" forState:UIControlStateNormal];
    [btnSummry setTitleColor:_highlightFontColor forState:UIControlStateSelected];
    [btnSummry setTitleColor:_fontColor forState:UIControlStateNormal];
    btnSummry.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnSummry addTarget:self action:@selector(tapSummryButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [header addSubview:btnSummry];
    
    [btnSummry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(btnRole.mas_trailing);
        make.top.equalTo(header);
        make.bottom.equalTo(header);
        make.width.equalTo(@(width));
    }];
    
    UIButton *btnComments = [[UIButton alloc] init];
    btnComments.titleLabel.font = _font;
    [btnComments setTitle:@"会员评论" forState:UIControlStateNormal];
    [btnComments setTitleColor:_highlightFontColor forState:UIControlStateSelected];
    [btnComments addTarget:self action:@selector(tapCommentsButton:) forControlEvents:UIControlEventTouchUpInside];
    [btnComments setTitleColor:_fontColor forState:UIControlStateNormal];
    btnComments.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [header addSubview:btnComments];
    
    [btnComments mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(btnSummry.mas_trailing);
        make.top.equalTo(header);
        make.bottom.equalTo(header);
        make.width.equalTo(@(width));
    }];
    
    
    return  header;
}

-(void) tapCompayButton:(UIButton *) sender{
    if (sender != _highlightButton) {
        [self changeButtonTitleStyle:sender];
        [self.delegate didTapCompanyButton];
    }
}

-(void) tapRoleButton:(UIButton *) sender{
    if (sender != _highlightButton) {
        [self changeButtonTitleStyle:sender];
        [self.delegate didTapRoleButton];
    }
}

-(void) tapSummryButton:(UIButton *) sender{
    if (sender != _highlightButton) {
        [self changeButtonTitleStyle:sender];
        [self.delegate didTapSummryButton];
    }
}

-(void) tapCommentsButton:(UIButton *) sender{
    if (sender != _highlightButton) {
        [self changeButtonTitleStyle:sender];
        [self.delegate didTapCommentsButton];
    }
}

-(void) changeButtonTitleStyle:(UIButton *)newButton{
    _highlightButton.titleLabel.font = _font;
    [_highlightButton setSelected:NO];
    
    newButton.titleLabel.font = _highlightFont;
    [newButton setSelected:YES];
    _highlightButton = newButton;
}

-(UITableViewCell *) getCellInFirstSectionFromTableView:(UITableView *) tableView withHeaderImageUrl:(NSString *)url{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    
    NSURL *imageURL = [NSURL URLWithString:url];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // Update the UI
            UIImage *image = [UIImage imageWithData:imageData];
            cell.backgroundView = [[UIImageView alloc] initWithImage:image];

        });
    });
    
    return cell;
}

@end
