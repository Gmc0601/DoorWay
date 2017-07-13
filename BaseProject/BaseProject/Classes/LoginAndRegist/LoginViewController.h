//
//  LoginViewController.h
//  BaseProject
//
//  Created by cc on 2017/6/26.
//  Copyright © 2017年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    Login_Present,
    Login_Navigation,
}ToLoginType;
// 默认取消方式是dissmiss   如过navigation 调入 请设施loginType 属性 
@interface LoginViewController : UIViewController
@property (nonatomic, assign) ToLoginType loginType;
@end
