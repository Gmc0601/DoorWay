//
//  AllReleaseProjectController.m
//  BaseProject
//
//  Created by lxl on 2017/7/2.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "AllReleaseProjectController.h"
#import "ReleaseProjetCell.h"
#import "ReleaseProjectController.h"
#import "ProjectDetailController.h"
@interface AllReleaseProjectController ()

@end

@implementation AllReleaseProjectController
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
- (void)releaseProject{
    ReleaseProjectController * release = [[ReleaseProjectController alloc]init];
    [self.navigationController pushViewController:release animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTitle:@"发布项目+"];
    [self setLineViewFrame];
    self.releaseTab.estimatedRowHeight = 167;
    self.releaseTab.rowHeight = UITableViewAutomaticDimension;
    [PublicClass setRightTitleOnTargetNav:self action:@selector(releaseProject) Title:@"发布项目"];
}
#pragma mark-UITableviewDelegate && UITableviewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row%2 == 0){
        static NSString *CellIdentifier = @"ReleaseProjetCell";
        ReleaseProjetCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = (ReleaseProjetCell *)[[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:nil options:nil] firstObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor whiteColor];
            
        }
        return cell;
    }else{
        static NSString *CellIdentifier = @"ReleaseProjetCell1";
        ReleaseProjetCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = (ReleaseProjetCell *)[[[NSBundle mainBundle] loadNibNamed:@"ReleaseProjetCell" owner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor whiteColor];
        }
        cell.rejectReasonLab.text = @"南方圣诞节你发撒带你飞撒南方圣诞节你发撒带你飞撒南方圣诞节你发撒带你飞撒南方圣诞节你发撒带你飞撒南方圣诞节你发撒带你飞撒南方圣诞节你发撒带你飞撒南方圣诞节你发撒带你飞撒的空间发圣诞节开发技术大房间里撒打飞机撒旦就";
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ProjectDetailController * detail = [[ProjectDetailController alloc]init];
    [self.navigationController pushViewController:detail animated:YES];
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
