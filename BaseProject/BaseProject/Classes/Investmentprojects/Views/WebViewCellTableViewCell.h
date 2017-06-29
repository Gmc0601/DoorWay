//
//  WebViewCellTableViewCell.h
//  BaseProject
//
//  Created by LeoGeng on 29/06/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WebViewCellTableViewCell;

@protocol WebViewCellTableViewCellDelegate <NSObject>

-(void) WebViewCellTableViewCell:(WebViewCellTableViewCell *)cell heightOfCell:(CGFloat) heightOfCell;

@end

@interface WebViewCellTableViewCell : UITableViewCell<UIWebViewDelegate>
@property (retain,atomic) NSString *url;
@property (nullable, nonatomic, assign) id <WebViewCellTableViewCellDelegate> delegate;
@end
