//
//  UploadDeclarationController.m
//  BaseProject
//
//  Created by lxl on 2017/6/29.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "UploadDeclarationController.h"
#import "UploadTableViewCell.h"
#import "DeclarationModel.h"
#import "JHPickView.h"
@interface UploadDeclarationController ()<JHPickerDelegate,UITextFieldDelegate>
@property (nonatomic,strong) JHPickView   *datePicker;
@property (nonatomic,strong) JHPickView   *projectPicker;

@end

@implementation UploadDeclarationController

- (JHPickView *)projectPicker{
    if (!_projectPicker) {
        _projectPicker = [[JHPickView alloc]initWithFrame:self.view.bounds];
        _projectPicker.delegate = self ;
        _projectPicker.projectMarr =  [NSMutableArray  arrayWithObjects:@"证券1",@"证券1",@"证券1",@"证券1", nil] ;

        _projectPicker.arrayType = ProjectArray;
        
//        _projectPicker.arrayType = ProjectArray;
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        [keyWindow addSubview:_projectPicker];    }
    return _projectPicker;
}
- (JHPickView *)datePicker{
    if (!_datePicker) {
        _datePicker = [[JHPickView alloc]initWithFrame:self.view.bounds];
        _datePicker.delegate = self ;
        _datePicker.arrayType = DeteArray;
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        [keyWindow addSubview:_datePicker];    }
    return _datePicker;
}
- (IBAction)uploadDeclarationInfo:(id)sender {
}
- (void)setDeclarationModel{
    self.declarationMarr = [[NSMutableArray alloc]init];
    NSArray * arrTitle = [NSArray arrayWithObjects:@"保单项目",@"参与该项目用户名",@"报投时间",@"保投金额（元）", nil];
    __weak typeof(self) wkSelf = self;
    [arrTitle enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        DeclarationModel * model = [[DeclarationModel alloc]init];
        model.str_title = obj;
        [wkSelf.declarationMarr addObject:model];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTitle:@"提交报单"];

    self.warningLab.text = [NSString stringWithFormat:@"1.请正确填写报单项目信息，若填写错误信息，将无法享受平台的亏损保障；\n2.提交报单后，会有平台人员进行审核，审核通过报单生成"];
    [self setDeclarationModel];
}
#pragma mark-UITableviewDelegate && UITableviewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.declarationMarr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 == 0) {
        UploadTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        if (cell == nil) {
            cell = (UploadTableViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"UploadTableViewCell" owner:nil options:nil] firstObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor whiteColor];
            cell.detailText.delegate = self;

        }
        cell.detailText.tag = indexPath.row + 100;

        DeclarationModel * model = [self.declarationMarr objectAtIndex:indexPath.row];
        cell.titleLab.text = model.str_title;
        
        return cell;
    }else{
        UploadTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        if (cell == nil) {
            cell = (UploadTableViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"UploadTableViewCell" owner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor whiteColor];
            cell.detailText.delegate = self;
        }
        cell.detailText.tag = indexPath.row + 100;
        DeclarationModel * model = [self.declarationMarr objectAtIndex:indexPath.row];
        cell.titleLab.text = model.str_title;
        
        return cell;
    }
  
}

#pragma mark-UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.tag == 100) {
//        [self.datePicker showAnimation];
     
        [self.projectPicker showAnimation];
        return NO;
    }else if (textField.tag == 102){
        [self.datePicker showAnimation];
        return NO;
    }
    return YES;
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
