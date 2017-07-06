//
//  InverstInfoViewController.h
//  BaseProject
//
//  Created by LeoGeng on 29/06/2017.
//  Copyright © 2017 cc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InvestmentInfoView.h"
#import "InvestmentModel.h"

@interface InverstInfoViewController : UIViewController
- (instancetype)initWithModel:(InvestmentModel *) model;
@end
