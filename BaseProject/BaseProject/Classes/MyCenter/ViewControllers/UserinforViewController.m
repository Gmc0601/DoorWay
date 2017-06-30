//
//  UserinforViewController.m
//  BaseProject
//
//  Created by li on 2017/6/28.
//  Copyright © 2017年 cc. All rights reserved.
//
#import "Masonry.h"
#import "UserinforViewController.h"
#import "SecurityViewController.h"
#import "NicknameViewController.h"

@interface UserinforViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation UserinforViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setCustomerTitle:@"个人资料"];
    
    self.view.backgroundColor = UIColorFromHex(0xf0f0f0);
    
    self.navigationController.navigationBar.translucent = NO;
    
    [self saveButton];
    
    [self  setIMageMain];
}

-(UIButton *)saveButton{
    if (!_saveButton) {
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveButton.frame = CGRectMake((kScreenW-80)*SCALE,(88-60)/2/2*SCALE,60*SCALE,44/2*SCALE);
        [_saveButton setTitle:@"保存" forState:UIControlStateNormal];
        [_saveButton addTarget:self action:@selector(saveBtn:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:_saveButton];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    return _saveButton;
}




/*
 *个人资料
 */
-(void)setIMageMain{
    
    self.setIMageArray=@[@"头像",@"昵称",@"手机号",@"激活账号",@"激活账号"];
    
    for (int i=0; i<self.setIMageArray.count; i++){
        
        UIView *bgView = [[UIView alloc]init];
        if (i==0){
             bgView.frame = CGRectMake(0,0*SCALE+(90/2*SCALE+30/2*SCALE)*i,kScreenW,180/2*SCALE);
        }else{
           bgView.frame = CGRectMake(0,80/2*SCALE+(90/2*SCALE+10/2*SCALE)*i,kScreenW,100/2*SCALE);
        }
        bgView.backgroundColor =UIColorFromHex(0xf0f0f0);
        bgView.tag = i;
        bgView.userInteractionEnabled = YES;
        [self.view addSubview:bgView];
        
        //下边线
        UIView *bgDownXianView = [[UIView alloc]init];
        if (i==0) {
           bgDownXianView.frame = CGRectMake(0,180/2*SCALE-1.0/2*SCALE, kScreenW, 1.0/2*SCALE);
        }else{
            bgDownXianView.frame = CGRectMake(0,100/2*SCALE-1.0/2*SCALE, kScreenW, 1.0/2*SCALE);
        }
        bgDownXianView.backgroundColor = UIColorFromHex(0xd7d7d7);
        [bgView addSubview:bgDownXianView];
        
        //数组值放进去
        UILabel *titleLable = [[UILabel alloc]init];
        if (i==0) {
             titleLable.frame = CGRectMake(40/2*SCALE,0,50/2*SCALE*5,170/2*SCALE);
        }else{
             titleLable.frame = CGRectMake(40/2*SCALE,0,60/2*SCALE*5,100/2*SCALE);
        }
        titleLable.text = self.setIMageArray[i];
        titleLable.textColor = UIColorFromHex(0x333333);
        titleLable.font = HelveticaNeueFont(16*SCALE);
        titleLable.textAlignment = NSTextAlignmentLeft;
        [bgView addSubview:titleLable];
        
        if (i==0){
            imageView=[[UIImageView alloc]init];
            imageView.image=[UIImage imageNamed:@"默认头像"];
            imageView.userInteractionEnabled=YES;
            imageView.frame= CGRectMake(kScreenW-(100*SCALE),42.5/2*SCALE,(96/2)*SCALE,(96/2)*SCALE);
            [self.view addSubview:imageView];
            
            UIImageView   *IMageAllow=[[UIImageView alloc]init];
            IMageAllow.image=[UIImage imageNamed:@"icon_gd"];
            IMageAllow.userInteractionEnabled=YES;
            IMageAllow.frame= CGRectMake(kScreenW-(20*SCALE),80/2*SCALE,13/2,26/2);
            [self.view addSubview:IMageAllow];
            
            IMage=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageSender:)];
            IMage.numberOfTapsRequired = 1; // 单击
            [imageView addGestureRecognizer:IMage];
        }
        
        if (i==1){
            UIImageView   *IMageAllowOne=[[UIImageView alloc]init];
            IMageAllowOne.image=[UIImage imageNamed:@"icon_gd"];
            IMageAllowOne.userInteractionEnabled=YES;
            IMageAllowOne.frame= CGRectMake(kScreenW-20,110*SCALE,13/2,26/2);;
            [self.view addSubview:IMageAllowOne];
            
            setLable=[[UILabel alloc]init];
            setLable.backgroundColor=[UIColor clearColor];
            setLable.text=@"狗篮子项目啊";
            setLable.textColor = UIColorFromHex(0x333333);
            setLable.font = HelveticaNeueFont(16*SCALE);
            setLable.userInteractionEnabled=YES;
            setLable.textAlignment = NSTextAlignmentRight;
            [self.view addSubview:setLable];
            [setLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(IMageAllowOne.mas_left).offset(-10*SCALE);
                make.top.mas_equalTo(100*SCALE);
                make.height.mas_equalTo(30*SCALE);
                make.width.mas_equalTo(100*SCALE);
            }];
            IMageOne=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageOne:)];
            IMageOne.numberOfTapsRequired = 1; // 单击
            [setLable addGestureRecognizer:IMageOne];
        }
        
        if (i==2){
            UILabel *setLableNumber=[[UILabel alloc]init];
            setLableNumber.backgroundColor=[UIColor clearColor];
            setLableNumber.text=@"1851822539";
            setLableNumber.textColor = UIColorFromHex(0x333333);
            setLableNumber.font = HelveticaNeueFont(16*SCALE);
            setLableNumber.textAlignment = NSTextAlignmentRight;
            [self.view addSubview:setLableNumber];
            [setLableNumber mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-20*SCALE);
                make.top.mas_equalTo(150*SCALE);
                make.height.mas_equalTo(30*SCALE);
                make.width.mas_equalTo(100*SCALE);
            }];
        }
        
        if (i==3) {
            UIImageView   *IMageAllowTwo=[[UIImageView alloc]init];
            IMageAllowTwo.image=[UIImage imageNamed:@"icon_gd"];
            IMageAllowTwo.userInteractionEnabled=YES;
            IMageAllowTwo.frame= CGRectMake(kScreenW-20,210*SCALE,13/2,26/2);
            [self.view addSubview:IMageAllowTwo];
            IMageRose=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imagetwo:)];
            IMageRose.numberOfTapsRequired = 1; // 单击
            [IMageAllowTwo addGestureRecognizer:IMageRose];
        }
        
        if (i==4) {
            UILabel *setLablePhone=[[UILabel alloc]init];
            setLablePhone.backgroundColor=[UIColor clearColor];
            setLablePhone.text=@"未激活";
            setLablePhone.textColor = UIColorFromHex(0x333333);
            setLablePhone.font = HelveticaNeueFont(16*SCALE);
            setLablePhone.textAlignment = NSTextAlignmentRight;
            [self.view addSubview:setLablePhone];
            [setLablePhone mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-20*SCALE);
                make.top.mas_equalTo(250*SCALE);
                make.height.mas_equalTo(30*SCALE);
                make.width.mas_equalTo(100*SCALE);
            }];
        }
    }
}


