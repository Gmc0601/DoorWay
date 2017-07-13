//
//  transferVC.h
//  BaseProject
//
//  Created by 李超杰 on 17/7/5.
//  Copyright © 2017年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol transferDeledata <NSObject>

-(void)transferMoney:(NSString *)money;

@end
@interface transferVC : UIViewController

@property(nonatomic,strong)NSString *money;

@property(nonatomic,strong)id<transferDeledata>delegate;
@end
