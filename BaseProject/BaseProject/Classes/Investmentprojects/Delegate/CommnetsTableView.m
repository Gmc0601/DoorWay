//
//  CommnetsTableView.m
//  BaseProject
//
//  Created by LeoGeng on 30/06/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "CommnetsTableView.h"
#import "UIColor+BGHexColor.h"
#import <Masonry/Masonry.h>

@implementation CommnetsTableView
@synthesize dataSource;

- (instancetype)initWithOwner:(UITableView *) owner withCellIdentifier:(NSString *) cellIdentifier
{
    self = [super initWithOwner:owner withCellIdentifier:cellIdentifier];
    if (self) {
        
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [self getCellInFirstSectionFromTableView:tableView withHeaderImageUrl:self.headerImageUrl];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
        
        
        if(self.dataSource.count > 0){
            
        }else{
            if (indexPath.row == 0) {
                [self addSubViewToEmptyCell:cell];
            }
        }
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        if (self.dataSource == nil) {
            return 2;
        }else{
            return self.dataSource.count;
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 156;
    }else{
        if (self.dataSource == nil) {
            if(indexPath.row == 0){
                return tableView.frame.size.height - 310;
            }else{
                return 48;
            }
        }else{
            return self.dataSource.count;
        }
    }
    
    return 0;
}

-(void) addSubViewToEmptyCell:(UITableViewCell *) cell{
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.image = [UIImage imageNamed:@"icon_xq_qs"];
    
    [cell addSubview:imgView];
    
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(cell.mas_centerX).offset(0);
        make.top.equalTo(cell.mas_top).offset(125);
        make.width.equalTo(@52);
        make.height.equalTo(@49.5);
    }];
    
    UILabel *lbl = [[UILabel alloc] init];
    lbl.text=@"暂时还没有人评论哦";
    lbl.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
    lbl.textColor = [UIColor colorWithHexString:@"#cccccc"];
    lbl.textAlignment = NSTextAlignmentCenter;
    [cell addSubview:lbl];
    
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(cell.mas_centerX).offset(0);
        make.top.equalTo(imgView.mas_bottom).offset(15);
        make.width.equalTo(@200);
        make.height.equalTo(@15);
    }];
    
}
@end
