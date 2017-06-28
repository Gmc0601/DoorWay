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
    }
    return self;
}

-(UIImageView *)setIMage{
    if (!_setIMage) {
        self.setIMage=[[UIImageView alloc]init];
        [self.contentView addSubview:self.setIMage];
        [self.setIMage mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.mas_equalTo(20);
            make.left.mas_equalTo(15);
            make.height.mas_equalTo(32/2);
            make.width.mas_equalTo(32/2);
        }];
    }
    return _setIMage;
}




@end
