//
//  ModifyNicknameViewController.m
//  huiErShi-iOS
//
//  Created by 纪辰 on 2017/2/18.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "ModifyNicknameViewController.h"

@interface ModifyNicknameViewController ()
@property (nonatomic, strong) UITextField *modifyNicknameTextField;
@end

@implementation ModifyNicknameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改昵称";
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 25)];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(rightBarButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.view.backgroundColor = HESCOLOR_THEME;
    
    [self setupUI];
}

- (void)setupUI {
    self.modifyNicknameTextField = [[UITextField alloc] init];
    self.modifyNicknameTextField.backgroundColor = [UIColor whiteColor];
    self.modifyNicknameTextField.placeholder = @"昵称长度最长16个字";
    self.modifyNicknameTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LayOutW(20), 0)];
    self.modifyNicknameTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.modifyNicknameTextField];
    self.modifyNicknameTextField.sd_layout.rightEqualToView(self.view).topSpaceToView(self.view, LayOutH(20)).rightEqualToView(self.view).heightIs(LayOutH(88));
}

- (void)rightBarButtonPressed:(UIButton *)sender {
    if (self.modifyNicknameTextField.text.length == 0) {
         [self.navigationController popViewControllerAnimated:YES];
    } else {
        if (self.setName) {
            self.setName(self.modifyNicknameTextField.text);
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:self.modifyNicknameTextField.text forKey:@"nickname"];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
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
