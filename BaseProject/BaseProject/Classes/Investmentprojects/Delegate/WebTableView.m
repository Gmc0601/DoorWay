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
        cell = [self getCellInFirstSectionFromTableView:tableView withHeaderImageUrl:self.headerImageUrl];
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
    CGFloat rowHeight = 0;
    if (indexPath.section == 0) {
        rowHeight =  156;
    }else{
        rowHeight = _heighOfWebView == 0 ? tableView.bounds.size.height - 264:_heighOfWebView;
    }
    
    return rowHeight;
}

-(void) WebViewTableViewCell:(WebViewTableViewCell *) cell heightOfCell:(CGFloat) heightOfCell{
        _heighOfWebView = heightOfCell;
        [self.owner beginUpdates];
        [self.owner endUpdates];
}
@end
