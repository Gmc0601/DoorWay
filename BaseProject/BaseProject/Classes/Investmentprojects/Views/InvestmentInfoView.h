//
//  InvestmentInfoView1.h
//  BaseProject
//
//  Created by LeoGeng on 29/06/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewTableViewCell.h"
#import "InvestmentModel.h"

@interface InvestmentInfoView : UIView
- (instancetype)initWithFrame:(CGRect)frame withModel:(InvestmentModel *) model;
@end
