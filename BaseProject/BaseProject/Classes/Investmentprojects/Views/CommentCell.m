//
//  CommentCellTableViewCell.m
//  BaseProject
//
//  Created by LeoGeng on 08/07/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "CommentCell.h"
#import "UIColor+BGHexColor.h"
#import <Masonry/Masonry.h>
#import "NSURL+Category.h"
#import "NSString+DisplayTime.h"
#import "NSString+Category.h"

@interface CommentCell()
@property(retain,atomic) UIImageView *avatar;
@property(retain,atomic) UILabel *lblNickName;
@property(retain,atomic) UILabel *lblDate;
@property(retain,atomic) UILabel *lblComment;
@end

@implementation CommentCell
@synthesize model = _model;

-(void) setModel:(CommentModel *)model{
    _model = model;
    [[NSURL URLWithString:model.avatarUrl] loadImage:^(UIImage *image) {
        _avatar.image = image;
    }];
    
    _lblDate.text = model.time;
    _lblNickName.text = model.nickName;
    _lblComment.text = model.comment;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubViews];
    }
    
    return self;
}

-(void) addSubViews{
    _avatar = [[UIImageView alloc] init];
    [self addSubview:_avatar];
    
    _lblNickName = [[UILabel alloc] init];
    _lblNickName.font = [UIFont fontWithName:@"PingFang-SC=Medium" size:11];
    _lblNickName.textColor = [UIColor colorWithHexString:@"#4780dd"];
    _lblNickName.textAlignment = NSTextAlignmentLeft;
    
    [self addSubview:_lblNickName];
    
    _lblDate = [[UILabel alloc] init];
    _lblDate.font = [UIFont fontWithName:@"HelveticaNeue" size:11];
    _lblDate.textColor = [UIColor colorWithHexString:@"#999999"];
    _lblDate.textAlignment = NSTextAlignmentLeft;
    
    [self addSubview:_lblDate];
    
    _lblComment = [[UILabel alloc] init];
    _lblComment.font = [UIFont fontWithName:@"HelveticaNeue,AdobeHeitiStd-Regular" size:15];
    _lblComment.textColor = [UIColor colorWithHexString:@"#333333"];
    _lblComment.textAlignment = NSTextAlignmentLeft;
    _lblComment.numberOfLines = 0;
    
    [self addSubview:_lblComment];
    
    [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(15);
        make.width.equalTo(@25);
        make.height.equalTo(@25);
        _avatar.layer.cornerRadius = 12.5;
        _avatar.layer.masksToBounds = YES;
    }];
    
    [_lblNickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avatar.mas_right).offset(5);
        make.top.equalTo(_avatar.mas_top).offset(0);
        make.right.equalTo(self);
        make.height.equalTo(@11);
    }];
    
    [_lblDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avatar.mas_right).offset(5);
        make.bottom.equalTo(_avatar.mas_bottom).offset(0);
        make.right.equalTo(self);
        make.height.equalTo(@11);
    }];
    
    [_lblComment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avatar.mas_left).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(-15);
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(_avatar.mas_bottom).offset(10);
    }];
    
    UIView *seperator = [[UIView alloc] init];
    seperator.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    [self addSubview:seperator];
    
    [seperator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.right.equalTo(self).offset(-10);
        make.left.equalTo(_avatar.mas_left).offset(0);
        make.height.equalTo(@1);
    }];
}

@end
