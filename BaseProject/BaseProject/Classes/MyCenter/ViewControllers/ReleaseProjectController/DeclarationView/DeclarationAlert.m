//
//  DeclarationAlert.m
//  BaseProject
//
//  Created by lxl on 2017/7/4.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "DeclarationAlert.h"

@implementation DeclarationAlert

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib{
    [super awakeFromNib];
    self.detailLab.text = [NSString stringWithFormat:@"需要个人互助额度达到\n50000MSC才能发起项目"];
}
@end
