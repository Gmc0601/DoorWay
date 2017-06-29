//
//  DeclarationViewController.m
//  BaseProject
//
//  Created by lxl on 2017/6/28.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "DeclarationViewController.h"
#import "DeclarationTableViewCell.h"
#import "UploadDeclarationController.h"
@interface DeclarationViewController ()

@end

@implementation DeclarationViewController
- (IBAction)buttonClick:(id)sender {
    for (UIView * v in self.typeView.subviews) {
        if ([v isKindOfClass:[UIButton class]]) {
            UIButton * btn = (UIButton *)v;
            if ([btn isKindOfClass:[UIButton class]]) {
                btn.selected = NO;
            }
        }
    }
    UIButton * btn = (UIButton *)sender;
    btn.selected = YES;
    [UIView animateWithDuration:.4 animations:^{
        CGRect rect = self.lineView.frame;
        rect.origin.x = btn.frame.origin.x + 5;
        self.lineView.frame = rect;
        
    } completion:^(BOOL finished) {
        
    }];
    
}
- (void)setLineViewFrame{
    CGFloat width = kScreenW/4;
    CGRect rect = self.lineView.frame;
    rect.size.width = width - 10;
    rect.origin.x =  5;
    self.lineView.frame = rect;
}
- (void)uploadDeclaration{
    UploadDeclarationController * upload = [[UploadDeclarationController alloc]init];
    [self.navigationController pushViewController:upload animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.translucent = NO;
    [self setNavTitle:@"互助报单"];
    [PublicClass setRightTitleOnTargetNav:self action:@selector(uploadDeclaration) Title:@"提交报单"];
    [self setLineViewFrame];
}
#pragma mark-UITableviewDelegate && UITableviewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"DeclarationTableViewCell";
    DeclarationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (DeclarationTableViewCell *)[[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
        
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
