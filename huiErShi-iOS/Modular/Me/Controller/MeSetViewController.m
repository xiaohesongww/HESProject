//
//  MeSetViewController.m
//  huiErShi-iOS
//
//  Created by wanjianIOSMacMini on 2017/2/10.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "MeSetViewController.h"
#import "ProjectSettingViewController.h"
#import "OwnPhotoViewController.h"

@interface MeSetViewController () <UITableViewDelegate, UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) UITableView *settingTableView;
@end

@implementation MeSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"设置";
    [self setupUI];
}

- (void)setupUI {
    self.view.backgroundColor = HESCOLOR_THEME;
    UITableView *setTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.settingTableView = setTableView;
    self.settingTableView.delegate = self;
    self.settingTableView.dataSource = self;
    
    [self.view addSubview:self.settingTableView];
    
    self.settingTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, LayOutH(316) + 10)];
    
    UIButton *loginoutButton = [[UIButton alloc] init];
    [loginoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [loginoutButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.settingTableView.tableFooterView addSubview:loginoutButton];
    loginoutButton.sd_layout.leftEqualToView(self.view).topSpaceToView(self.settingTableView.tableFooterView, LayOutH(40)).rightEqualToView(self.view).heightIs(LayOutH(self.settingTableView.rowHeight));
    
    UILabel *tipsLabel = [[UILabel alloc] init];
    tipsLabel.text = @"惠尔仕软件许可即服务协议";
    tipsLabel.textColor = HESCOLOR(245, 47, 26);
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    tipsLabel.font = [UIFont systemFontOfSize:11.0f];
    [self.settingTableView.tableFooterView addSubview:tipsLabel];
    tipsLabel.sd_layout.leftEqualToView(self.settingTableView.tableFooterView).rightEqualToView(self.settingTableView.tableFooterView).heightIs(LayOutH(26)).topSpaceToView(loginoutButton, LayOutH(60));
}

#pragma mark - tableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"id"];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"日程背景图";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"项目设置";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"接受活动报告";
        UISwitch *switchView = [[UISwitch alloc] init];
        [switchView setOn:YES];
        cell.accessoryView = switchView;
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"清除缓存";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if (indexPath.row == 4) {
        cell.textLabel.text = @"版本号";
        cell.detailTextLabel.text = @"v1.0.0";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self alertScheduleBackgroundImage];
    } else if (indexPath.row == 1) {
        ProjectSettingViewController *projectSettingViewController = [[ProjectSettingViewController alloc] init];
        [self.navigationController pushViewController:projectSettingViewController animated:YES];
    } else if (indexPath.row == 3) {
        [self alertCleanCache];
    }
}

- (void)alertScheduleBackgroundImage {
    /**
     *  弹出提示框
     */
    //初始化提示框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //按钮：，类型：UIAlertActionStyleDefault
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"惠尔仕相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        OwnPhotoViewController *photoVc = [[OwnPhotoViewController alloc] init];
        [self.navigationController pushViewController:photoVc animated:YES];
    }];
    
    //按钮：，类型：UIAlertActionStyleDefault
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        /**
         其实和从相册选择一样，只是获取方式不同，前面是通过相册，而现在，我们要通过相机的方式
         */
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        //获取方式:通过相机
        PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
        PickerImage.allowsEditing = YES;
        PickerImage.delegate = self;
        [self presentViewController:PickerImage animated:YES completion:nil];

    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"从本地选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        //初始化UIImagePickerController
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        //获取方式1：通过相册（呈现全部相册），UIImagePickerControllerSourceTypePhotoLibrary
        //获取方式2，通过相机，UIImagePickerControllerSourceTypeCamera
        //获取方法3，通过相册（呈现全部图片），UIImagePickerControllerSourceTypeSavedPhotosAlbum
        PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //允许编辑，即放大裁剪
        PickerImage.allowsEditing = YES;
        //自代理
        PickerImage.delegate = self;
        //页面跳转
        [self presentViewController:PickerImage animated:YES completion:nil];
    }];
    //按钮：取消，类型：UIAlertActionStyleCancel
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    [alert addAction:action4];
    [action1 setValue:HESHEXCOLOR(@"00a652") forKey:@"titleTextColor"];
    [action2 setValue:HESHEXCOLOR(@"00a652") forKey:@"titleTextColor"];
    [action3 setValue:HESHEXCOLOR(@"00a652") forKey:@"titleTextColor"];
    [action4 setValue:HESHEXCOLOR(@"00a652") forKey:@"titleTextColor"];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)alertCleanCache {
    /**
     *  弹出提示框
     */
    //初始化提示框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //按钮：，类型：UIAlertActionStyleDefault
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定清空本地数据?" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    //按钮：，类型：UIAlertActionStyleDefault
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"清空本地缓存数据" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        
    }];
    
//    [alert addAction:action1];
    [alert addAction:action2];
    [action2 setValue:[UIColor redColor] forKey:@"titleTextColor"];
    
    
    

    //按钮：取消，类型：UIAlertActionStyleCancel
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action3];
    [action3 setValue:HESHEXCOLOR(@"00a652") forKey:@"titleTextColor"];
    [self presentViewController:alert animated:YES completion:nil];
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
