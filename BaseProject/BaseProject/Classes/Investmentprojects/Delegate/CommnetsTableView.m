//
//  CommnetsTableView.m
//  BaseProject
//
//  Created by LeoGeng on 30/06/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "CommnetsTableView.h"

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
        
        if(indexPath.row == 1){
            cell.backgroundColor = [UIColor blueColor];
        }else{
            cell.backgroundColor = [UIColor redColor];
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
@end
