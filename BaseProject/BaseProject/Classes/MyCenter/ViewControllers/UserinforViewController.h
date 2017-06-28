//
//  UserinforViewController.h
//  BaseProject
//
//  Created by li on 2017/6/28.
//  Copyright © 2017年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserinforViewController : UIViewController{
    UIImageView  *imageView;
    UITapGestureRecognizer *IMage; //头像
    UITapGestureRecognizer *IMageOne;//个人资料
}

//返回按钮
@property(nonatomic,strong)UIButton *returnBack;
//存储文本数组
@property(nonatomic,strong)NSArray *setIMageArray;

@end
