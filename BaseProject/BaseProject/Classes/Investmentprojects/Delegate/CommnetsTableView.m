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
#import "CommentCell.h"
#import "NSString+Category.h"

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
        if(self.dataSource.count > 0){
            if (indexPath.row <(self.dataSource.count)) {
                cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
                ((CommentCell *)cell).model = self.dataSource[indexPath.row];
            }else{
                 cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
                
                for (UIView *v in cell.subviews) {
                    [v removeFromSuperview];
                }
            }
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

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
            return self.dataSource.count + 1;
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0;
    if (indexPath.section == 0) {
        height = 156;
    }else{
        if (self.dataSource == nil || self.dataSource.count == 0) {
            if(indexPath.row == 0){
                height = tableView.frame.size.height - 310;
            }else{
                height = 48;
            }
        }else{
            
            if (indexPath.row == (self.dataSource.count)) {
                height = 48;
            }else{
                CommentModel *model = dataSource[indexPath.row];
                height =  [self heightOfCell:tableView withComment:model.comment];
                
            }
        }
    }
    
    return height;
}

-(CGFloat) heightOfCell:(UITableView *) tableView withComment:(NSString *) text{
    CGFloat height =  65 + [text heightWithFontSize:11 width:tableView.bounds.size.width - 20];
    return  height;
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
