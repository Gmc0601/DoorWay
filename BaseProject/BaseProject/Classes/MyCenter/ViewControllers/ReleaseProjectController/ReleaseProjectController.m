//
//  ReleaseProjectController.m
//  BaseProject
//
//  Created by lxl on 2017/7/1.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "ReleaseProjectController.h"
#import "DeclarationView.h"
#import "Masonry.h"

#define TextViewPlaceHolder  @"请输入项目简介"
#define PlaceColor RGB(204, 204, 204)
@interface ReleaseProjectController ()
@property (nonatomic,strong)DeclarationView * declaraView;
@end

@implementation ReleaseProjectController
- (void)cancleRelease{
    [self agreeRelease];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)agreeRelease{
    [self.declaraView removeFromSuperview];
    self.declaraView = nil;
}
- (DeclarationView *)declaraView{
    if ((!_declaraView)) {
        _declaraView = [[[NSBundle mainBundle] loadNibNamed:@"DeclarationView" owner:self options:nil] lastObject];
        [_declaraView.cancleBtn addTarget:self action:@selector(cancleRelease) forControlEvents:UIControlEventTouchUpInside];
        [_declaraView.sureBtn addTarget:self action:@selector(agreeRelease) forControlEvents:UIControlEventTouchUpInside];

    }
    return _declaraView;
}
- (IBAction)uploadProject:(id)sender {
}
- (void)setReleasePartUI{
    [self setNavTitle:@"发起项目"];
    self.detailTextView.textColor = PlaceColor;//设置提示内容颜色
    self.detailTextView.text      = TextViewPlaceHolder;//提示语
    self.detailTextView.selectedRange=NSMakeRange(0,0) ;//光标起始位置
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self.declaraView];
    [_declaraView  mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setReleasePartUI];

}
#pragma mark-UITextViewDelegate
- (void)textViewDidChangeSelection:(UITextView *)textView{
    if([PublicClass firstColor:textView.textColor secondColor:PlaceColor]){//如果是提示内容，光标放置开始位置
        NSRange range;
        range.location = 0;
        range.length = 0;
        textView.selectedRange = range;
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text{
    if (![text isEqualToString:@""] && [PublicClass firstColor:textView.textColor secondColor:PlaceColor]){//如果不是delete响应,当前是提示信息，修改其属性
        textView.text=@"";//置空
        textView.textColor=[UIColor blackColor];
    }
    
    
    if ([text isEqualToString:@"\n"]){//回车事件
        if ([textView.text isEqualToString:@""]){//如果直接回车，显示提示内容
            textView.textColor = PlaceColor;
            textView.text      = TextViewPlaceHolder;
        }
        [textView resignFirstResponder];//隐藏键盘
        return NO;
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView{
    if ([textView.text isEqualToString:@""]){
        textView.textColor = PlaceColor;
        textView.text      = TextViewPlaceHolder;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
