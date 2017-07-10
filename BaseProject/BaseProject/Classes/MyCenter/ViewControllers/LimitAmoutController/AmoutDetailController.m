//
//  AmoutDetailController.m
//  BaseProject
//
//  Created by lxl on 2017/7/2.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "AmoutDetailController.h"
#import "AmoutDetailCell.h"
@interface AmoutDetailController ()

@end

@implementation AmoutDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:self.str_title];

    // Do any additional setup after loading the view from its nib.
}
#pragma mark-UITableviewDelegate && UITableviewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        static NSString *CellIdentifier = @"AmoutDetailCell";
        AmoutDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = (AmoutDetailCell *)[[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:nil options:nil] firstObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor whiteColor];
            
        }
        return cell;
    
    
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
