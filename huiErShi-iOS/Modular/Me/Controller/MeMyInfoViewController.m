//
//  MeMyInfoViewController.m
//  huiErShi-iOS
//
//  Created by wanjianIOSMacMini on 2017/2/10.
//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "MeMyInfoViewController.h"
#import "MeMyInfoTableViewCell.h"
#import "ModifyNicknameViewController.h"
#import "LZCityPickerView.h"
#import "LZCityPickerController.h"

@interface MeMyInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    //定义一个imageview来等同于这个黑线
    UIImageView *navBarHairlineImageView;
    NSMutableDictionary *_userDict;
}


@property (nonatomic, strong) UITableView *infoTableView; ///< 列表
@property (nonatomic, strong) UIButton *headButton;
@end

@implementation MeMyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"个人信息";
    
    _userDict = [NSMutableDictionary dictionaryWithCapacity:1];
    [_userDict setObject:@"男" forKey:@"sex"];
    [_userDict setObject:@"大泡泡" forKey:@"name"];
    [_userDict setObject:@"月球" forKey:@"area"];
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    
    _infoTableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _infoTableView.delegate=self;
    _infoTableView.dataSource=self;
    _infoTableView.rowHeight=LayOutH(88);
    _infoTableView.backgroundColor=[UIColor clearColor];
    _infoTableView.scrollEnabled=NO;
    _infoTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _infoTableView.tableHeaderView=[self creatHeardView];
    [self.view addSubview:_infoTableView];
    
    _infoTableView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    MeMyInfoTableViewCell *cell=[MeMyInfoTableViewCell cellWithTableView:tableView];
    if (indexPath.row == 0) {
        cell.titleLab.text = @"昵称";
        if ([userDefaults objectForKey:@"nickname"]) {
            cell.contentLab.text = [userDefaults objectForKey:@"nickname"];
        } else {
            cell.contentLab.text = _userDict[@"name"];
        }
    } else if (indexPath.row == 1) {
        cell.titleLab.text = @"性别";
        if ([userDefaults objectForKey:@"sex"]) {
            cell.contentLab.text = [userDefaults objectForKey:@"sex"];
        } else {
            cell.contentLab.text = _userDict[@"sex"];
        }
        
    } else if (indexPath.row == 2) {
        cell.titleLab.text = @"地区";
        if ([userDefaults objectForKey:@"sex"]) {
            cell.contentLab.text = [userDefaults objectForKey:@"address"];
        } else {
            cell.contentLab.text = _userDict[@"area"];
        }
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
//    [self.infoTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        ModifyNicknameViewController *modifVc = [[ModifyNicknameViewController alloc] init];
        MeMyInfoTableViewCell *cell = [self.infoTableView cellForRowAtIndexPath:indexPath];
        modifVc.setName = ^(NSString *name){
            cell.contentLab.text = name;
            [_userDict setValue:name forKey:@"name"];
            if (self.setName) {
                self.setName(cell.contentLab.text);
            }
        };
        [self.navigationController pushViewController:modifVc animated:YES];
    } else if (indexPath.row == 1) {
        [self alertSexChooseWithIndexPath:indexPath];
    } else if (indexPath.row == 2) {
        [self alertAreaWithIndexPath:indexPath];
    }

}

-(UIView*)creatHeardView{
    
    UIView *heardView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, LayOutH(220))];
    
    UIImageView *infoBgImgView =[[UIImageView alloc]initWithFrame:heardView.bounds];
    infoBgImgView.image=GETIMG(@"me_bg");
    [heardView addSubview:infoBgImgView];
    
    UIButton *heardBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, LayOutW(180), LayOutW(180))];
    heardBtn.center=heardView.center;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:@"iconPhoto"]) {
        NSData *iconData = [userDefaults objectForKey:@"iconPhoto"];
        UIImage *icon = [UIImage imageWithData:iconData];
        [heardBtn setImage:icon forState:UIControlStateNormal];
    } else {
        [heardBtn setImage:GETIMG(@"heard") forState:UIControlStateNormal];
    }
    
    heardBtn.layer.masksToBounds=YES;
    heardBtn.layer.cornerRadius=LayOutW(90);
    self.headButton = heardBtn;
    [self.headButton addTarget:self action:@selector(alertHeadPortrait) forControlEvents:UIControlEventTouchUpInside];
    [heardView addSubview:heardBtn];
    
    return heardView;
}
//通过方法来找到这个黑线(findHairlineImageViewUnder):
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}
//同样的在界面出现时候开启隐藏
-(void)viewWillAppear:(BOOL)animated{
    navBarHairlineImageView.hidden = YES;
}
//在页面消失的时候就让出现
-(void)viewWillDisappear:(BOOL)animated{
    navBarHairlineImageView.hidden = NO;
}

