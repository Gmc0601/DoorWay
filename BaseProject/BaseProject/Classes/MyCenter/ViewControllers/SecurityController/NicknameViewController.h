//
//  NicknameViewController.h
//  BaseProject
//
//  Created by li on 2017/6/29.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "BaseViewController.h"

@interface NicknameViewController : BaseViewController

@property(nonatomic,strong)UITextField *setIMageFiled;

@property(nonatomic,strong)UIImageView *IMageLine;

@property(nonatomic,strong)UIButton  *saveButton;

@property (nonatomic, copy) void (^selectedinfoString)(NSString *infoString);

@end
