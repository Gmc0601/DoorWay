//
//  InvestmentInfoView1.h
//  BaseProject
//
//  Created by LeoGeng on 29/06/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InvestmentBaseTableView.h"
#import "InvestmentModel.h"

@protocol InvestmentInfoViewDelegate <NSObject>

-(void) gotoLoginViewController;

@end
@interface InvestmentInfoView : UIView<InvestmentBaseTableViewDelegate,UITextViewDelegate>
@property(weak,atomic) id<InvestmentInfoViewDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame withModel:(InvestmentModel *) model;
@end
