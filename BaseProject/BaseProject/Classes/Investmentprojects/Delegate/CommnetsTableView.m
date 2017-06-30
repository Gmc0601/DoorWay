//
//  CommnetsTableView.m
//  BaseProject
//
//  Created by LeoGeng on 30/06/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "CommnetsTableView.h"

@implementation CommnetsTableView
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
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.backgroundView = [[UIView alloc] init];
        cell.backgroundView.backgroundColor = [UIColor redColor];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
        
        
        
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
@end