- (void)alertHeadPortrait {
    /**
     *  弹出提示框
     */
    //初始化提示框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //按钮：从相册选择，类型：UIAlertActionStyleDefault
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
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
//    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        //初始化UIImagePickerController
//        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
//        //获取方式1：通过相册（呈现全部相册），UIImagePickerControllerSourceTypePhotoLibrary
//        //获取方式2，通过相机，UIImagePickerControllerSourceTypeCamera
//        //获取方法3，通过相册（呈现全部图片），UIImagePickerControllerSourceTypeSavedPhotosAlbum
//        PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        //允许编辑，即放大裁剪
//        PickerImage.allowsEditing = YES;
//        //自代理
//        PickerImage.delegate = self;
//        //页面跳转
//        [self presentViewController:PickerImage animated:YES completion:nil];
//    }]];
    //按钮：拍照，类型：UIAlertActionStyleDefault
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
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
//    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
//        /**
//         其实和从相册选择一样，只是获取方式不同，前面是通过相册，而现在，我们要通过相机的方式
//         */
//        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
//        //获取方式:通过相机
//        PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
//        PickerImage.allowsEditing = YES;
//        PickerImage.delegate = self;
//        [self presentViewController:PickerImage animated:YES completion:nil];
//    }]];
    //按钮：取消，类型：UIAlertActionStyleCancel
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    [action1 setValue:HESHEXCOLOR(@"00a652") forKey:@"titleTextColor"];
    [action2 setValue:HESHEXCOLOR(@"00a652") forKey:@"titleTextColor"];
    [action3 setValue:HESHEXCOLOR(@"00a652") forKey:@"titleTextColor"];
    [self presentViewController:alert animated:YES completion:nil];
}

//PickerImage完成后的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //定义一个newPhoto，用来存放我们选择的图片。
    UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    [self.headButton setImage:newPhoto forState:UIControlStateNormal];
    
    if (self.setIcon) {
        self.setIcon(newPhoto);
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *iconPhoto = UIImageJPEGRepresentation(newPhoto, 100);
    [userDefaults setObject:iconPhoto forKey:@"iconPhoto"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)alertSexChooseWithIndexPath:(nonnull NSIndexPath *)indexPath {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    MeMyInfoTableViewCell *cell = [self.infoTableView cellForRowAtIndexPath:indexPath];
    /**
     *  弹出提示框
     */
    //初始化提示框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //按钮：，类型：UIAlertActionStyleDefault
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        cell.contentLab.text = @"男";
        [userDefaults setObject:cell.contentLab.text forKey:@"sex"];
    }];
//    [alert addAction:[UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        cell.contentLab.text = @"男";
//        [userDefaults setObject:cell.contentLab.text forKey:@"sex"];
//    }]];
    //按钮：，类型：UIAlertActionStyleDefault
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        cell.contentLab.text = @"女";
        [userDefaults setObject:cell.contentLab.text forKey:@"sex"];
    }];
//    [alert addAction:[UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
//        cell.contentLab.text = @"女";
//        [userDefaults setObject:cell.contentLab.text forKey:@"sex"];
//    }]];
    //按钮：取消，类型：UIAlertActionStyleCancel
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    [action1 setValue:HESHEXCOLOR(@"00a652") forKey:@"titleTextColor"];
    [action2 setValue:HESHEXCOLOR(@"00a652") forKey:@"titleTextColor"];
    [action3 setValue:HESHEXCOLOR(@"00a652") forKey:@"titleTextColor"];
    [self presentViewController:alert animated:YES completion:nil];
    
    
}

- (void)alertAreaWithIndexPath:(nonnull NSIndexPath *)indexPath {
    MeMyInfoTableViewCell *cell = [self.infoTableView cellForRowAtIndexPath:indexPath];
    [LZCityPickerController showPickerInViewController:self selectBlock:^(NSString *address, NSString *province, NSString *city) {
        
        // 选择结果回调
        cell.contentLab.text = address;
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:cell.contentLab.text forKey:@"address"];
//        [_userDict setValue:address forKey:@"area"];
        NSLog(@"%@--%@--%@",address,province,city);
        
    }];
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
