//
//  ReportConsultViewController.m
//  huiErShi-iOS
//

//  Copyright © 2017年 yangsen. All rights reserved.
//

#import "ReportConsultViewController.h"
typedef enum {
    kImgContent = 0, //发出图片
    kTextContent = 1
}ChatMsgContentType;
typedef enum {
    kMessageFrom = 0, //收到消息
    kMessageTo = 1    //发出消息
}ChatMsgType;
@interface ReportConsultViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,TIMMessageListener,TIMConnListener>
{
    TIMManager *_imManger;          //IM 管理类
    TIMConversation *_conversation; //会话管理
}
@property (weak, nonatomic) IBOutlet UILabel *reportNum;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UITableView *chatTableView;
@property (weak, nonatomic) IBOutlet UITextField *msgTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendImgBtn;

@property (nonatomic, strong) UIImagePickerController *imagePicker;

@end

@implementation ReportConsultViewController

#pragma mark -- lazy
- (UIImagePickerController *)imagePicker
{
    if (_imagePicker == nil)
    {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
    }
    return _imagePicker;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initIM];
    [self setUpUI];
}
- (void)setUpUI {
    self.view.backgroundColor = HESCOLOR_THEME;
    self.navigationItem.title = @"报告咨询";
}

- (void)initIM {
    _imManger = [TIMManager sharedInstance];
    [_imManger setMessageListener:self];
    [_imManger setConnListener:self];
    [_imManger initSdk:kIM_APPID accountType:kIMACOUNT_TYPE];
    
    [self loginIM];
}
#pragma mark -- 登录IM
- (void)loginIM {
    TIMLoginParam *login_param = [[TIMLoginParam alloc] init];
    login_param.accountType = kIMACOUNT_TYPE;
    login_param.identifier = [[LSUserInfoManager sharedManager] currentUserInfo].imuserId;
    login_param.userSig = [[LSUserInfoManager sharedManager] getUserSign];
    login_param.appidAt3rd = [NSString stringWithFormat:@"%d",kIM_APPID];
    login_param.sdkAppId = kIM_APPID;
    
    [_imManger login:login_param succ:^{
        //获取当前群聊会话
        [self getConversation];
    } fail:^(int code, NSString *msg) {
        
    }];
}
//获取当前会话
- (void)getConversation {
    _conversation = [_imManger getConversation:TIM_GROUP receiver:@""];
}

#pragma mark -- 收到新消息回调
- (void)onNewMessage:(NSArray *)msgs {
    
}

#pragma mark -- 连接IM 回调
//连接成功
- (void)onConnSucc {
}

//网络连接失败
- (void)onConnFailed:(int)code err:(NSString *)err {
    
}

//网络连接断开
- (void)onDisconnect:(int)code err:(NSString *)err {
    
}

#pragma mark -- 选择相册
- (IBAction)sendImageClick:(id)sender {
    
}

#pragma mark -- 发送消息
- (IBAction)sendMsgClick:(id)sender {
    
    //发送文本消息
    TIMTextElem *text_elem = [[TIMTextElem alloc] init];
    [text_elem setText:@"我是文本消息"];
    TIMMessage *msg = [[TIMMessage alloc] init];
    [msg addElem:text_elem];
    
    //图片消息
    TIMImageElem *img_elem = [[TIMImageElem alloc] init];
    img_elem.path = @"";
    TIMMessage *msg_img = [[TIMMessage alloc] init];
    [msg_img addElem:img_elem];
    [_conversation sendMessage:msg succ:^{
        
    } fail:^(int code, NSString *msg) {
        
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
