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


#import "KeychainUUID.h"
#import "UIImageView+WebCache.h"

@interface UserinforViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>

{
    UILabel *setLableNumber;
}
@end

@implementation UserinforViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setCustomerTitle:@"个人资料"];
    [self getUserInfo];
    self.view.backgroundColor = UIColorFromHex(0xf0f0f0);
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_fh_b"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickPersonBackBtn)];

    
    [self saveButton];
    
    [self  setIMageMain];
}


- (void)getUserInfo{
    
    [HttpRequest postPath:@"_userprofile_001" params:nil resultBlock:^(id responseObject, NSError *error) {
        
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        
        NSDictionary *datadic = responseObject[@"info"];
        
           NSLog(@"login>>>>>>%@", datadic);
        
        if ([datadic[@"error"] intValue] == 0) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:datadic[@"avatar_url"]] placeholderImage:[UIImage imageNamed:@"默认头像"]];
            setLable.text = datadic[@"nickname"];
            setLableNumber.text = datadic[@"mobile"];
            
        }else {
            NSString *info = datadic[@"info"];
            [ConfigModel mbProgressHUD:info andView:nil];
        }
        NSLog(@"error>>>>%@", error);
    }];

    
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



- (void)clickPersonBackBtn{
    [self.navigationController popViewControllerAnimated:YES];
}


/*
 *个人资料
 */
-(void)setIMageMain{
    
    self.setIMageArray=@[@"头像",@"昵称",@"手机号"];
    
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
//            setLable.text=@"狗篮子项目啊";
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
            setLableNumber=[[UILabel alloc]init];
            setLableNumber.backgroundColor=[UIColor clearColor];
//            setLableNumber.text=@"1851822539";
            setLableNumber.textColor = UIColorFromHex(0x333333);
            setLableNumber.font = HelveticaNeueFont(16*SCALE);
            setLableNumber.textAlignment = NSTextAlignmentRight;
            [self.view addSubview:setLableNumber];
            [setLableNumber mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-20*SCALE);
                make.top.mas_equalTo(150*SCALE);
                make.height.mas_equalTo(30*SCALE);
                make.width.mas_equalTo(100*SCALE);
                
                UIButton *outBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                outBtn.frame = CGRectMake(60, 250, kScreenW-120, 40);
                [outBtn setTitle:@"退出登录" forState:UIControlStateNormal];
                [outBtn addTarget:self action:@selector(goOutBtn) forControlEvents:UIControlEventTouchUpInside];
                outBtn.backgroundColor = RGB(57, 116, 238);
                [self.view addSubview:outBtn];
            }];
        }
    }
}


-(void)goOutBtn{
    
    NSString *userTokenStr = [ConfigModel getStringforKey:UserToken];
    NSMutableDictionary *mudic = [NSMutableDictionary new];
    //        [mudic setObject:userTokenStr forKey:@"userToken"];
    KeychainUUID *keychain = [[KeychainUUID alloc] init];
    id data = [keychain readUDID];
    NSString *udidStr = data;
    //        [mudic setObject:udidStr forKey:@"device_number"];
    [HttpRequest postPath:@"_logout_001" params:mudic resultBlock:^(id responseObject, NSError *error) {
        
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        
        NSLog(@"%@login>>>>>>",responseObject);
        
        NSDictionary *datadic = responseObject;
        if ([datadic[@"error"] intValue] == 0) {
            
            NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
            [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
            [ConfigModel mbProgressHUD:@"退出成功" andView:nil];
            
        }else {
            NSString *info = datadic[@"info"];
            [ConfigModel mbProgressHUD:info andView:nil];
        }
        NSLog(@"error>>>>%@", error);
    }];


    
    
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
    
    
    UIActionSheet *pictureSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"用户相册", nil];
    pictureSheet.tag = 11;
    pictureSheet.delegate=self;
    [pictureSheet showInView:self.view];
    
//    //调用系统相册的类
//    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
//    //设置选取的照片是否可编辑
//    pickerController.allowsEditing = NO;
//    //设置相册呈现的样式
//    pickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;//图片分组列表样式
//    //照片的选取样式还有以下两种
//    //UIImagePickerControllerSourceTypePhotoLibrary,直接全部呈现系统相册
//    //UIImagePickerControllerSourceTypeCamera//调取摄像头
//    //选择完成图片或者点击取消按钮都是通过代理来操作我们所需要的逻辑过程
//    pickerController.delegate = self;
//    //使用模态呈现相册
//    [self.navigationController presentViewController:pickerController animated:YES completion:^{
//    }];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 11) {
        NSString *alertTitle = nil;
        if (buttonIndex == 0)
            alertTitle = @"拍照";
        else if(buttonIndex == 1)
            alertTitle = @"用户相册";
        
        if (buttonIndex == 0) {
            if ([UIImagePickerController  isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ) {
                
                UIImagePickerController * imagePickerC = [[UIImagePickerController alloc] init];
                imagePickerC.sourceType = UIImagePickerControllerSourceTypeCamera;
                imagePickerC.delegate = self;
                imagePickerC.allowsEditing = YES;
               [self.navigationController presentViewController:imagePickerC animated:YES completion:^{}];
    
            }
            else
            {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该设备没有照相机" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            
            }
        }else
        {
            UIImagePickerController * imagePickerC = [[UIImagePickerController alloc] init];
            imagePickerC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePickerC.delegate = self;
            imagePickerC.allowsEditing = NO;
            imagePickerC.allowsEditing = YES;
            [self.navigationController presentViewController:imagePickerC animated:YES completion:^{}];
            
        }
        
    }
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
    oneImgViewData=UIImageJPEGRepresentation(imageView.image,0.8);
    oneImgViewData = [oneImgViewData base64EncodedDataWithOptions:0];
    
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
    
    NSString * tmpOneImgViewString = [[NSString alloc] initWithData:oneImgViewData  encoding:NSUTF8StringEncoding];
    NSString *userTokenStr = [ConfigModel getStringforKey:UserToken];
    NSMutableDictionary *infoDic=[NSMutableDictionary dictionary];
    [infoDic setObject:setLable.text forKey:@"nickname"];
    [infoDic setObject:tmpOneImgViewString forKey:@"avatar_url"];
    [infoDic setObject:userTokenStr forKey:@"userToken"];
    [HttpRequest postPath:@"_update_userinfo_001" params:infoDic resultBlock:^(id responseObject, NSError *error){
        
        NSLog(@" %@",responseObject);
        
    }];
    
}


//查询方法

-(void)opeationData{
    
}



@end
