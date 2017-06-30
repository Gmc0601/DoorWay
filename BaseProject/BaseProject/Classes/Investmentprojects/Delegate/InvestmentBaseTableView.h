//
//  BaseTableView.h
//  BaseProject
//
//  Created by LeoGeng on 30/06/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebViewTableViewCell.h"

@protocol InvestmentBaseTableViewDelegate <NSObject>

-(void) didTapCompanyButton;
-(void) didTapRoleButton;
-(void) didTapSummryButton;
-(void) didTapCommentsButton;

@end

@interface InvestmentBaseTableView : NSObject<UITableViewDataSource,UITableViewDelegate,WebViewCellTableViewCellDelegate>

@property(weak,nonatomic) UITableView *owner;
@property(atomic,retain) NSString *cellIdentifier;
@property (weak, atomic) id<InvestmentBaseTableViewDelegate> delegate;

- (instancetype)initWithOwner:(UITableView *) owner withCellIdentifier:(NSString *) cellIdentifier;
-(UITableViewCell *) getCellInFirstSectionFromTableView:(UITableView *) tableView;
@end
