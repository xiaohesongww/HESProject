//
//  SloganSettingViewController.m
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "SloganSettingViewController.h"

@interface SloganSettingViewController ()
@property (weak, nonatomic) IBOutlet UITextField *sloganTextField;

@end

@implementation SloganSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"UserResource.plist"];
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    self.sloganTextField.text = dataDic[@"slogan"];
    [self.sloganTextField becomeFirstResponder];
    // Do any additional setup after loading the view from its nib.
}


#pragma mark -- setNav
- (void)setNav {
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem barButtonItemWithTitle:@"确认" Font:14 TextColor:[UIColor whiteColor] target:self action:@selector(addSlogan:)];
}

//添加口号
- (void)addSlogan:(UIButton *)sender {
    if (self.sloganTextField.text.length) {
        if (self.sloganTextField.text.length > 15) {
            [self showTitle:@"口号最多设置15个字"];
        } else {
            [self storeSlogan];
        }
    } else {
        [self showTitle:@"请先输入口号"];
    }
}


//存储口号
- (void)storeSlogan {
    
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"UserResource.plist"];
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] init];
    //写入
    [dataDic setObject:self.sloganTextField.text forKey:@"slogan"];
    [dataDic writeToFile:filename atomically:YES];
    [self.view endEditing:YES];
    [self showTitle:@"保存成功!"];
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