//激活账号

-(void)imagetwo:(UITapGestureRecognizer*)recognizer{
    SecurityViewController *Security=[[SecurityViewController alloc]init];
    [self.navigationController pushViewController:Security animated:YES];
}

//昵称
-(void)imageOne:(UITapGestureRecognizer*)recognizer{
    
    NicknameViewController *Nickname=[[NicknameViewController alloc]init];
    Nickname.selectedinfoString=^(NSString *name){
        setLable.text=name;
    };
    [self.navigationController pushViewController:Nickname animated:YES];

}


//头像
-(void)imageSender:(UITapGestureRecognizer*)recognizer{
    
    //调用系统相册的类
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
    //设置选取的照片是否可编辑
    pickerController.allowsEditing = NO;
    //设置相册呈现的样式
    pickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;//图片分组列表样式
    //照片的选取样式还有以下两种
    //UIImagePickerControllerSourceTypePhotoLibrary,直接全部呈现系统相册
    //UIImagePickerControllerSourceTypeCamera//调取摄像头
    //选择完成图片或者点击取消按钮都是通过代理来操作我们所需要的逻辑过程
    pickerController.delegate = self;
    //使用模态呈现相册
    [self.navigationController presentViewController:pickerController animated:YES completion:^{
    }];
}

//选择照片完成之后的代理方法

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //info是所选择照片的信息
    //    UIImagePickerControllerEditedImage//编辑过的图片
    //    UIImagePickerControllerOriginalImage//原图
    NSLog(@"%@",info);
    //刚才已经看了info中的键值对，可以从info中取出一个UIImage对象，将取出的对象赋给按钮的image
    
    //     UIImage *resultImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    //     [self.imageArray addObject:resultImage];
    UIImage *resultImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    imageView.image=resultImage;
    
    //
    //    //如果按钮创建时用的是系统风格UIButtonTypeSystem，需要在设置图片一栏设置渲染模式为"使用原图"
    //        //裁成边角
    //    }else
    //    {
    //        UIImage *resultImage1 = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    //        self.twoIMageBtn.image=resultImage1;
    //    }
    //
    
    //    button.layer.cornerRadius = 100;
    //    button.layer.masksToBounds = YES;
    //使用模态返回到软件界面
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
    
    }];
}

//点击取消按钮所执行的方法

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    //这是捕获点击右上角cancel按钮所触发的事件，如果我们需要在点击cancel按钮的时候做一些其他逻辑操作。就需要实现该代理方法，如果不做任何逻辑操作，就可以不实现
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

//提交保存方法
-(void)saveBtn:(UIButton*)sender{
    
    NSMutableDictionary *infoDic=[NSMutableDictionary dictionary];
   
    [HttpRequest postPath:@"" params:infoDic resultBlock:^(id responseObject, NSError *error){
        
    }];
    
}



@end
