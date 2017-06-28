//
//  setIMagecell.m
//  BaseProject
//
//  Created by li on 2017/6/28.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "Masonry.h"
#import "setIMagecell.h"

@implementation setIMagecell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self.contentView addSubview:self.setIMage];
        [self.contentView addSubview:self.setIMageLable];
    }
    return self;
}

-(UIImageView *)setIMage{
    if (!_setIMage) {
        self.setIMage=[[UIImageView alloc]init];
        [self.contentView addSubview:self.setIMage];
        [self.setIMage mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.mas_equalTo(15*SCALE);
            make.left.mas_equalTo(15*SCALE);
            make.height.mas_equalTo(32/2);
            make.width.mas_equalTo(32/2);
        }];
    }
    return _setIMage;
}

-(UILabel *)setIMageLable{
    if (!_setIMageLable) {
        self.setIMageLable=[[UILabel alloc]init];
        self.setIMageLable.backgroundColor=[UIColor clearColor];
        self.setIMageLable.font=HelveticaNeueFont(15*SCALE);
        self.setIMageLable.textColor=UIColorFromHex(0x333333);
        [self.contentView addSubview:self.setIMageLable];
        [self.setIMageLable mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.mas_equalTo(7*SCALE);
            make.left.mas_equalTo(self.setIMage.mas_right).offset(10*SCALE);
            make.height.mas_equalTo(30*SCALE);
            make.width.mas_equalTo(self.setIMageLable.mas_width);
        }];
    }
    return _setIMageLable;
}




@end
