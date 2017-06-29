//
//  UploadDeclarationController.h
//  BaseProject
//
//  Created by lxl on 2017/6/29.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "BaseViewController.h"

@interface UploadDeclarationController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *warningLab;
@property (weak, nonatomic) IBOutlet UITableView *uploadTab;

@property (strong, nonatomic)   NSMutableArray * declarationMarr;
@end
