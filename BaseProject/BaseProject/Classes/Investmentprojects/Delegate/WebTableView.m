//
//  WebTableView.m
//  BaseProject
//
//  Created by LeoGeng on 30/06/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import "WebTableView.h"


@interface WebTableView()
@property(nonatomic,assign) CGFloat heighOfWebView;
@end

@implementation WebTableView
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
        cell = [self getCellInFirstSectionFromTableView:tableView];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
        ((WebViewTableViewCell *) cell).delegate = self;
        [((WebViewTableViewCell *) cell) setUrl:self.strUrl];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 156;
    }else{
        CGFloat height = _heighOfWebView == 0 ? tableView.bounds.size.height - 220:_heighOfWebView;
        return height;
    }
    
    return 0;
}

-(void) WebViewTableViewCell:(WebViewTableViewCell *) cell heightOfCell:(CGFloat) heightOfCell{
        _heighOfWebView = heightOfCell;
        [self.owner beginUpdates];
        [self.owner endUpdates];
}
@end
