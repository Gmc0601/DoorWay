//
//  WebViewTableViewCell.h
//  BaseProject
//
//  Created by LeoGeng on 29/06/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WebViewTableViewCell;

@protocol WebViewCellTableViewCellDelegate <NSObject>

-(void) WebViewTableViewCell:(WebViewTableViewCell *)cell heightOfCell:(CGFloat) heightOfCell;

@end

@interface WebViewTableViewCell : UITableViewCell<UIWebViewDelegate>
@property (retain,atomic) NSString *url;
@property (nullable, nonatomic, assign) id <WebViewCellTableViewCellDelegate> delegate;
@end
