//
//  LoginViewController.h
//  BaseProject
//
//  Created by cc on 2017/6/26.
//  Copyright © 2017年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    Login_Navigation,
    Login_Present,
}ToLoginType;

@interface LoginViewController : UIViewController
@property (nonatomic, assign) ToLoginType loginType;
@end
